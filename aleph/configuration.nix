let
  self                                  =   import  ./self.nix;
in
  { config, ... }:
  {
    imports                             =
    [
      ./hardware.nix
      ./networking.nix

      # Applications
      ../application/files.nix
      ../application/nano/default.nix
      ../application/htop/default.nix
      ../application/processes.nix
      ../application/ranger/default.nix
      ../application/sync.nix
      ../application/terminal.nix
      ../application/zsh.nix

      # Common
      ../common/acme.nix
      ../common/boot.nix
      ../common/environment.nix
      ../common/git.nix
      ../common/initrd.nix
      ../common/networking.nix
      ../common/system.nix
      ../common/users.nix

      # Services
      ../service/blog.nix
      ../service/gitea.nix
      ../service/mail.nix
      ../service/monitoring.nix
      ../service/nginx.nix
    ];
  }
