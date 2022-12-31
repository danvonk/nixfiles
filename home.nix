{ config, pkgs, ... }:

  let
    doom-emacs = pkgs.callPackage (builtins.fetchTarball {
      url = https://github.com/nix-community/nix-doom-emacs/archive/master.tar.gz;
    }) {
      doomPrivateDir = ./doom.d;  # Directory containing your config.el init.el
    };

in {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "dan";
  home.homeDirectory = "/home/dan";

    home.packages = [
    pkgs.tmux
    pkgs.git
    doom-emacs
    pkgs.vim
    pkgs.kitty
    pkgs.croc
    pkgs.htop
  ];

  programs.git = {
    enable = true;
    userName = "Dan Vonk";
    userEmail = "dan@danvonk.com";
  };
  services.emacs = {
    enable = true;
    package = doom-emacs;
  };









  home.stateVersion = "22.11";
}

