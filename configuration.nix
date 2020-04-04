let
  this                                  =   import  ./this.nix;
in
  { config, ... }:
  {
    imports                             =
    [
      ./boot.nix
      ./environment.nix
      ./hardware-configuration.nix
      ./networking.nix
      ./packages.nix
      ./programs.nix
      ./sivizius.nix
    ];

    security.acme.server                =   "https://acme-staging-v02.api.letsencrypt.org/directory";

    system.stateVersion                 =   "20.03";
  }
