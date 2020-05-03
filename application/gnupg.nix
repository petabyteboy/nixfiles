{ pkgs, ... }:
{
  environment                           =
  {
    systemPackages                      =   with pkgs;
    [
      gnupg
    ];
  };

  programs                              =
  {
    gnupg                               =
    {
      agent                             =
      {
        enable                          =   true;
        enableSSHSupport                =   true;
        pinentryFlavor                  =   "qt";
      };
    };
  };
}
