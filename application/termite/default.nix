{ pkgs, ... }:
{
  environment                           =
  {
    systemPackages                      =   with pkgs;
    [
      (
        termite.overrideAttrs
        (
          oldAttrs:
          {
            patches                     =   oldAttrs.patches ++
            [
              ./termite/clipboard.patch
            ];
          }
        )
      )
    ];
  };
}
