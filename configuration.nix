let
  this                                  =   import  ./this.nix;
in
  { config, ... }:
  {
    imports                             =
    [
      ./blog.nix
      ./boot.nix
      ./environment.nix
      ./gitea.nix
      ./hardware-configuration.nix
      ./mailServer.nix
      ./networking.nix
      ./nginx.nix
      ./packages.nix
      ./programs.nix
      ./sivizius.nix
    ];

    system.stateVersion                 =   "20.03";
  }
