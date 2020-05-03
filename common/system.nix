{ ... }:
{
  nix                                   =
  {
    gc                                  =
    {
      automatic                         =   true;
      options                           =   "--delete-older-than 14d";
    };
  };

  system                                =
  {
    autoUpgrade                         =
    {
      allowReboot                       =   false;
      dates                             =   "04:20";
      enable                            =   true;
    };
    stateVersion                        =   "20.09";
  };
}
