let
  domain                                =   "sivizius.eu";
  hostName                              =   "aleph";
  ipv4                                  =   "95.217.131.201";
  ipv6range                             =   "2a01:4f9:c010:6bf5:";
in
  {
    hostDomain                          =   "${hostName}.${domain}";
    ipv6                                =   "${ipv6range}:23";
    inherit domain hostName ipv4 ipv6range;
    ports                               =
    {
      exporters                         =
      {
        bind                            =   9119;
        nginx                           =   9113;
        node                            =   9100;
      };
      gitea                             =   3000;
      grafana                           =   3001;
      prometheus                        =   9090;
    };
    userName                            =   "sivizius";
  }
