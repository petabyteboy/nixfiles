{ pkgs, ... }:
{
  environment                           =
  {
    systemPackages                      =   with pkgs;
    [
      cpufrequtils
      brightnessctl
      flashrom
      gpsd
      linuxPackages.tp_smapi
      pciutils
      powertop
      tlp
      usbutils
    ];
  };
}
