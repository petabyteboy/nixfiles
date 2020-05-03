{ pkgs, ... }:
{
  environment                           =
  {
    systemPackages                      =   with pkgs;
    [
      # audio
      audacity
      pavucontrol

      # documents
      cairo
      evince
      libreoffice
      pandoc
      pdfpc
      pdftk
      qpdf
      texlive.combined.scheme-full

      # images
      feh
      gimp
      grim
      imagemagick
      inkscape
      librsvg

      # video
      ffmpeg
      mpv
    ];
  };
}
