{ pkgs, ... }:
{
  environment                           =
  {
    systemPackages                      =   with pkgs;
    [
      aspell
      hunspell
      hunspellDicts.en_GB-large
      hunspellDicts.de_DE
    ];
  };
}
