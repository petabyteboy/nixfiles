{ pkgs, ... }:
{
  environment                           =
  {
    systemPackages                      =   with pkgs;
    [
      dino
      discord
      mumble
      tdesktop
      weechat
    ];
  };
}
