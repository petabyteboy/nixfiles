{ pkgs, ... }:
{
  environment                           =
  {
    systemPackages                      =   with pkgs;
    [
      exa
      fdupes
      file
      iotop
      lsof
      parted
      ranger
      unzip
      zstd
    ];
  };
}
