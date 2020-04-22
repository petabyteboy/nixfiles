let
  this                                  =   import  ../this.nix;
in
  { config, ... }:
  {
    services                            =
    {
      nginx                             =
      {
        enable                          =   true;
        virtualHosts                    =
        {
          "blog.${this.domain}"         =
          {
            enableACME                  =   true;
            extraConfig                 =   config.services.nginx.virtualHosts."${this.domain}".extraConfig;
            forceSSL                    =   true;
            locations."/".root          =   "/var/blog/";
          };
        };
      };
    };
  }
