{ pkgs, ... }:
{
  environment                           =
  {
    shellInit                           =
    ''
      ELECTRON_TRASH=gio
    '';
    systemPackages                      =   with pkgs;
    [
      atom
    ];
  };
}
