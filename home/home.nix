{ inputs, config, pkgs, lib, ... }:

let my-rstudio = import ./rlang.nix { inherit pkgs; };
in {
  imports = [ ./git.nix ];

  home = {
    username = "dan";
    homeDirectory = "/home/dan";
  };

  # The home.stateVersion option does not have a default and must be set
  home.stateVersion = "23.05";
  programs.home-manager.enable = true;

  fonts.fontconfig.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [ "vscode" "zoom" "netflix" ];
  };

  home.packages = with pkgs; [
    vim
    git
    htop
    firefox
    thunderbird
    rofi
    jetbrains-mono
    noto-fonts
    newcomputermodern
    ispell
    hunspell
    hunspellDicts.en-gb-large
    hunspellDicts.fr-moderne
    hunspellDicts.de_DE
    pavucontrol
    syncthing
    direnv
    nix-direnv
    nixfmt-classic
    ripgrep
    libreoffice-qt
    foliate
    texlive.combined.scheme-full
    typst
    typst-lsp
    gdb
    vscode
    vscode-extensions.rust-lang.rust-analyzer
    rust-analyzer
    zoom-us
    chromium
    gnome-pomodoro
    sqlite
    anki-bin
    ripgrep
    nextcloud-client
    calibre
    # shell gizmos
    fzf
    neofetch
    nodejs
    docker-compose
    gthumb
    linuxPackages_latest.perf
    hotspot
    vlc
    testdisk
    gcc # annoyingly for emacs
    zotero
    inkscape
    gimp
    paraview
    rclone
    rclone-browser
    azure-cli
    protonmail-bridge
    protonmail-bridge-gui
    protonvpn-gui
    protonmail-desktop
    my-rstudio
  ];

  home.sessionVariables = {
    EDITOR = "emacsclient -nw";
    NIXPKGS_ALLOW_BROKEN = 1;
  };

  home.shellAliases = {
    nupdate = "cd ~/nixfiles && sudo nixos-rebuild switch --upgrade --flake";
    hupdate =
      "cd ~/nixfiles && home-manager switch --flake .#dan@desktop && cd -";
    ec = "~/.config/emacs/bin/doom run -nw";
  };

  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    prezto = {
      enable = false;
      extraModules = [ "git" ];
    };
    oh-my-zsh = {
      enable = true;
      plugins =
        [ "git" "fzf" "sudo" "docker" "pyenv" "python" "ripgrep" "vi-mode" ];
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

  services.syncthing = {
    enable = true;
    tray.enable = true;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Arc";
      package = pkgs.arc-theme;
    };
  };

  home.file.".local/share/applications/doom.desktop".source =
    ./dotfiles/doom.desktop;
  home.file.".config/doom".source = ./doom.d;
  home.file.".config/kitty/kitty.conf".source =
    config.lib.file.mkOutOfStoreSymlink ./dotfiles/kitty/kitty.conf;
  home.file.".config/i3/config".source =
    config.lib.file.mkOutOfStoreSymlink ./dotfiles/i3/config;
}
