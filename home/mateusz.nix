{ pkgs, ... }:

{
  programs.home-manager.enable = true;
  home.stateVersion = "26.05";

  home.username = "mateusz";
  home.homeDirectory = "/home/mateusz";

  home.packages = with pkgs; [
    just
    nixfmt
    neovim
  ];

  imports = [
    ./modules/git.nix
    ./modules/keepassxc.nix
    ./modules/zsh.nix
  ];
}
