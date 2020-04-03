let
  this                                  =   import  ./this.nix;
  mailAccounts                          =   import  ./mailAccounts.nix;
in
  { ... }:
  {
    imports                             = 
    [
      (
        builtins.fetchTarball
        {
          url                           =   "https://gitlab.com/simple-nixos-mailserver/nixos-mailserver/-/archive/v2.3.0/nixos-mailserver-v2.3.0.tar.gz";
          sha256                        =   "0lpz08qviccvpfws2nm83n7m2r8add2wvfg9bljx9yxx8107r919";
        }
      )                    
    ];

    mailserver                          =
    {
      enable                            =   true;
      fqdn                              =   "mail.${this.domain}";
      domains                           =
      [
        this.domain
      ];
      loginAccounts                     =   mailAccounts;
    };
  }
