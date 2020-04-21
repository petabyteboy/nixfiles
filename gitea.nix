let
  this                                  =   import  ./this.nix;
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
        domain                          =   "git.${this.domain}";
        enable                          =   true;
        extraConfig                     =
        ''
          [metrics]
          ENABLED                       =   true
          [picture]
          DISABLE_GRAVATAR              =   true
          [server]
          START_SSH_SERVER              =   true
          BUILTIN_SSH_SERVER_USER       =   gitea
          SSH_LISTEN_PORT               =   2222
          [ui]
          DEFAULT_THEME                 =   arc-green
        '';
        httpAddress                     =   "127.0.0.1";
        log.level                       =   "Warn";
        rootUrl                         =   "https://git.${this.domain}/";
      };

      nginx.virtualHosts                =
      {
        "git.${this.domain}"            =
        {
          enableACME                    =   true;
          forceSSL                      =   true;
          locations."/".proxyPass       =   "http://127.0.0.1:${toString this.ports.gitea}/";
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
    };
  }
