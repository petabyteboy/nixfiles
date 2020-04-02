{ ... }:
{
  programs                              =
  {
    mtr.enable                          =   true;
    nano.nanorc                         =
    ''
      set atblanks
      set autoindent
      set backup
      set backupdir                     "~/.nano/backups/"
      set constantshow
      set historylog
      set linenumbers
      set locking
      set matchbrackets                 "(<[{»›)>]}«‹"
      set morespace
      # set mouse
      set multibuffer
      # set noconvert
      # set nofollow
      set nohelp
      #set nonewlines
      set nowrap
      set numbercolor                   brightyellow,normal
      set punct                         "–;:,.¿?¡!"
      set regexp
      set showcursor
      set smarthome
      set smooth
      set speller                       "aspell -x -c"
      set suspend
      set tabsize                       2
      set tabstospaces
      # set tempfile
      set whitespace                    "→·"
      set wordbounds
      #set undo
    '';
    zsh                                 =
    {
      autosuggestions.enable            =   true;
      enable                            =   true;
      ohMyZsh                           =
      {
        enable                          =   true;
        plugins                         =   [ "git" ];
        theme                           =   "candy";
      };
      promptInit                        =
      ''
        if [ -z "$DISPLAY" ]
        then
          true
        else
          true
        fi
      '';
    };
  };
}
