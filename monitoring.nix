let
  this                                  =   import  ./this.nix;
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
              url                       =   "http://127.0.0.1:${toString this.ports.prometheus}/";
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
            locations."/".proxyPass     =   "http://127.0.0.1:${toString this.ports.grafana}/";
          };

          "prometheus.${this.domain}"   =
          {
            enableACME                  =   true;
            # extraConfig                 =   config.services.nginx.virtualHosts."${config.networking.hostName}.pbb.lc".locations."/node-exporter/metrics".extraConfig;
            forceSSL                    =   true;
            locations."/".proxyPass     =   "http://127.0.0.1:${toString this.ports.prometheus}/";
          };
        };
      };

      prometheus                        =
      {
        enable                          =   true; 
        exporters                       =
        {
          bind.enable                   =   true;
        };
        globalConfig.scrape_interval    =   "5s";
        webExternalUrl                  =   "https://prometheus.${this.domain}/";
      };
    };
  }
