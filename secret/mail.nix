let
  this                                  =   import  ./this.nix;
in
  {
    "root@${this.domain}"               =
    {
      aliases                           =
      [
        "cert${this.domain}"            # Certificates related issues
        "dmarc${this.domain}"           # Domain-based Message Authentication, Reporting and Conformance
        "dns${this.domain}"             # Domain Name System related issues
      ];
      catchAll                          =
      [
        "${this.domain}"                # Ignore Aliases, gimme everything. Gonna Catch Them All.
      ];
      hashedPassword                    =   "…";
      sieveScript                       =
      ''
      '';
    };

    "${this.userName}@${this.domain}"   =
    {
      hashedPassword                    =   "…";
      quota                             =   "10G";
      sieveScript                       =
      ''
      '';
    };
  }
