{ config, pkgs, ... }:
{
  # some general info  
  home.username = "forestgump";
  home.homeDirectory = "/home/forestgump";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  imports = [
    # (import ./config/hyprland/default.nix)
  ];

  programs = {
    wofi.enable = true;
    chromium = {
      enable = true;
      commandLineArgs = [
        "--ozone-platform-hint=auto"
      ];
    };
    vscode = {
      enable = true;
    };
    kitty = {
      enable = true;
    };
    waybar = {
      enable = true;
      systemd.enable = true;
    };
    hyprlock = {
      enable = true;
    };
  };

  home = {
    file = {
      ".config/hypr/hyprland.conf".source = ./config/hyprland/hyprland.conf;
      ".config/hypr/hyprlock.conf".source = ./config/hyprland/hyprlock.conf;
    };
    packages = with pkgs; [
      wl-clipboard
      hyprshot
      nixpkgs-fmt
    ];
    sessionVariables = {
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      EDITOR = "code";
      BROWSER = "chromium";
      TERMINAL = "kitty";
    };
  };
}
