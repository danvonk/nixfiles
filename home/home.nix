{ inputs, config, pkgs, ... }:
{
  imports = [
  ];

  home = {
    username = "dan";
    homeDirectory = "/home/dan";
  };

    /* The home.stateVersion option does not have a default and must be set */
    home.stateVersion = "23.05";
    programs.home-manager.enable = true;
    home.packages = with pkgs; [
      emacs
      vim
      git
      htop
      firefox
      thunderbird
      zsh
      rofi
      direnv
    ];
    programs.zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = ["git"];
        theme = "robbyrussell";
      };
    };
    services.emacs = {
      enable = true;
    };

    home.file.".config/kitty/kitty.conf".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/kitty/kitty.conf;
    home.file.".config/i3/config".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/i3/config;
}
