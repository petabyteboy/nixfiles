let
  this                                  =   import  ./this.nix;
in
  { config, pkgs, ... }:
  {
    boot                                =
    {
      initrd                            =
      {
        availableKernelModules          =   [ "virtio-pci"  ];
        network                         =
        {
          enable                        =   true;
          postCommands                  =
          ''
            echo 'cryptsetup-askpass' >> /root/.profile
          '';
          ssh                           =
          {
            authorizedKeys              =   config.users.users."${this.userName}".openssh.authorizedKeys.keys;
            enable                      =   true;
            hostKeys                    =   [ ./ecdsa-hostkey ];
            port                        =   2222;
          };
        };
      };
      kernelPackages                    =   pkgs.linuxPackages_latest;
      loader                            =
      {
        grub                            =
        {
          devices                       =   [ "/dev/sda"  ];
          enable                        =   true;
          version                       =   2;
        };
      };
    };
  }
