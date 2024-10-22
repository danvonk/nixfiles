{ options, config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.locale;
in {
  imports = [
    # Paths to other modules.
    # Compose this module out of smaller ones.
  ];

  options.modules.locale = {
    enable = mkEnableOption "Enable default locale settings";
  };

  config = mkIf cfg.enable {
    # Set your time zone.
    time.timeZone = "Europe/Berlin";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_GB.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_GB.UTF-8";
      LC_IDENTIFICATION = "en_GB.UTF-8";
      LC_MEASUREMENT = "en_GB.UTF-8";
      LC_MONETARY = "en_GB.UTF-8";
      LC_NAME = "en_GB.UTF-8";
      LC_NUMERIC = "en_GB.UTF-8";
      LC_PAPER = "en_GB.UTF-8";
      LC_TELEPHONE = "en_GB.UTF-8";
      LC_TIME = "en_GB.UTF-8";
    };

    # Configure console keymap
    console.keyMap = "uk";

    services.xserver.xkb = {
      layout = "gb";
      variant = "";
    };

    # Option definitions.
    # Define what other settings, services and resources should be active.
    # Usually these are depend on whether a user of this module chose to "enable" it
    # using the "option" above.
    # You also set options here for modules that you imported in "imports".
  };
}
