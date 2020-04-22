let
  this                                  =   import  ../this.nix;
in
  { config, ... }:
  {
    imports                             =
    [
      "${../.}/${this.hostName}/networking.nix"
    ];
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
          80                            # http
          443                           # https
        ];
        allowedUDPPorts                 =
        [
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
              address                   =   "${this.ipv6}";
              prefixLength              =   64;
            }
          ];
          useDHCP                       =   true;
        };
      };

      useDHCP                           =   false;
    };

    security.acme                       =
    {
      acceptTerms                       =   true;
      email                             =   "cert@${this.domain}";
    };

    services                            =
    {
      prometheus                        =
      {
        exporters                       =
        {
          nginx                         =
          {
            enable                      =   true;
            port                        =   this.ports.exporters.nginx;
          };
          node                          =
          {
            enable                      =   true;
            port                        =   this.ports.exporters.node;
          };
        };
      };

      nginx                             =
      {
        virtualHosts                    =
        {
          ${this.hostDomain}            =
          {
            enableACME                  =   true;
            extraConfig                 =   config.services.nginx.virtualHosts."${this.domain}".extraConfig;
            forceSSL                    =   true;
            locations                   =
            {
              "/metrics/nginx"          =
              {
                extraConfig             =
                ''
                  allow ${this.ipv6range}:/64;
                  allow ${this.ipv4};
                  deny all;
                '';
                proxyPass               =   "http://localhost:${toString this.ports.exporters.nginx}/metrics";
              };
              "/metrics/node"           =
              {
                extraConfig             =
                ''
                  allow ${this.ipv6range}:/64;
                  allow ${this.ipv4};
                  deny all;
                '';
                proxyPass               =   "http://localhost:${toString this.ports.exporters.node}/metrics";
              };
            };
          };
        };
      };

      openssh.enable                    =   true;
      vnstat.enable                     =   true;
    };
  }
