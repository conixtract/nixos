{ config, pkgs, ... }:

let
  # themes = pkgs.callPackage ../../derivs/sddm-themes.nix { }; # for sddm
  # dancing-script = pkgs.callPackage ../../derivs/dancing-script.nix { }; # for sddm
in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    <home-manager/nixos>
  ];

  #! disabeling usb c support ucsi_acpi USBC000:00: UCSI_GET_PDOS failed (-95) errors on startup
  # boot.blacklistedKernelModules = [
  #   "ucsi_acpi"
  # ];

  # Bootloader.  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking.networkmanager.enable = true;
  networking.hostName = "44Bars"; # Define your hostname.

  # bluetooth applet
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
    settings.General.Experimental = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # audio
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # change location of the configuration.nix file
  nix.nixPath = [
    "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos" #dont change this
    "/nix/var/nix/profiles/per-user/root/channels" #neither this
    "nixos-config=${config.users.users.forestgump.home}/nixos/hosts/44Bars/configuration.nix"
  ];

  # natural srcolling
  services.libinput.touchpad.naturalScrolling = true;

  programs = {
    hyprland.enable = true;
  };

  services.xserver = {
    enable = true;

    displayManager.gdm = {
      enable = true;
      wayland = true; # Ensure GDM is using Wayland
    };
    desktopManager = {
      xterm.enable = false;
      gnome.enable = false; # Disable GNOME desktop
    };
    #* i3 stuff
    windowManager.i3.enable = true;
    xkb = {
      layout = "de";
      variant = "neo_qwertz";
    };
  };

  hardware.graphics.enable = true;
  # power management
  powerManagement.enable = true;
  services.tlp = {
    enable = true;
    settings = {
      START_CHARGE_THRESH_BAT0 = 40;
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };

  # sddm config
  /* services.displayManager = {
                		sddm = {
                       			enable = true;
      wayland.enable = true;
      theme = "sugar-dark";
      autoLogin = {
        enable = true;
        user = "forestgump";
        # delay = 5; # Delay in seconds before auto-login
      };
                		};
    defaultSession = "hyprland";
         	}; */

  # Configure console keymap
  console.keyMap = "de";
  programs.zsh.enable = true;

  home-manager.users.forestgump = import ../../home/forestgump/home.nix;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.forestgump = {
    isNormalUser = true;
    description = "44Bars";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ ];
    shell = pkgs.zsh;
  };

  nixpkgs.config.allowUnfree = true;

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "DroidSansMono" "Iosevka" "CascadiaCode" "JetBrainsMono" ]; })
    dejavu_fonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
  ];

  environment.systemPackages = with pkgs; [
    git
    keepassxc
    direnv
    brightnessctl
    libsForQt5.qt5.qtgraphicaleffects

    # openssl
    # nss
    # libGL
    # gnome-keyring
    # libsecret
    # libgnome-keyring
    # mesa
    # mesa.drivers
    
    # dancing-script # for sddm
    # themes.sddm-sugar-dark # for sddm
  ];
  security.pam.services.gdm.enableGnomeKeyring = true;
  services.gnome.gnome-keyring.enable = true;

  services.postgresql = {
    enable = true;
    authentication = pkgs.lib.mkOverride 10 ''
      # TYPE  DATABASE  USER      ADDRESS         METHOD
      local   all       all                       trust
      host    all       all       127.0.0.1/32    trust
      host    all       all       ::1/128         trust
    '';
  };

  system.stateVersion = "24.05";
}
