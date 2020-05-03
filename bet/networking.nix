{ pkgs, ... }:
{
  environment                           =
  {
    systemPackages                      =   with pkgs;
    [
      bind
      gnome3.networkmanagerapplet
      gnome3.networkmanager-openvpn
      modemmanager
      networkmanagerapplet
      openconnect
      tightvnc
      w3m
    ];
  };

  networking                            =
  {
    interfaces                          =
    {
      enp0s25.useDHCP                   =   true;
      wlp3s0.useDHCP                    =   true;
      wwp0s20u4i6.useDHCP               =   true;
    };
    networkmanager.enable               =   true;
  };

  services                              =
  {
    udev.extraRules                     =
    ''
      ATTRS{idVendor}=="0bdb", ATTRS{idProduct}=="1926", ENV{ID_USB_INTERFACE_NUM}=="09", ENV{MBM_CAPABILITY}="gps_nmea"
      ATTRS{idVendor}=="0bdb", ATTRS{idProduct}=="1926", ENV{ID_USB_INTERFACE_NUM}=="03", ENV{MBM_CAPABILITY}="gps_ctrl"
    '';
  };
}
