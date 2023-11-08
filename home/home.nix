{ inputs, config, pkgs, ... }:
{
  imports = [
    inputs.nix-doom-emacs.hmModule
    ./git.nix
  ];

  home = {
    username = "dan";
    homeDirectory = "/home/dan";
  };

    /* The home.stateVersion option does not have a default and must be set */
    home.stateVersion = "23.05";
    programs.home-manager.enable = true;
    
    fonts.fontconfig.enable = true;

    # dconf.settings = {
    #   "org/gnome/mutter" = {
    #     experimental-features = [ "scale-monitor-framebuffer" ];
    #   };
    # };

    home.packages = with pkgs; [
      vim
      git
      htop
      firefox
      thunderbird
      zsh
      rofi
      ripgrep
      kitty
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
      isabelle
    ];

    home.sessionVariables = {
      EDITOR = "emacsclient -nw";
      NIXPKGS_ALLOW_BROKEN = 1;
    };

    home.shellAliases = {
      nupdate = "cd ~/nixfiles && sudo nixos-rebuild switch --upgrade --flake";
      hupdate = "cd ~/nixfiles && home-manager switch --flake .#dan@desktop && cd -";
    };

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
                  ];
        theme = "robbyrussell";
      };
    };

    programs.doom-emacs = {
      enable = true;
      doomPrivateDir = ./doom.d; # Directory containing your config.el, init.el
                                 # and packages.el files
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

    home.file.".config/kitty/kitty.conf".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/kitty/kitty.conf;
    home.file.".config/i3/config".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/i3/config;
}
