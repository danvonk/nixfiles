{ config, pkgs, ... }:

  let
    doom-emacs = pkgs.callPackage (builtins.fetchTarball {
      url = https://github.com/nix-community/nix-doom-emacs/archive/master.tar.gz;
    }) {
      doomPrivateDir = ./doom.d;  # Directory containing your config.el init.el
    };
in {
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;
  home.username = "dan";
  home.homeDirectory = "/home/dan";

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    tmux
    git
    emacs
    vim
    kitty
    croc
    htop
    rustup
    firefox
    thunderbird
    gmp
    xz
    spotify
    vscode
    zsh
  ];

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = ["git"];
      theme = "robbyrussell";
    };
  };
  programs.git = {
    enable = true;

    userName = "Daniel Vonk";
    userEmail = "daniel.vonk@kdab.com";
    extraConfig = {
      rerere = {
       enabled = true;
       autoupdate = true; 
      };
      core = {
        pager = "less -FRSX";
        autocrlf = "input";
      };
      color = {
        ui = "auto";
      };
      "url \"ssh:\/\/git@code.siemens-energy.com/\"".insteadOf
        = "https:\/\/code.siemens-energy.com";
    };
  };
  programs.ssh = {
    matchBlocks = {
      kdab = {
        hostname = "kdab.com";
        identityFile = "~/.ssh/id_kdab";
        identitiesOnly = "yes";
      };
      codereview = {
        hostname = "codereview.kdab.com";
        port = 29418;
        identityFile = "~/.ssh/id_kdab";
        identitiesOnly = "yes";
        preferredAuthentications = "publickey";
        pubkeyAcceptedKeyTypes = "+ssh-ed25519";
      };
   };
  };
  services.emacs = {
    enable = false;
    package = doom-emacs;
  };
  gtk = {
    enable = true;
    theme.name = "Arc-Dark";
  };
}

