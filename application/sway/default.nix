{ pkgs, ... }:
{
  environment                           =
  {
    etc                                 =
    {
      "sway/config".source              =   ./config;
    };

    systemPackages                      =   with pkgs;
    [
      pass-wayland
      swaybg
      waybar
      wev
      wl-clipboard
      (
        wofi.overrideAttrs
        (
          oldAttrs:
          {
            patches                     =   [];
          }
        )
      )
    ];
  };

  programs                              =
  {
    sway                                =
    {
      enable                            =   true;
      extraSessionCommands              =
      ''
        export SDL_VIDEODRIVER=wayland
        export QT_QPA_PLATFORM=wayland
        export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
        export _JAVA_AWT_WM_NONREPARENTING=1
      '';
    };
  };
}
