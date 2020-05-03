let
  self                                  =   import  ./self.nix;
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
          "blog.${self.domain}"         =
          {
            enableACME                  =   true;
            extraConfig                 =   config.services.nginx.virtualHosts."${self.domain}".extraConfig;
            forceSSL                    =   true;
            locations."/".root          =   "/var/blog/";
          };
        };
      };
    };
  }
