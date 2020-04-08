let
  this                                  =   import  ./this.nix;
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
      defaultGateway6                   =
      {
        address                         =   "fe80::1";
        interface                       =   "ens3";
      };

      firewall                          =
      {
        allowedTCPPorts                 =
        [
          25                            # smtp
          53                            # dns
          80                            # http
          110                           # pop3
          143                           # imap
          443                           # https
          465                           # smtps
          587                           # smtp starttls
          993                           # imaps
          995                           # pop3s
        ];
        allowedUDPPorts                 =
        [
          53                            # dns
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
              address                   =   "${this.ipv6}:23";
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

    security.acme                       =
    {
      acceptTerms                       =   true;
      email                             =   "cert@sivizius.eu";
      # Remove This to Use Real ACME-Server
#      server                            =   "https://acme-staging-v02.api.letsencrypt.org/directory";
    };

    services.openssh.enable             =   true;

    systemd.services                    =
    {
      "acme-sivizius.eu".after          =   [ "bind"  ];
      "acme-blog.sivizius.eu".after     =   [ "bind"  ];
      "acme-git.sivizius.eu".after      =   [ "bind"  ];
      "acme-mail.sivizius.eu".after     =   [ "bind"  ];
    };
  }
