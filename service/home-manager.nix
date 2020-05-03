let
  self                                  =   import  ./self.nix;
in
  { ... }:
  {
    imports                             =
    [
      "${builtins.fetchGit
      {
        url                             =   "https://github.com/rycee/home-manager";
        rev                             =   "711109d468aa72d327dc1d2f8beabbfe6d061085";
      }}/nixos"
    ];

    home-manager                        =
    {
      useUserPackages                   =   true;
      users                             =
      {
        "${self.userName}"              =
        {
          home.file                       =
          {
            ".config/htop/htoprc".source    =   ./home-manager/htop/htoprc;
            ".config/micro".source          =   ./home-manager/micro;
            ".config/termite/config".source =   ./home-manager/termite/config;
            ".config/waybar".source         =   ./home-manager/waybar;
            ".mbsyncrc".source              =   ./home-manager/mail/isync;
            ".muttrc".source                =   ./home-manager/mail/mutt;
            ".wallpapers".source            =   ./home-manager/wallpapers;
          };
          # to git.nix?
          programs                        =
          {
            git                           =
            {
              enable                      =   true;
              userName                    =   self.fullName;
              userEmail                   =   self.emailAddress;
            };
          };
        };
      };
    };
  }
