# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, lib, config, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../nix.nix
    ../modules/nvidia.nix
    ../modules/locale.nix
    ../modules/networking.nix
    ../modules/user.nix
  ];

  # Custom module toggles
  modules.nvidia.enable = true;
  modules.locale.enable = true;
  modules.user.enable = true;

  # laptop-specific nvidia config
  hardware.nvidia.prime = {
    offload = {
      enable = true;
      enableOffloadCmd = true;
    };
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:0:1:0";
  };

  # Bootloader.
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelParams = [ "psmouse.synaptics_intertouch=0" ];
  };

  modules.networking = {
    enable = true;
    hostname = "nixps";
  };

  # Enable the GNOME Desktop Environment.
  services.libinput = {
    enable = true;
    touchpad.tapping = true;
    touchpad.naturalScrolling = false;
    touchpad.scrollMethod = "twofinger";
    touchpad.disableWhileTyping = false;
    touchpad.clickMethod = "clickfinger";
  };

  services.displayManager = { defaultSession = "gnome"; };

  services.xserver = {
    enable = true;
    exportConfiguration = true;
    synaptics.enable = false;
    desktopManager = {
      xfce = {
        enable = false;
        noDesktop = true;
        enableXfwm = false;
      };
      gnome.enable = true;
    };

    displayManager = { gdm.enable = true; };
    windowManager.i3.enable = true;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    curl
    tailscale
    xdg-utils
    cachix
    gnomeExtensions.appindicator
    gnomeExtensions.pop-shell
    gnomeExtensions.pop-launcher-super-key
  ];

  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  programs.zsh.enable = true;

  services = {
    flatpak.enable = true;
    dbus.enable = true;
  };

  services.tailscale.enable = true;
  virtualisation.docker.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
