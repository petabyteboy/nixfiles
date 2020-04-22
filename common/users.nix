let
  this                                  =   import  ../this.nix;
in
  { pkgs, ... }:
  {
    users                               =
    {
      users                             =
      {
        root                            =
        {
          shell                         =   pkgs.zsh;
        };
        "${this.userName}"              =
        {
          extraGroups                   =   [ "wheel" ];
          initialPassword               =   "1337";
          isNormalUser                  =   true;
          openssh                       =
          {
            authorizedKeys              =
            {
              keyFiles                  =   [ ../public/user.ssh  ];
            };
          };
          shell                         =   pkgs.zsh;
        };
      };
    };
  }
