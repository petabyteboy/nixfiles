{ ... }:
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
      frg                               =   "/run/current-system/sw/bin/find ./ | /run/current-system/sw/bin/rg";
      man                               =   "echo 'Use enby […], Fight teh cistem!'";
      md2html                           =
      ''
        :(){
          unset -f :
          filename="$1"
          /run/current-system/sw/bin/pandoc --from markdown+fancy_lists+startnum+task_lists -H ~/.config/ranger/custom.html -s -o 
        };:
      '';
      l                                 =   "/run/current-system/sw/bin/exa -lah";
      n                                 =   "/run/current-system/sw/bin/nano";
      py                                =   "/run/current-system/sw/bin/python3";
    };
    shellInit                           =
    ''
      mkdir -p ~/.nano/backups
    '';
  };

  i18n                                  =
  {
    defaultLocale                       =   "C.UTF-8";
  };

  time.timeZone                         =   "Europe/Berlin";
}
