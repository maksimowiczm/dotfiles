hostname := trim(shell("cat /etc/hostname"))

default:
    @just --list

switch hostname=hostname:
    @sudo nixos-rebuild switch --flake .#{{hostname}}

test hostname=hostname:
    @sudo nixos-rebuild test --flake .#{{hostname}}

cryptenroll disk:
    @sudo systemd-cryptenroll \
        --tpm2-device=auto \
        --tpm2-pcrlock=/var/lib/systemd/pcrlock.json \
        {{disk}}

format:
    @find . -type f -name "*.nix" -exec nixfmt {} \;

update:
    @nix flake update
