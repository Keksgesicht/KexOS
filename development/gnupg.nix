{ ... }:

# https://mikeross.xyz/create-gpg-key-pair-with-subkeys/
# https://github.com/drduh/YubiKey-Guide?tab=readme-ov-file#updating-keys
{
  # make signed commits
  services.pcscd.enable = true;
  programs.gnupg.agent.enable = true;

  /*
  gpg --full-generate-key

  gpg --homedir $(mktemp -d) --import ~/.secrets/gpg/<mail>.secret.gpg
  gpg --list-keys
  gpg --edit-key <mail>

  gpg --fingerprint <mail> | head -n 2 | tail -n 1
  gpg --armor --export <mail> > ~/.secrets/gpg/<mail>.pubkey.gpg
  gpg --keyserver keys.openpgp.org --send-key <mail>

  gpg --export-secret-keys    <mail> > ~/.secrets/gpg/<mail>.secret.gpg
  gpg --export-secret-subkeys <mail> > ~/.secrets/gpg/<mail>.secsub.gpg
  */
}
