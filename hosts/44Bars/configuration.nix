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

  services.logind.extraConfig = ''
    HandlePowerKey=ignore
  '';


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

  # virtualization
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  programs = {
    hyprland.enable = false;
    sway.enable = true;
  };

  # only for koch vpn details, disable afterwards

  services.strongswan.enable = true;

  services.xserver = {
    enable = true; # naming is just weird, this does not enable x11

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
      START_CHARGE_THRESH_BAT0 = 60;
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };

  # Configure console keymap
  console.keyMap = "de";
  programs.zsh.enable = true;

  home-manager.users.forestgump = import ../../home/home.nix;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.forestgump = {
    isNormalUser = true;
    description = "44Bars";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    packages = with pkgs; [ ];
    shell = pkgs.zsh;
  };

  nixpkgs.config.allowUnfree = true;

  fonts.packages = with pkgs; [
    nerd-fonts.droid-sans-mono
    nerd-fonts.iosevka
    nerd-fonts.caskaydia-cove
    nerd-fonts.jetbrains-mono
    dejavu_fonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
  ];

  programs.seahorse.enable = true;

  environment.systemPackages = with pkgs; [
    git
    keepassxc
    brightnessctl
    libsForQt5.qt5.qtgraphicaleffects
    libsecret
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
