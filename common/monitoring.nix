let
  this                                  =   import  ../this.nix;
in
  { config, ... }:
  {
    services                            =
    {
      grafana                           =
      {
        auth.anonymous.enable           =   true;
        domain                          =   "grafana.${this.domain}";
        enable                          =   true;
        port                            =   this.ports.grafana;
        provision                       =
        {
          dashboards                    =
          [
            {
              options.path              =   ./dashboards;
            }
          ];

          datasources                   =
          [
            {
              isDefault                 =   true;
              name                      =   "Prometheus";
              type                      =   "prometheus";
              url                       =   "http://localhost:${toString this.ports.prometheus}/";
            }
          ];
        };
        rootUrl                         =   "https://grafana.${this.domain}/";
      };

      nginx                             =
      {
        virtualHosts                    =
        {
          "grafana.${this.domain}"      =
          {
            enableACME                  =   true;
            forceSSL                    =   true;
            locations."/".proxyPass     =   "http://localhost:${toString this.ports.grafana}/";
          };

          "prometheus.${this.domain}"   =
          {
            enableACME                  =   true;
            extraConfig                 =
            ''
              allow ${this.ipv6range}::/64;
              allow ${this.ipv4};
              deny all;
            '';
            forceSSL                    =   true;
            locations."/".proxyPass     =   "http://localhost:${toString this.ports.prometheus}/";
          };
        };
      };

      prometheus                        =
      {
        enable                          =   true; 
        exporters                       =
        {
          bind                          =
          {
            enable                      =   true;
            port                        =   this.ports.exporters.bind;
          };
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
        globalConfig.scrape_interval    =   "5s";
        webExternalUrl                  =   "https://prometheus.${this.domain}/";
      };
    };

    services.journald.extraConfig       =
    ''
      MaxRetentionSec                   =   "3day"
    '';
  }
