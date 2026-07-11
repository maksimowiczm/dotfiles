{ pkgsUnstable, ... }:

{
  home.packages = with pkgsUnstable; [ android-studio ];
}
