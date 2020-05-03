{ pkgs, ... }:
{
  environment                           =
  {
    systemPackages                      =   with pkgs;
    [
      oh-my-zsh
    ];
  };

  programs                              =
  {
    zsh                                 =
    {
      autosuggestions.enable            =   true;
      enable                            =   true;
      ohMyZsh                           =
      {
        enable                          =   true;
        plugins                         =   [ "git" ];
        theme                           =   "candy";
      };
    };
  };
}
