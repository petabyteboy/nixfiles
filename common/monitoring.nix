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
          enable                        =   true;
          datasources                   =
          [
            {
              isDefault                 =   true;
              name                      =   "Prometheus";
              type                      =   "prometheus";
              url                       =   "https://prometheus.${this.domain}/";
            }
          ];
          dashboards                    =
          [
            {
              options.path              =   ../dashboards;
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
            extraConfig                 =   config.services.nginx.virtualHosts."${this.domain}".extraConfig;
            forceSSL                    =   true;
            locations                   =
            {
              "/"                       =
              {
                extraConfig             =
                ''
                  allow ${this.ipv6range}:/64;
                  allow ${this.ipv4};
                  #deny all;
                '';
                proxyPass               =   "http://localhost:${toString this.ports.prometheus}/";
                proxyWebsockets         =   true;
              };
            };
          };
        };
      };

      prometheus                        =
      {
        enable                          =   true; 
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
                  "${this.hostDomain}"
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
                  "${this.hostDomain}"
                ];
              }
            ];
          }
        ];
      };
    };

    services.journald.extraConfig       =
    ''
      MaxRetentionSec                   =   "3day"
    '';
  }
