let
  this                                  =   import  ./this.nix;
in
  { config, ... }:
  {
    services
    {
      gitea                             =
      {
        appName                         =   "_sivizius’ Gitea";
        cookieSecure                    =   false;                              # change to true if possible
        disableRegistration             =   true;
        domain                          =   "git.${this.domain}";
        enable                          =   true;
        httpAddress                     =   "127.0.0.1";
        log.level                       =   "Warn";
        rootUrl                         =   "https://git.${this.domain}/";
      };

      nginx.virtualHosts                =
      {
        "git.${this.domain}"            =
        {
          enableACME                    =   false;                              # change to true if possible
          forceSSL                      =   false;                              # change to true if possible
          locations."/".proxyPass       =   "http://127.0.0.1:3000";
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
              "DATABASE gitea"          = "ALL PRIVILEGES";
            };
          }
        ];
      };
    };
  }
