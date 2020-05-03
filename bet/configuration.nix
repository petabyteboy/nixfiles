let
  self                                  =   import  ./self.nix;
in
  { pkgs, ... }:
  {
    imports                             =
    [
      ./hardware.nix
      ./networking.nix

      # Applciations
      ../application/default.nix

      # Common
      ../common/boot.nix
      ../common/environment.nix
      ../common/fonts.nix
      ../common/networking.nix
      ../common/printer.nix
      ../common/pulseaudio.nix
      ../common/trackpoint.nix
      ../common/tuc.nix
      ../common/users.nix

      # Services
      ../service/home-manager.nix
    ];

    environment                         =
    {
      systemPackages                    =   with pkgs;
      [
        micro
        nix-index
        nix-prefetch-git
        nix-prefetch-github
        xdg_utils
      ];
    };

    users                               =
    {
      users                             =
      {
        "${self.userName}"              =
        {
          extraGroups                   =
          [
            "lpadmin"
            "networkmanager"
            "scanner"
            "video"
          ];
        };
      };
    };
  }
