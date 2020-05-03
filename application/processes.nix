{ pkgs, ... }:
{
  environment                           =
  {
    systemPackages                      =   with pkgs;
    [
      parallel
      progress
      pv
    ];
  };
}
