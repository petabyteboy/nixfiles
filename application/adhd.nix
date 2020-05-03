{ pkgs, ... }:
{
  environment                           =
  {
    systemPackages                      =   with pkgs;
    [
      calcurse
      tasknc
      taskwarrior
    ];
  };
}
