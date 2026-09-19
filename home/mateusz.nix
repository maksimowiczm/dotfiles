{ pkgs, ... }:

{
  programs.home-manager.enable = true;
  home.stateVersion = "26.05";

  home.username = "mateusz";
  home.homeDirectory = "/home/mateusz";

  home.packages = [
    pkgs.jetbrains-toolbox
    pkgs.nixfmt
    pkgs.just
  ];

  imports = [
    # ./modules/android.nix
    ./modules/firefox.nix
    # ./modules/ghostty.nix
    ./modules/git.nix
    ./modules/keepassxc.nix
    # ./modules/plasma.nix
    ./modules/vscode.nix
    ./modules/zsh.nix
  ];
}
