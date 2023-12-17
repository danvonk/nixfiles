{ inputs, config, pkgs, lib, ... }: {
  imports = [ ./git.nix ];

  home = {
    username = "dan";
    homeDirectory = "/home/dan";
  };

  # The home.stateVersion option does not have a default and must be set
  home.stateVersion = "23.05";
  programs.home-manager.enable = true;

  fonts.fontconfig.enable = true;
  # dconf.settings = {
  #   "org/gnome/mutter" = {
  #     experimental-features = [ "scale-monitor-framebuffer" ];
  #   };
  # };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "vscode" ];
  };

  home.packages = with pkgs; [
    vim
    git
    htop
    firefox
    thunderbird
    rofi
    # kitty
    jetbrains-mono
    noto-fonts
    xfce.xfce4-whiskermenu-plugin
    ispell
    hunspell
    hunspellDicts.en-gb-large
    pavucontrol
    syncthing
    direnv
    nix-direnv
    nixfmt
    ripgrep
    libreoffice-qt
    foliate
    texlive.combined.scheme-full
    # isabelle
    gdb
    vscode
    ghc # having ghci in shell is useful
    chromium
    gnome.pomodoro
    sqlite
    # emacs
    ripgrep
    # shell gizmos
    fzf
  ];

  home.sessionVariables = {
    EDITOR = "emacsclient -nw";
    NIXPKGS_ALLOW_BROKEN = 1;
  };

  home.shellAliases = {
    nupdate =
      "cd ~/nixfiles && sudo nixos-rebuild switch --upgrade --flake && cd -";
    hupdate =
      "cd ~/nixfiles && home-manager switch --flake .#dan@desktop && cd -";
    ec = "emacsclient -nw";
  };

  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableVteIntegration = true;
    prezto = {
      enable = false;
      extraModules = [ "git" ];
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "fzf" "sudo" "docker" "pyenv" "python" "ripgrep" ];
      theme = "robbyrussell";
    };
  };

  services.emacs.enable = true;
  programs.emacs = {
    enable = true;
    package = pkgs.emacs29-pgtk;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = false;
    plugins = [
      pkgs.vimPlugins.nvim-treesitter
      pkgs.vimPlugins.nvim-treesitter.withAllGrammars
    ];
  };

  services.syncthing = {
    enable = true;
    tray.enable = true;
  };

  home.file.".config/doom".source = ./doom.d;

  home.file.".config/kitty/kitty.conf".source =
    config.lib.file.mkOutOfStoreSymlink ./dotfiles/kitty/kitty.conf;
  home.file.".config/i3/config".source =
    config.lib.file.mkOutOfStoreSymlink ./dotfiles/i3/config;
}
