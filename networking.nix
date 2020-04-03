let
  this                                  =   import  ./this.nix;
  master                                =   true;
  masters                               =   [ ];
  slaves                                =
  [
  ];
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
        ];
        allowedUDPPorts                 =
        [
          53    # dns
        ];
      };
      hostName                          =   this.hostName;
      interfaces.ens3.useDHCP           =   true;
      nameservers                       =   [ "127.0.0.1" ];
      useDHCP                           =   false;
    };

    services.bind                       =
    {
      enable                            =   true;
      forwarders                        =
      [
      ];
      cacheNetworks                     =
      [
      ];
      zones                             =
      [
        {
          name                          =   this.domain;
          file                          =   "./zones/${this.domain}";
          inherit master masters slaves;
        }
      ];
    };
  }
