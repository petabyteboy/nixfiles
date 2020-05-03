{ pkgs, ... }:
{
  environment                           =
  {
    systemPackages                      =   with pkgs;
    [
      cmatrix
      fortune
    ];
  };
}
