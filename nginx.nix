let
  this                                  =   import  ./this.nix;
in
  { pkgs, ... }:
  {
    services                            =
    {
      nginx                             =
      {
        virtualHosts                    =
        {
          "${this.domain}"              =
          {
            root                        =   pkgs.stdenv.mkDerivation
            {
              src                       =   fetchGit "https://github.com/sivizius/blog/";
            };
          };
        };
      };
      openssh.enable                    =   true;
    };
  }
