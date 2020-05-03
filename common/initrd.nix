let
  self                                  =   import  ./self.nix;
in
  { pkgs, ... }:
  {
    boot                                =
    {
      initrd                            =
      {
        network                         =
        {
          enable                        =   true;
          postCommands                  =
          ''
            echo 'cryptsetup-askpass' >> /root/.profile
          '';
          ssh                           =
          {
            authorizedKeys              =   [ ( builtins.readFile ../public/hetzner.ssh ) ];
            enable                      =   true;
            hostKeys                    =   [ ./secret/hostkey  ];
            port                        =   2222;
          };
        };
      };
    };
  }
