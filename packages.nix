{ pkgs, ... }:
{
  environment                           =
  {
    systemPackages                      =   with pkgs;
    [
      exa
      file
      git
      htop
      iftop
      iotop
      iperf
      mtr
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
