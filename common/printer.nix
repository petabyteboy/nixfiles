let
  self                                  =   import  ./self.nix;
in
  { pkgs, ... }:
  {
    environment                           =
    {
      systemPackages                      =   with pkgs;
      [
        system-config-printer
      ];
    };

    hardware                            =
    {
      sane                              =
      {
        enable                          =   true;
        extraBackends                   =   [ pkgs.hplipWithPlugin  ];
        netConf                         =   self.scannerIP;
      };
    };

    services                            =
    {
      printing                          =
      {
        drivers                         =   [ pkgs.hplip  ];
        enable                          =   true;
      };
    };
  }
