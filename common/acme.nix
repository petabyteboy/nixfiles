let
  self                                  =   import  ./self.nix;
in
  { ... }:
  {
    security.acme                       =
    {
      acceptTerms                       =   true;
      email                             =   "cert@${self.domain}";
    };
  }
