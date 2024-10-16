{ config, pkgs, lib, ... }:
let
  colors = import ../shared/rose.nix { };
in
{
  # some general info  
  home.username = "forestgump";
  home.homeDirectory = "/home/forestgump";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  imports = [
    (import ./config/hyprland/default.nix)
    (import ../pk/config/rofi/default.nix { inherit config pkgs colors; })
  ];

  # dropbox setup from https://nixos.wiki/wiki/Dropbox
  systemd.user.services.dropbox = {
    Unit = {
      Description = "Dropbox service";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      ExecStart = "${pkgs.dropbox}/bin/dropbox";
      Restart = "on-failure";
    };
  };

  services.swaync.enable = true;

  services.hyprpaper = {
    enable = true;
    settings = { }; #! set to empty set such that the config file is not generated and i can place my own
  };

  programs = {
    chromium = {
      enable = true;
      commandLineArgs = [
        "--ozone-platform-hint=auto"
      ];
    };
    vscode = {
      enable = true;
      # package = pkgs.vscode.fhsWithPackages (ps: with ps; [
      #   pkg-config
      #   gnumake
      #   clang
      #   cmake
      #   eigen
      #   xorg.libX11
      #   xorg.libXrandr
      #   xorg.libXinerama
      #   xorg.libXcursor
      #   xorg.libXi
      #   xorg.libXext
      #   libGLU
      #   wayland-scanner
      #   wayland
      #   libxkbcommon
      #   libffi
      #   gdb
      #   meshlab
      # ]);
    };
    waybar = {
      enable = true;
      systemd.enable = false;
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

  # override the default config files
  xdg.configFile."hypr/hyprpaper.conf" = lib.mkForce {
    source = ./config/hyprland/hyprpaper.conf;
  };

  home = {
    file = {
      ".config/hypr/hyprlock.conf".source = ./config/hyprland/hyprlock.conf;
      ".config/i3/config".source = ../pk/config/i3/config;
    };
    packages = with pkgs; [
      wl-clipboard
      hyprshot
      nixpkgs-fmt
      discord
      mattermost-desktop
      beekeeper-studio
      gitkraken
      openconnect
      obsidian
      feh
      rsync
      qt5.qtwayland
      qt6.qtwayland
      libnotify
      blueman
      whatsapp-for-linux
      (pkgs.mailspring.overrideAttrs (oldAttrs: rec {
        postInstall = ''
          wrapProgram $out/bin/mailspring --add-flags "--password-store=gnome-libsecret"
        '';
      }))
      spotify
    ];
    sessionVariables = {
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      EDITOR = "code";
      BROWSER = "chromium";
      TERMINAL = "kitty";
    };
  };
}
