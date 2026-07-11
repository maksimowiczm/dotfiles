{ pkgs, ... }:

{
  home.packages = with pkgs; [
    fzf
    zoxide
  ];
  programs.zsh = {
    enable = true;
    shellAliases = {
      ls = "ls --color=auto";
      ll = "ls --color=auto -l";
      la = "ls --color=auto -a";
      cd = "z";
      nd = "nix develop -c zsh";
      j = "just";
      jf = "just format";
    };
    zplug = {
      enable = true;
      plugins = [
        {
          name = "mafredri/zsh-async";
          tags = [ "from:github" ];
        }
        {
          name = "sindresorhus/pure";
          tags = [
            "use:pure.zsh"
            "as:theme"
            "from:github"
          ];
        }
        { name = "zsh-users/zsh-syntax-highlighting"; }
        { name = "zsh-users/zsh-completions"; }
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "Aloxaf/fzf-tab"; }
        { name = "jeffreytse/zsh-vi-mode"; }
        { name = "desyncr/auto-ls"; }
        {
          name = "plugins/git";
          tags = [ "from:oh-my-zsh" ];
        }
        {
          name = "plugins/colored-man-pages";
          tags = [ "from:oh-my-zsh" ];
        }
      ];
    };
    sessionVariables = {
      ZVM_INIT_MODE = "sourcing";
      AUTO_LS_NEWLINE = "false";
    };
    initContent = ''
      autoload -U compinit && compinit

      # Keybindings
      bindkey '^p' history-beginning-search-backward
      bindkey '^n' history-beginning-search-forward
      bindkey '^x' autosuggest-clear
      bindkey '^d' forward-word

      # Completion styling
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      zstyle ':completion:*' menu no
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
      zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
    '';
  };
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
