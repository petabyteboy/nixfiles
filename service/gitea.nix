let
  self                                  =   import  ./self.nix;
in
  { config, ... }:
  {
    services                            =
    {
      gitea                             =
      {
        appName                         =   "_sivizius’ Gitea";
        cookieSecure                    =   true;
        database                        =
        {
          type                          =   "postgres";
          name                          =   "gitea";
          user                          =   "gitea";
        };
        disableRegistration             =   false;
        domain                          =   "git.${self.domain}";
        enable                          =   true;
        extraConfig                     =
        ''
          [metrics]
          ENABLED                       =   true
          TOKEN                         =   ${  ( builtins.readFile ./secret/gitea.token ) }
          [picture]
          DISABLE_GRAVATAR              =   true
          [server]
          START_SSH_SERVER              =   true
          BUILTIN_SSH_SERVER_USER       =   gitea
          SSH_LISTEN_PORT               =   2222
          [ui]
          DEFAULT_THEME                 =   arc-green
        '';
        httpAddress                     =   "localhost";
        log.level                       =   "Warn";
        rootUrl                         =   "https://git.${self.domain}/";
      };

      nginx                             =
      {
        virtualHosts                    =
        {
          "git.${self.domain}"          =
          {
            enableACME                  =   true;
            extraConfig                 =   config.services.nginx.virtualHosts."${self.domain}".extraConfig;
            forceSSL                    =   true;
            locations."/".proxyPass     =   "http://localhost:${toString self.ports.gitea}/";
          };
        };
      };

      postgresql                        =
      {
        enable                          =   true;
        ensureDatabases                 =   [ "gitea" ];
        ensureUsers                     =
        [
          {
            name                        =   "gitea";
            ensurePermissions           =
            {
              "DATABASE gitea"          =   "ALL PRIVILEGES";
            };
          }
        ];
      };

      prometheus                        =
      {
        scrapeConfigs                   =
        [
          {
            bearer_token_file           =   "${ ./secret/gitea.token }";
            job_name                    =   "gitea";
            metrics_path                =   "/metrics";
            scheme                      =   "https";
            scrape_interval             =   "30s";
            static_configs              =
            [
              {
                targets                 =
                [
                  "git.${self.domain}"
                ];
              }
            ];
          }
        ];
      };
    };
  }
