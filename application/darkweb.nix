{ pkgs, ... }:
{
  environment                           =
  {
    systemPackages                      =   with pkgs;
    [
      i2p
      tor
      tor-browser-bundle-bin
    ];
  };
}
