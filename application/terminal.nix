{ pkgs, ... }:
{
  environment                           =
  {
    systemPackages                      =   with pkgs;
    [
      bat
      jq
      ripgrep
      screen
      skim
      tmux
    ];
  };
}
