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

  networking.hostName = "44Bars"; # Define your hostname.
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
      gnome.enable = false; # Disable GNOME desktop if enabled
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

  home-manager.users.forestgump = import ../../home/forestgump/home.nix;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.forestgump = {
    isNormalUser = true;
    description = "44Bars";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ ];
  };

  nixpkgs.config.allowUnfree = true;

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "DroidSansMono" ]; })
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
    # dancing-script # for sddm
    # themes.sddm-sugar-dark # for sddm
  ];

  system.stateVersion = "24.05";
}
