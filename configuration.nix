let
  this                                  =   import  ./this.nix;
in
  { config, ... }:
  {
    imports                             =
    [
      ./boot.nix
      ./environment.nix
      ./gitea.nix
      ./hardware-configuration.nix
      ./networking.nix
      ./nginx.nix
      ./packages.nix
      ./programs.nix
      ./sivizius.nix
    ];

    system.stateVersion                 =   "20.03";
  }
