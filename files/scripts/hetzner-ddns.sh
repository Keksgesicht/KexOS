#!/usr/bin/env bash

# own modified version of https://github.com/filiparag/hetzner_ddns
# https://docs.hetzner.cloud/reference/cloud#dns

self='hetzner-ddns.service'
api_ip='https://ip.hetzner.com/'

test_configuration() {
    records_escaped="$(echo "$records" | sed 's:\*:\\\*:g')"

    if [ -z "$TTL" ] || [ "$TTL" -lt 30 ]; then
        logger -t $self -p 5 \
            'Info: TTL is invalid, defaulting to 1000 seconds'
        TTL=1000
    fi
    if [ -z "$HCLOUD_TOKEN" ]; then
        logger -t $self -p 3 'Error: API key is not set, unable to proceed'
        exit 78
    fi
    if [ -z "$domain" ]; then
        logger -t $self -p 3 'Error: Domain is not set, unable to proceed'
        exit 78
    fi
    if [ -z "$records" ]; then
        logger -t $self -p 4 'Warning: Records are not set, exiting cleanly'
        exit 11
    fi
}

test_api_key() {
    if hcloud all list >/dev/null |& grep -q 'no active context or token'; then
        logger -t $self -p 3 'Error: Invalid API key'
        exit 22
    fi
}

get_zone() {
    if hcloud zone describe "${domain}" >/dev/null |& grep -q 'Zone not found'; then
        zone=""
        logger -t $self -p 3 "Error: Unable to fetch zone ID for domain $domain"
        return 1
    else
        zone=$(hcloud zone describe "${domain}" --output json | jq -r '.id')
        logger -t $self "Zone for ${domain}: $zone"
        return 0
    fi
}

get_record() {
    if [ -n "$zone" ]; then
        record_ipv4=$(hcloud zone rrset describe "${domain}" "$1" 'A' --output json |
            jq -r '.records[0].value')
        record_ipv6=$(hcloud zone rrset describe "${domain}" "$1" 'AAAA' --output json |
            jq -r '.records[0].value')
    fi
    if [ -z "$record_ipv4" ] && [ -z "$record_ipv6" ]; then
        return 1
    else
        logger -t $self "IPv4 record for ${1}.${domain}: ${record_ipv4:-(missing)}"
        logger -t $self "IPv6 record for ${1}.${domain}: ${record_ipv6:-(missing)}"
        return 0
    fi
}

get_records() {
    # Get all record IDs
    for current_record in $records_escaped; do
        current_record="$(echo "$current_record" | sed 's:\\::')"
        if get_record "$current_record"; then
            records_ipv4="$records_ipv4$current_record=$record_ipv4 "
            records_ipv6="$records_ipv6$current_record=$record_ipv6 "
        else
            logger -t $self -p 4 \
                "Warning: Missing both A and AAAA records for $current_record.$domain"
        fi
    done
    if [ -z "$records_ipv4" ] && [ -z "$records_ipv6" ]; then
        logger -t $self -p 3 "Error: No applicable records found $domain"
        return 1
    fi
}

get_record_ip_addr() {
    # Get record's IP address
    if [ -z "$record_ipv4" ]; then
        logger -t $self -p 4 \
            "Warning: Unable to fetch previous IPv4 address for $current_record.$domain"
        ipv4_rec=''
    else
        ipv4_rec="$record_ipv4"
    fi
    if [ -z "$record_ipv6" ]; then
        logger -t $self -p 4 \
            "Warning: Unable to fetch previous IPv6 address for $current_record.$domain"
        ipv6_rec=''
    else
        ipv6_rec="$record_ipv6"
    fi
    if [ -z "$record_ipv4" ] && [ -z "$record_ipv4" ]; then
        return 1
    fi

}

get_my_ip_addr() {
    # Get current public IP address
    ipv4_cur="$(
        curl -4 $api_ip 2>/dev/null
    )"

    # wierd privacy fix
    ipv6_cur="$(
        ip -6 addr show "${MY_IFLINK}" 2>/dev/null |
            awk '$1 == "inet6" && $2 !~ /^fe80:/ && $2 !~ /^f[cd]/ &&
            /'"${MY_IPV6_SUFFIX}"'/ {gsub(/\/.*$/, "", $2); print $2}' |
            head -1
    )"
    if [ -z "$ipv6_cur" ]; then
        ipv6_cur="$(
            curl -6 $api_ip 2>/dev/null | sed 's/:$/:1/g'
        )"
    fi

    if [ -z "$ipv4_cur" ] && [ -z "$ipv6_cur" ]; then
        logger -t $self -p 3 'Error: Unable to fetch current self IP address'
        return 1
    fi
}

set_record() {
    # Update record if IP address has changed
    if [ -n "$record_ipv4" ] && [ -n "$ipv4_cur" ] && [ "$ipv4_cur" != "$ipv4_rec" ]; then
        hcloud zone rrset set-records "$domain" "$current_record" 'A' --record "$ipv4_cur" &&
            logger -t $self "Update IPv4 for $current_record.$domain: $ipv4_rec => $ipv4_cur"
    fi
    if [ -n "$record_ipv6" ] && [ -n "$ipv6_cur" ] && [ "$ipv6_cur" != "$ipv6_rec" ]; then
        hcloud zone rrset set-records "$domain" "$current_record" 'AAAA' --record "$ipv6_cur" &&
            logger -t $self "Update IPv6 for $current_record.$domain: $ipv6_rec => $ipv6_cur"
    fi
}

pick_record() {
    # Get record ID from array
    echo "$2" |
        awk "{
        for(i=1;i<=NF;i++){
            n=\$i;gsub(/=.*/,\"\",n);
            r=\$i;gsub(/.*=/,\"\",r);
            if(n==\"$1\"){
                print r;break
            }
        }}"
}

set_records() {
    # Get my public IP address
    if get_my_ip_addr; then
        # Update all records if possible
        for current_record in $records_escaped; do
            current_record="$(echo "$current_record" | sed 's:\\::')"
            record_ipv4="$(pick_record "$current_record" "$records_ipv4")"
            record_ipv6="$(pick_record "$current_record" "$records_ipv6")"
            if [ -n "$record_ipv4" ] || [ -n "$record_ipv6" ]; then
                get_record_ip_addr && set_record
            fi
        done
    fi
}

run_ddns() {
    test_configuration
    test_api_key

    while ! get_zone || ! get_records; do
        sleep $((TTL / 2))
        logger -t $self 'Retrying to fetch zone and record data'
    done

    set_records
}

run_ddns
