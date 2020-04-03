let
  this                                  =   import  ./this.nix;
  master                                =   true;
  masters                               =   [ ];
  slaves                                =
  [
    "2a0f:4ac0::1"
    "2a0f:4ac0::4"
    "2a0f:4ac0::5" 
  ];
in
  { ... }:
  {
    networking                          =
    {
      defaultGateway6                   =
      {
        address                         =   "fe80::1";
        interface                       =   "ens3";
      };

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

      interfaces                        =
      {
        ens3.useDHCP                    =   true;
        ens3.ipv6.addresses             =
        [
          {
            address                     =   "2a01:4f9:c010:6bf5::23";
            prefixLength                =   64;
          }
        ];
      };

      useDHCP                           =   false;
    };

    services.bind                       =
    {
      enable                            =   true;
      forwarders                        =   [ ];
      cacheNetworks                     =   [ ];
      zones                             =
      [
        {
          name                          =   this.domain;
          file                          =   "${./zones}/${this.domain}";
          inherit master masters slaves;
        }
      ];
    };
  }
