{ pkgs, ... }:
{
  environment                           =
  {
    systemPackages                      =   with pkgs;
    [
      clang
      gcc
      glib
      glibc
      lua
      nim
      python3
      python37Packages.pwntools
      python37Packages.pygments
      python37Packages.pyserial
      python37Packages.python-language-server
      rustup
    ];
  };
}
