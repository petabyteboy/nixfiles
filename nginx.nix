let
  this                                  =   import  ./this.nix;
in
  { pkgs, ... }:
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
            "/"                         =
            {
              index                     =   "index.html";
            };
          };
        };
      };
      openssh.enable                    =   true;
    };
  }
