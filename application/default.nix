{ pkgs, ... }:
{
  imports                               =
  [
    ./adhd.nix
    ./atom.nix
    ./chemistry.nix
    ./crypto.nix
    ./darkweb.nix
    ./data.nix
    ./development.nix
    ./emulation.nix
    ./files.nix
    ./funny.nix
    ./games.nix
    ./git.nix
    ./gnupg.nix
    ./hardware.nix
    ./htop/default.nix
    ./libs.nix
    ./mail/default.nix
    ./media.nix
    ./messenger.nix
    ./nano/default.nix
    ./pentesting.nix
    ./processes.nix
    ./ranger/default.nix
    ./spelling.nix
    ./sway/default.nix
    ./sync.nix
    ./terminal.nix
    ./termite/default.nix
    ./zsh.nix
  ];

  environment                           =
  {
    systemPackages                      =   with pkgs;
    [
      deluge
      firefox-wayland
      gnome3.nautilus
      qutebrowser
      spotify
      xournal
    ];
  };

  nixpkgs                               =
  {
    config                              =
    {
      allowUnfree                       =   true;
    };
  };
}
