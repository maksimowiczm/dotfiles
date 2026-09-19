user := "mateusz"

default:
    @just --list

home user=user:
    @nix run github:nix-community/home-manager/release-26.05 -- switch --flake .#{{user}}

format:
    @find . -type f -name "*.nix" -exec nixfmt {} \;

update:
    @nix flake update
