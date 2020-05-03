let
  self                                  =   import  ./self.nix;
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
        "${self.userName}"              =
        {
          extraGroups                   =   [ "wheel" ];
          initialPassword               =   "1337";
          isNormalUser                  =   true;
          openssh                       =
          {
            authorizedKeys              =
            {
              keyFiles                  =   [ ../public/hetzner.ssh ];
            };
          };
          shell                         =   pkgs.zsh;
        };
      };
    };
  }
