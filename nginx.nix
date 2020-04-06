let
  this                                  =   import  ./this.nix;
in
  { pkgs, ... }:
  {
    services                            =
    {
      nginx                             =
      {
        enable                          =   true;
      };
    };
  }
