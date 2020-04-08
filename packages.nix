{ pkgs, ... }:
{
  environment                           =
  {
    systemPackages                      =   with pkgs;
    [
      exa
      file
      fish
      git
      gitlab
      htop
      iftop
      iotop
      iperf
      mtr
      nginx
      nload
      parallel
      progress
      pv
      ranger
      ripgrep
      rsync
      screen
      skim
      sshfs
      tcpdump
      telnet
      tmux
      unzip
      wget
      zstd
    ];
  };
}
