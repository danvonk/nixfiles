{ options, config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.nvidia;
in {
  imports = [
    # Paths to other modules.
    # Compose this module out of smaller ones.
  ];

  options.modules.nvidia = {
    enable = mkEnableOption "NVIDIA Unfree Configuration";
  };

  config = mkIf cfg.enable {
    # Option definitions.
    # Define what other settings, services and resources should be active.
    # Usually these are depend on whether a user of this module chose to "enable" it
    # using the "option" above. 
    # You also set options here for modules that you imported in "imports".
    # NVIDIA drivers are unfree.
    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [
        "nvidia-x11"
        "nvidia-settings"
        "nvidia-persistenced"
      ];

    # Tell Xorg to use the nvidia driver
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia-container-toolkit.enable = true;
    hardware.nvidia = {
      # Modesetting is needed for most wayland compositors
      modesetting.enable = true;
      open = false;

      # Enable the nvidia settings menu
      nvidiaSettings = true;

      powerManagement.enable = false;
      powerManagement.finegrained = false;

      # Optionally, you may need to select the appropriate driver version for your specific GPU.
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };

    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };
}
