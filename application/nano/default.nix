{ ... }:
{
  programs                              =
  {
    nano.nanorc                         =   ( builtins.readFile ./common/nanorc  );
  };
}
