{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "mikealexander1860";
  home.homeDirectory = "/home/mikealexander1860";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    autocd = false;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;

    history = {
      size = 100000;
      save = 100000;
      ignoreDups = true;
      ignoreSpace = false;
      extended = true;
      share = true;
    };

    # various options that aren't availabe in the default zsh.nix
    initExtra = [
      "setopt appendhistory extendedglob nomatch notify complete_aliases listambiguous pushedignoredups noautomenu nomenucompletion histverify noflowcontrol"
    ];

    /* Keybindings */
    defaultKeymap =  "emacs";
    initExtra = initExtra ++ [
      # TODO: Custom key bindings
    ];

    # full commands to alias
    shellAliases = {
      ll = "ls -l";
    };
    
    completionInit = [
      # antigen screws up the autocompletion settings , so reload them manually
      "autoload -U +X -z compinit && compinit"
      # allow bash-style completion to be parsed as well
      "autoload -U +X bashcompinit && bashcompinit" 
    ];

    /* ZPLUG */
    zplug.enable = true;
    
    # let zplug manage itself
    zplug.plugins = [
        { name = "zplug/zplug"; tags = [ hook-build:'zplug --self-manage' ]; }
    ];

    # Grab binaries from GitHub Releases and rename with the "rename-to:" tag
    zplug.plugins =  zplug.plugins ++ [
      { name = "junegunn/fzf-bin";
        tags = [
          from:gh-r
          as:command
          rename-to:fzf
          use:"*amd64*"
        ];
      }
    ];
    
    # Support oh-my-zsh and prezto zplug plugins
    zplug.plugins =  zplug.plugins ++ [
      { name = "plugins/git"; tags = [ from:oh-my-zsh ]; }
      { name = "modules/prompt"; tags = [ from:prezto ]; }
    ];
    
    # a tool to let other commands run asynchronous commands
    zplug.plugins =  zplug.plugins ++ [
      { name = "mafredri/zsh-async"; tags = [ from:"github" use:"async.zsh" ]; }
    ];

    # bd command for going up to a specific directory
    zplug.plugins =  zplug.plugins ++ [
      { name = "Tarrasch/zsh-bd"; tags = [ from:"github" use:"bd.zsh" ]; }
    ];

    # up command
    zplug.plugins =  zplug.plugins ++ [
      { name = "peterhurford/up.zsh" }
    ];

    # content search in directory with fuzzy match
    zplug.plugins = zplug.plugins ++ [
      { name = seletskiy/zsh-fuzzy-search-and-edit" }
    ];
    sessionVariables =  sessionVariables ++ [
      # FZF zplug command-line options
      FZF_DEFAULT_OPTS='--layout=default --bind="alt-bs:backward-kill-word,alt-j:backward-char,alt-l:forward-char,alt-i:up,alt-k:down,ctrl-j:backward-word,ctrl-l:forward-word,ctrl-i:page-up,ctrl-k:page-down,ctrl-g:cancel,alt-u:beginning-of-line,alt-o:end-of-line,ctrl-n:next-history,ctrl-p:previous-history,ctrl-]:jump,alt-space:toggle-in,ctrl-space:toggle-in" --multi'
    ];
    # TODO: Set zstlyle

    /*# forgit, an interactive git plugin.  Uses FZF_DEFAULT_OPTS also
    zplug.plugins =  zplug.plugins ++ [
      { name = "wfxr/forgit"; }
    ];
    */

    # fzf-fasd, allows tab completion of the "z" command
    zplug.plugins =  zplug.plugins ++ [
      { name = "wookayin/fzf-fasd"; }
    ];
     
    # zaw
    #  History to Ctrl+r 
    #  git-branch to Alt+q b
    #  git-log to Alt+g l
    #  fasd to Alt+h
    #  prompt for the backed first is Ctrl+t
    zplug.plugins =  zplug.plugins ++ [
      { name = "zsh-users/zaw"; }
    ];
    # see keybindings
    # TODO: zstyle

    /*# peco history search (zaw is better)
    zplug.plugins =  zplug.plugins ++ [
      { name = "jimeh/zsh-peco-history"; tags = [ defer:2 ]; }
    ];
    sessionVariables =  sessionVariables ++ [
      # peco zplug command-line options
      ZSH_PECO_HISTORY_OPTS='--layout=bottom-up --initial-filter=SmartCase --select-1'
      # Set to non-zero to dedup history before being sent to peco
      ZSH_PECO_HIISTORY_DEDUP=1
    ];
    */
  };
  
}
