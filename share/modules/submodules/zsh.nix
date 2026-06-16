{ ... }:

{ # System-wide (ergo minimal) zsh config
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      l = "lsd -l";
      la = "lsd -a";
      lla = "lsd -la";
      lt = "lsd --tree";
      pussy = "kitten ssh";
    };

    setOptions = [
      "MENU_COMPLETE"
      "LIST_PACKED"
      "AUTO_LIST"
      "HIST_IGNORE_DUPS"
      "HIST_FIND_NO_DUPS"
      "COMPLETE_IN_WORD"
      "VI"
    ];

    promptInit = ''
      PROMPT="%B%F{blue}%n %1~ λ %f%b"
    '';

    # The config itself mainly goes here:
    interactiveShellInit = ''
      autoload -U colors && colors

      zstyle ':completion:*' menu select
      zmodload zsh/complist
      compinit
      _comp_options+=(globdots)

      bindkey -M menuselect 'h' vi-backward-char
      bindkey -M menuselect 'k' vi-up-line-or-history
      bindkey -M menuselect 'l' vi-forward-char
      bindkey -M menuselect 'j' vi-down-line-or-history

      echo -ne '\e[5 q'; preexec() { echo -ne '\e[5 q'; }
    '';
  };
}
