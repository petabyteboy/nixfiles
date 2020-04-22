let
  this                                  =   import  ../this.nix;
in
  { config, ... }:
  {
    imports                             =
    [
      ./hardware.nix
      ../common/blog.nix
      ../common/boot.nix
      ../common/environment.nix
      ../common/gitea.nix
      ../common/mail.nix
      ../common/monitoring.nix
      ../common/networking.nix
      ../common/nginx.nix
      ../common/packages.nix
      ../common/programs.nix
      ../common/users.nix
    ];
    
    nix                                 =
    {
      gc                                =
      {
        automatic                       =   true;
        options                         =   "--delete-older-than 14d";
      };
    };

    system.stateVersion                 =   "20.03";
  }
