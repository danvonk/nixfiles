{ options, config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.networking;
in {
  imports = [
    # Paths to other modules.
    # Compose this module out of smaller ones.
  ];

  options.modules.networking = {
    enable = mkEnableOption "Enable networking stuff like avahi";
    hostname = mkOption {
      type = types.str;
      default = "nixos";
    };
  };

  config = mkIf cfg.enable {
    # Option definitions.
    # Define what other settings, services and resources should be active.
    # Usually these are depend on whether a user of this module chose to "enable" it
    # using the "option" above.
    # You also set options here for modules that you imported in "imports".

    networking.hostName = cfg.hostname;
    networking.domain = "local";
    networking.networkmanager.enable = true;
    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    services.avahi = {
      enable = true;
      nssmdns4 = true;
      publish = {
        enable = true;
        addresses = true;
        domain = true;
        hinfo = true;
        userServices = true;
        workstation = true;
      };
    };

  };
}
