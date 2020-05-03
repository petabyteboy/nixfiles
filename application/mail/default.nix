{ pkgs, ... }:
{
  environment                           =
  {
    systemPackages                      =   with pkgs;
    [
      isync
      mailcap
      neomutt
    ];
  };
}
