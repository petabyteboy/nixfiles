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
          "${this.domain}"              =
          {
            enableACME                  =   true;
            forceSSL                    =   true;
            location."/".root           =   "/var/www/";
          };
        };
      };
    };
  }
