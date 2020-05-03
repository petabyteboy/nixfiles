{ pkgs, ... }:
{
  environment                           =
  {
    systemPackages                      =   with pkgs;
    [
      cryptsetup
      ecdsautils
      keyutils
      pwgen-secure
    ];
  };
}
