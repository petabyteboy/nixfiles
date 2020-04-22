{ ... }:
{
  programs                              =
  {
    mtr.enable                          =   true;
    nano.nanorc                         =   ( builtins.readFile ./nanorc  );
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
