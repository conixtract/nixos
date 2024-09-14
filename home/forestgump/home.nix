{ config, pkgs, ... }:
{
  # some general info  
  home.username = "forestgump";
  home.homeDirectory = "/home/forestgump";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  imports = [
    (import ./config/hyprland/default.nix)
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
    waybar = {
      enable = true;
      systemd.enable = true;
    };
    hyprlock = {
      enable = true;
    };
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    initExtra = "eval \"$(direnv hook zsh)\"";

    shellAliases = {
      la = "ls -a -l -h";
      ls = "ls --color=auto";
      update = "sudo nixos-rebuild switch";
      upgrade = "nix-channel --update && sudo nixos-rebuild switch --upgrade";
      take-out-trash = "sudo nix-collect-garbage --delete-older-than 5d";
      open = "xdg-open";
      vpn = "openconnect --authenticate -v vpn.rwth-aachen.de --useragent=AnyConnect -b --authgroup=\"RWTH-VPN (Full Tunnel)\" --user=\"fx245575\"";
      koki = "cd ~/dev/KoKi-Website/ && nix-shell shell.nix";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
      ];
    };
  };

  home = {
    file = {
      ".config/hypr/hyprlock.conf".source = ./config/hyprland/hyprlock.conf;
    };
    packages = with pkgs; [
      wl-clipboard
      hyprshot
      nixpkgs-fmt
      discord
      mattermost-desktop
    ];
    sessionVariables = {
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      EDITOR = "code";
      BROWSER = "chromium";
      TERMINAL = "kitty";
    };
  };
}
