let
  this                                  =   import  ./this.nix;
in
  { ... }:
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
            forceSSL                    =   true;
            locations."/".root          =   "/var/blog/";
          };
        };
      };
    };
  }
