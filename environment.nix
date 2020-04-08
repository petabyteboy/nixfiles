{ pkgs, ... }:
{
  console                               =
  {
    font                                =   "Roboto Mono";
    keyMap                              =   "de";
  };

  environment                           =
  {
    shellAliases                        =
    {
      enby                              =   "/run/current-system/sw/bin//man";
      frg                               =
      ''
        :(){
          unset -f :
          regex="$1"
          shift
          /run/current-system/sw/bin/find $@ | /run/current-system/sw/bin/rg $regex
        };:
      '';
      man                               =   "echo 'Use enby […], Fight teh cistem!'";
      md2html                           =
      ''
        :(){
          unset -f :
          filename="$1"
          /run/current-system/sw/bin/pandoc --from markdown+fancy_lists+startnum+task_lists -H ~/.config/ranger/custom.html -s -o 
        };:
      '';
      nixsh                             =   "/run/current-system/sw/bin/nix-shell --run fish ";
      l                                 =   "/run/current-system/sw/bin/exa -lahG";
      l2                                =   "/run/current-system/sw/bin/exa -lahTL2";
      l3                                =   "/run/current-system/sw/bin/exa -lahTL3";
      l4                                =   "/run/current-system/sw/bin/exa -lahTL4";
      l5                                =   "/run/current-system/sw/bin/exa -lahTL5";
      lt                                =   "/run/current-system/sw/bin/exa -lahTL";
      n                                 =   "/run/current-system/sw/bin/nano";
      py                                =   "/run/current-system/sw/bin/python3";
      term                              =   "/run/current-system/sw/bin/zsh";
      use                               =   "/run/current-system/sw/bin/nix-shell --run fish -p ";
    };
    shellInit                           =
    ''
      mkdir -p ~/.nano/backups
      export TERM=xterm
    '';
  };

  i18n                                  =
  {
    defaultLocale                       =   "C.UTF-8";
  };

  time.timeZone                         =   "Europe/Berlin";

  users.users.root                      =
  {
    shell                               =   pkgs.zsh;
  };
}
