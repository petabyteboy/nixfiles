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
      ./hardware.nix
      ./mail.nix
      ./monitoring.nix
      ./networking.nix
      ./nginx.nix
      ./packages.nix
      ./programs.nix
      ./users.nix
    ];

    system.stateVersion                 =   "20.03";
  }
