let
  this                                  =   import  ./this.nix;
in
  import "${./.}/${this.hostName}/configuration.nix"
