{ pkgs, ... }:
{
  fonts.fonts                           =   with pkgs;
  [
    dejavu_fonts
    font-awesome_5
    liberation_ttf
    noto-fonts
    noto-fonts-emoji
    roboto
    roboto-mono
    roboto-slab
  ];
}
