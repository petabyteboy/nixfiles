let
  self                                  =   import  ./self.nix;
in
  { config, ... }:
  {
    services                            =
    {
      grafana                           =
      {
        auth.anonymous.enable           =   true;
        domain                          =   "grafana.${self.domain}";
        enable                          =   true;
        port                            =   self.ports.grafana;
        provision                       =
        {
          enable                        =   true;
          datasources                   =
          [
            {
              isDefault                 =   true;
              name                      =   "Prometheus";
              type                      =   "prometheus";
              url                       =   "https://prometheus.${self.domain}/";
            }
          ];
          dashboards                    =
          [
            {
              options.path              =   ../dashboards;
            }
          ];
        };
        rootUrl                         =   "https://grafana.${self.domain}/";
      };

      journald.extraConfig              =
      ''
        MaxRetentionSec                 =   "3day"
      '';

      nginx                             =
      {
        virtualHosts                    =
        {
          "${self.hostDomain}"          =
          {
            enableACME                  =   true;
            extraConfig                 =   config.services.nginx.virtualHosts."${self.domain}".extraConfig;
            forceSSL                    =   true;
            locations                   =
            {
              "/metrics/nginx"          =
              {
                extraConfig             =
                ''
                  allow ${self.ipv6range}:/64;
                  allow ${self.ipv4};
                  deny all;
                '';
                proxyPass               =   "http://localhost:${toString self.ports.exporters.nginx}/metrics";
              };
              "/metrics/node"           =
              {
                extraConfig             =
                ''
                  allow ${self.ipv6range}:/64;
                  allow ${self.ipv4};
                  deny all;
                '';
                proxyPass               =   "http://localhost:${toString self.ports.exporters.node}/metrics";
              };
            };
          };

          "grafana.${self.domain}"      =
          {
            enableACME                  =   true;
            forceSSL                    =   true;
            locations."/".proxyPass     =   "http://localhost:${toString self.ports.grafana}/";
          };

          "prometheus.${self.domain}"   =
          {
            enableACME                  =   true;
            extraConfig                 =   config.services.nginx.virtualHosts."${self.domain}".extraConfig;
            forceSSL                    =   true;
            locations                   =
            {
              "/"                       =
              {
                extraConfig             =
                ''
                  allow ${self.ipv6range}:/64;
                  allow ${self.ipv4};
                  #deny all;
                '';
                proxyPass               =   "http://localhost:${toString self.ports.prometheus}/";
                proxyWebsockets         =   true;
              };
            };
          };
        };
      };

      prometheus                        =
      {
        enable                          =   true;
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
        scrapeConfigs                   =
        [
          {
            job_name                    =   "nginx";
            metrics_path                =   "/metrics/nginx";
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
          {
            job_name                    =   "node";
            metrics_path                =   "/metrics/node";
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

      vnstat.enable                     =   true;
    };
  }
