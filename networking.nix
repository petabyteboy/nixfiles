let
  this                                  =   import ./this.nix;
in
  { ... }:
  {
    networking                          =
    {
      firewall                          =
      {
        allowedTCPPorts                 =
        [
          53    # dns
          80    # http
          443   # https
        ];
        allowedUDPPorts                 =
        [
          53    # dns
        ];
      };
      hostName                          =   this.hostName;
      interfaces.ens3.useDHCP           =   true;
      useDHCP                           =   false;
    };
  }
