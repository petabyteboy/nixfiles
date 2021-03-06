let
  self                                  =   import  self.nix;
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

      interfaces                        =
      {
        ens3                            =
        {
          ipv6.addresses                =
          [
            {
              address                   =   "${self.ipv6}";
              prefixLength              =   64;
            }
          ];
          useDHCP                       =   true;
        };
      };
    };

    services                            =
    {
      bind                              =
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
            name                          =   self.domain;
            file                          =   "${./zones}/${self.domain}";
            inherit master masters slaves;
          }
        ];
      };

      nginx                             =
      {
        virtualHosts                    =
        {
          ${self.hostDomain}            =
          {
            locations                   =
            {
              "/metrics/bind"           =
              {
                extraConfig             =
                ''
                  allow ${self.ipv6range}:/64;
                  allow ${self.ipv4};
                  deny all;
                '';
                proxyPass               =   "http://localhost:${toString self.ports.exporters.bind}/metrics";
              };
            };
          };
        };
      };

      prometheus                        =
      {
        exporters                       =
        {
          bind                          =
          {
            enable                      =   true;
            port                        =   self.ports.exporters.bind;
          };
        };
        scrapeConfigs                   =
        [
          {
            job_name                    =   "bind";
            metrics_path                =   "/metrics/bind";
            scheme                      =   "https";
            scrape_interval             =   "30s";
            static_configs              =
            [
              {
                targets                 =
                [
                  "${self.hostDomain}"
                ];
              }
            ];
          }
        ];
      };
    };

    systemd                             =
    {
      services                          =
      {
        "acme-${self.domain}"           =
        {
          after                         =   [ "bind.service"  ];
        };
        "acme-${self.hostDomain}"       =
        {
          after                         =   [ "bind.service"  ];
        };
        "acme-blog.${self.domain}"      =
        {
          after                         =   [ "bind.service"  ];
        };
        "acme-git.${self.domain}"       =
        {
          after                         =   [ "bind.service"  ];
        };
        "acme-grafana.${self.domain}"   =
        {
          after                         =   [ "bind.service"  ];
        };
        "acme-prometheus.${self.domain}"=
        {
          after                         =   [ "bind.service"  ];
        };
      };
    };
  }
