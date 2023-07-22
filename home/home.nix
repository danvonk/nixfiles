{ inputs, config, pkgs, ... }:
{
  imports = [
    inputs.nix-doom-emacs.hmModule
  ];

  home = {
    username = "dan";
    homeDirectory = "/home/dan";
  };

    /* The home.stateVersion option does not have a default and must be set */
    home.stateVersion = "23.05";
    programs.home-manager.enable = true;
    
    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [
      vim
      git
      htop
      firefox
      thunderbird
      zsh
      rofi
      direnv
      kitty
      jetbrains-mono
      noto-fonts
      xfce.xfce4-whiskermenu-plugin
      ispell
      hunspell
      hunspellDicts.en-gb-large
      pavucontrol
    ];

    programs.zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = ["git"];
        theme = "robbyrussell";
      };
    };

    programs.doom-emacs = {
      enable = true;
      doomPrivateDir = ./doom.d; # Directory containing your config.el, init.el
                                 # and packages.el files
    };

    home.file.".config/kitty/kitty.conf".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/kitty/kitty.conf;
    home.file.".config/i3/config".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/i3/config;
}
