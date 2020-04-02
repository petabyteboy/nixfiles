let
  this                                  =   import ./this.nix;
in
  { pkgs, ... }:
  {
    imports                             =
    [
      ./boot.nix
      ./environment.nix
      ./hardware-configuration.nix
      ./mailserver.nix
      ./networking.nix
      ./packages.nix
      ./programs.nix
      ./sivizius.nix
    ];

    security.acme.server                =   "https://acme-staging-v02.api.letsencrypt.org/directory";

    services                            =
    {
      nginx                             =
      {
        virtualHosts                    =
        {
          "${this.domainName}"          =
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

    system.stateVersion                 =   "20.03";
  }
