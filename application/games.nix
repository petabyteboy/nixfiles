{ pkgs, ... }:
{
  environment                           =
  {
    systemPackages                      =   with pkgs;
    [
      jdk13                             # for minecraft
      multimc
      sauerbraten
      xonotic
    ];
  };
}
