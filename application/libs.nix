{ pkgs, ... }:
{
  environment                           =
  {
    systemPackages                      =   with pkgs;
    [
      atk.dev
      binutils
      gdk-pixbuf.dev
      gtk3.dev
      libappindicator-gtk3
      libarchive
      openssl
      pango.dev
      patchelf
      pkg-config
      stdenv
    ];
  };
}
