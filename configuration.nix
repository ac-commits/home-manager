{ config, pkgs, ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
    <home-manager/nixos> # Import Home Manager
  ];

  # System settings
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "sleipnir";
  networking.networkmanager.enable = true; # Enable NetworkManager for easy network management

  # Bluetooth setup
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Timezone and locale settings
  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_TIME = "nl_NL.UTF-8";
  };

  # Enable the X server and set up i3
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.options = "caps:escape,compose:ralt";
    autoRepeatDelay = 300;
    autoRepeatInterval = 30;
    displayManager.lightdm.enable = true;
    windowManager.i3.enable = true;
  };

  # Define users
  users.users.oscar = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # System packages
  environment.systemPackages = with pkgs; [
    vim
    git
    home-manager
    firefox
  ];

  # Enable autologin for convenience (if desired)
  services.getty.autologinUser = "oscar";

  # Gnome keyring onzin
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.gdm.enableGnomeKeyring = true;

  # Use systemd.tmpfiles to create /bin and the /bin/bash symlink
  systemd.tmpfiles.rules = [
    "d /bin 0755 root root -"
    "L /bin/bash - - - - ${pkgs.bash}/bin/bash"
  ];

  # Define system state version
  system.stateVersion = "23.05";
}
