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
      certificateScheme                 =   3;
      domains                           =   [ this.domain ];
      enable                            =   true;
      enableImap                        =   true;
      enableImapSsl                     =   true;
      enableManageSieve                 =   true;
      enablePop3                        =   true;
      enablePop3Ssl                     =   true;
      fqdn                              =   "mail.${this.domain}";
      localDnsResolver                  =   false;
      loginAccounts                     =   mailAccounts;
      rejectRecipients                  =   [ ];
      rejectSender                      =   [ ];
      virusScanning                     =   false;
    };
  }
