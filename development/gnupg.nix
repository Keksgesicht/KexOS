{ ... }:

# https://mikeross.xyz/create-gpg-key-pair-with-subkeys/
# https://github.com/drduh/YubiKey-Guide?tab=readme-ov-file#updating-keys
{
  # make signed commits
  services.pcscd.enable = true;
  programs.gnupg.agent.enable = true;

  /*
  gpg --full-generate-key

  GPG_HOMEDIR=$(mktemp -d)
  gpg --homedir $GPG_HOMEDIR ...

  gpg --import ~/.secrets/gpg/<mail>.secret.gpg
  gpg --list-keys

  gpg --edit-key <mail>
  > key 1
  > key 2
  > expire
  > save

  gpg --export-secret-keys    <mail> > ~/.secrets/gpg/<mail>.secret.gpg
  gpg --export-secret-subkeys <mail> > ~/.secrets/gpg/<mail>.secsub.gpg
  gpg --armor --export        <mail> > ~/.secrets/gpg/<mail>.public.gpg

  gpg --fingerprint <mail> | head -n 2 | tail -n 1
  gpg --armor --export <mail> > ~/.secrets/gpg/<mail>.pubkey.gpg
  gpg --keyserver keys.openpgp.org --send-key <mail>
  */
}
