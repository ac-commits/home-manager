{ config, pkgs, ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
    <home-manager/nixos>
  ];

  # System settings
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "mimr";
  networking.networkmanager.enable = true; # Enable NetworkManager for easy network management
  # networking.firewall.allowedUDPPorts = [ 8096 ];
  # networking.firewall.allowedTCPPorts = [ 8096 ];
  networking.firewall.enable = false;

  # Laptop battery setup
  services.system76-scheduler.settings.cfsProfiles.enable = true;
  services.tlp = {
    enable = true;
    settings = {
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      USB_AUTOSUSPEND = 0;
    };
  };
  services.power-profiles-daemon.enable = false;
  powerManagement.powertop.enable = true;
  services.thermald.enable = true;

  # DNS settings
  networking.nameservers = [
    "9.9.9.9#dns.quad9.net"
    "149.112.112.112#dns.quad9.net"
  ];

  services.resolved = {
    enable = true;
    dnssec = "true";
    domains = [ "~." ];
    fallbackDns = [
      "9.9.9.9#dns.quad9.net"
      "149.112.112.112#dns.quad9.net"
    ];
    dnsovertls = "true";
  };

  # Laptop lid settings
  services.logind = {
    lidSwitch = "suspend";
    lidSwitchDocked = "ignore";
    powerKey = "ignore";
    suspendKey = "suspend";
    hibernateKey = "hibernate";
  };

  # Bluetooth setup
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # VMware
  virtualisation = {
  vmware.host.enable = true;
  docker.enable = true;
  };

  # Pulseaudio setup
  hardware.pulseaudio.enable = false;
  hardware.pulseaudio.support32Bit = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Flatpak support
  xdg.portal = {
  enable = true;
  configPackages = [ pkgs.xdg-desktop-portal-gtk ];
  };
  services.flatpak.enable = true;

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
  users.users.alex = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "audio" "docker" ];
  };

  # System packages
  environment.systemPackages = with pkgs; [
    vim
    git
    home-manager
    intel-gpu-tools
    powertop
  ];

  # Enable autologin for convenience (if desired)
  services.displayManager.autoLogin.user = "alex";

  # Gnome keyring onzin
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.gdm.enableGnomeKeyring = true;

  # Use systemd.tmpfiles to create /bin and the /bin/bash symlink
  systemd.tmpfiles.rules = [
    "d /bin 0755 root root -"
    "L /bin/bash - - - - ${pkgs.bash}/bin/bash"
  ];

  # Define system state version
  system.stateVersion = "24.05";
}
