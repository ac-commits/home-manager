{ config, pkgs, ... }:

let
  python_env = pkgs.python3.withPackages (ps: with ps; [
    pip
    numpy
    requests
    i3ipc
  ]);
in

{
  home.username = "oscar";
  home.homeDirectory = "/home/oscar";
  home.stateVersion = "24.05";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable Firefox
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    policies = {
      ExtensionSettings = {
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          installation_mode = "force_installed";
        };
        "addon@darkreader.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
          installation_mode = "force_installed";
        };
        "dfyoutube@example.com" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/df-youtube/latest.xpi";
          installation_mode = "force_installed";
        };
        "{9063c2e9-e07c-4c2c-9646-cfe7ca8d0498}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/old-reddit-redirect/latest.xpi";
          installation_mode = "force_installed";
        };
        "jid1-xUfzOsOFlzSOXg@jetpack" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/reddit-enhancement-suite/latest.xpi";
          installation_mode = "force_installed";
        };
        "sponsorBlocker@ajay.app" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
          installation_mode = "force_installed";
        };
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi";
          installation_mode = "force_installed";
        };
        "zotero@chnm.gmu.edu" = {
          install_url = "https://www.zotero.org/download/connector/dl?browser=firefox&version=5.0.147";
          installation_mode = "force_installed";
        };
        "{22b0eca1-8c02-4c0d-a5d7-6604ddd9836e}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/dark-space-the-best-dynamic-theme/latest.xpi";
          installation_mode = "force_installed";
        };
        # Nicothin Space Theme
        "nicothin-space@nicothin.com" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4226329/nicothin_space-1.1.2.xpi";
          installation_mode = "force_installed";
        };
      };
      Extensions = {
        # Set the Nicothin Space theme as the active theme
        ActiveTheme = "nicothin-space@nicothin.com";
      };
    };
  };

  # Configuration files and locations
  home.file = {
    ".config/alacritty/alacritty.toml".source = ./alacritty/alacritty.toml;
    ".config/alacritty/alacritty.yml".source = ./alacritty/alacritty.yml;
    ".bashrc".source = ./.bashrc;
    ".inputrc".source = ./.inputrc;
    ".config/dunst/dunstrc".source = ./dunst/dunstrc;
    ".config/i3/config".source = ./i3/config;
    ".config/i3/lockscreen.sh".source = ./i3/lockscreen.sh;
    ".config/i3/monitors.sh".source = ./i3/monitors.sh;
    ".config/i3/burpcheck.sh".source = ./i3/burpcheck.sh;
    ".config/i3/chains.png".source = ./i3/chains.png;
    ".config/i3/alternating_layouts.py".source = ./i3/alternating_layouts.py;
    ".config/i3/wall.png".source = ./i3/wall.png;
    ".config/polybar/config.ini".source = ./polybar/config.ini;
    ".config/polybar/deadcon.sh".source = ./polybar/deadcon.sh;
    ".config/polybar/launch.sh".source = ./polybar/launch.sh;
    ".config/polybar/promodoro_duration.sh".source = ./polybar/promodoro_duration.sh;
    ".config/polybar/spotify_status.py".source = ./polybar/spotify_status.py;
    ".config/polybar/tun_script.sh".source = ./polybar/tun_script.sh;
    ".config/ranger/commands_full.py".source = ./ranger/commands_full.py;
    ".config/ranger/commands.py".source = ./ranger/commands.py;
    ".config/ranger/rc.conf".source = ./ranger/rc.conf;
    ".config/ranger/rifle.conf".source = ./ranger/rifle.conf;
    ".config/ranger/scope.sh".source = ./ranger/scope.sh;
    ".config/rofi/config.rasi".source = ./rofi/config.rasi;
    ".config/rofi/default.rasi".source = ./rofi/default.rasi;
  };

  home.sessionVariables = {
    PYTHONPATH = "${python_env}/lib/python3.10/site-packages";
    OPENAI_API_KEY = "$(cat ~/.openai_api_key)";
  };

  # Specify additional packages to be installed
  home.packages = with pkgs; [
    python_env
    home-manager
    alacritty
    i3
    dunst
    (polybar.override { i3Support = true; })
    ranger
    rofi
    nerdfonts
    emacs29
    git
    ripgrep
    fd
    okular
    clang
    gnupg
    spotify
    hunspell
    hunspellDicts.nl_NL
    hunspellDicts.en_US
    flameshot
    direnv
    nix-direnv
    pulseaudio
    nextcloud-client
    emacs-all-the-icons-fonts
    fzf
    termdown
    arandr
    networkmanager
    libreoffice
    noto-fonts
    chromium
    xclip
    feh
    imagemagick
    scrot
  ];
}
