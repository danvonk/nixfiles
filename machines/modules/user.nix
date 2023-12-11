{ options, config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.user;
in {
  imports = [
    # Paths to other modules.
    # Compose this module out of smaller ones.
  ];

  options.modules.user = { enable = mkEnableOption "Enable default dan user"; };

  config = mkIf cfg.enable {
    # Option definitions.
    # Define what other settings, services and resources should be active.
    # Usually these are depend on whether a user of this module chose to "enable" it
    # using the "option" above.
    # You also set options here for modules that you imported in "imports".

    users.users.dan = {
      isNormalUser = true;
      description = "Dan Vonk";
      extraGroups = [ "networkmanager" "wheel" "docker" ];
      shell = pkgs.zsh;
    };

  };
}
