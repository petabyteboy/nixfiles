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
          80    # http
          443   # tls
        ];
        allowedUDPPorts                 =
        [
          53    # dns
        ];
      };
      
      hostName                          =   this.hostName;

      interfaces                        =
      {
        ens3                            =
        {
          ipv6.addresses                =
          [
            {
              address                   =   "2a01:4f9:c010:6bf5::23";
              prefixLength              =   64;
            }
          ];
          useDHCP                       =   true;
        };
      };

      useDHCP                           =   false;
    };

    services.bind                       =
    {
      enable                            =   true;
      forwarders                        =
      [
        "2a01:4f8:0:1::add:1010"
        "2a01:4f8:0:1::add:9999"
        "2a01:4f8:0:1::add:9898"
        "2001:4860:4860::8888"
        "2001:4860:4860::8844"
        "213.133.98.98"
        "213.133.99.99"
        "213.133.100.100"
        "8.8.8.8"
        "8.8.4.4"
      ];
      cacheNetworks                     =
      [
        "127.0.0.0/8"
        "::/64"
      ];
      zones                             =
      [
        {
          name                          =   this.domain;
          file                          =   "${./zones}/${this.domain}";
          inherit master masters slaves;
        }
      ];
    };

    security.acme                       =
    {
      acceptTerms                       =   true;
      email                             =   "cert@sivizius.eu";
      # Remove This to Use Real ACME-Server
#      server                            =   "https://acme-staging-v02.api.letsencrypt.org/directory";
    };

    services.openssh.enable             =   true;
  }
