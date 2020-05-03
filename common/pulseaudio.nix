{ ... }:
{
  hardware                              =
  {
    pulseaudio.enable                   =   true;
  };

  nixpkgs                               =
  {
    config                              =
    {
      pulseaudio                        =   true;
    };
  };

  sound.enable                          =   true;
}
