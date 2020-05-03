{ pkgs, ... }:
{
  environment                           =
  {
    systemPackages                      =   with pkgs;
    [
      playonlinux
      qemu
      wine
    ];
  };
}
