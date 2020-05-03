let
  self                                  =   import  ./self.nix;
in
  { pkgs, ... }:
  {
    environment                         =
    {
      systemPackages                    =   with pkgs;
      [
        iftop
        iperf
        mtr
        ncat
        nload
        tcpdump
        telnet
        wget
      ];
    };

    networking                          =
    {
      defaultGateway6                   =
      {
        address                         =   "fe80::1";
        interface                       =   "ens3";
      };

      hostName                          =   self.hostName;

      useDHCP                           =   false;
    };

    programs                            =
    {
      mtr.enable                        =   true;
    };

    services                            =
    {
      openssh.enable                    =   true;
    };
  }
