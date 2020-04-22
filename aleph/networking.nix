let
  this                                  =   import  ../this.nix;
  master                                =   true;
  masters                               =   [ ];
  slaves                                =
  [
    "2a0f:4ac0::1"                      # ns1.pbb.lc
    "2a0f:4ac0::4"                      # ns2.pbb.lc
    "2a0f:4ac0::5"                      # ns3.pbb.lc
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
          53                            # dns
        ];
        allowedUDPPorts                 =
        [
          53                            # dns
        ];
      };
    };

    services.bind                       =
    {
      enable                            =   true;
      forwarders                        =
      [
        "2a01:4f8:0:1::add:1010"        # Hetzner
        "2a01:4f8:0:1::add:9999"        # Hetzner
        "2a01:4f8:0:1::add:9898"        # Hetzner
        "2001:4860:4860::8888"          # Google
        "2001:4860:4860::8844"          # Google
        "213.133.98.98"                 # Hetzner
        "213.133.99.99"                 # Hetzner
        "213.133.100.100"               # Hetzner
        "8.8.8.8"                       # Google
        "8.8.4.4"                       # Google
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

    systemd                             =
    {
      services                          =
      {
        "acme-${this.domain}"           =
        {
          after                         =   [ "bind.service"  ];
        };
        "acme-${this.hostDomain}"       =
        {
          after                         =   [ "bind.service"  ];
        };
        "acme-blog.${this.domain}"      =
        {
          after                         =   [ "bind.service"  ];
        };
        "acme-git.${this.domain}"       =
        {
          after                         =   [ "bind.service"  ];
        };
        "acme-grafana.${this.domain}"   =
        {
          after                         =   [ "bind.service"  ];
        };
        "acme-prometheus.${this.domain}"=
        {
          after                         =   [ "bind.service"  ];
        };
      };
    };
  }
