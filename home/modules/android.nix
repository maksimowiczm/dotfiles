{ pkgsUnstable, ... }:

{
  home.packages = with pkgsUnstable; [
    androidStudioPackages.canary
  ];
}
