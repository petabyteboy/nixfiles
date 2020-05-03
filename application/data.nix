{ pkgs, ... }:
{
  environment                           =
  {
    systemPackages                      =   with pkgs;
    [
      gnumeric
      gnuplot
      graphviz
    ];
  };
}
