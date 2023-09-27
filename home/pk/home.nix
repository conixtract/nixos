{ config, pkgs, ... }:
let 
    colors = import ../shared/rose.nix { };
in
{
    # some general info  
    home.username = "pk";
    home.homeDirectory = "/home/pk";
    home.stateVersion = "23.05";
    programs.home-manager.enable = true;

    imports = [
        #../shared
        # import configurations
        #(import ./config/i3/default.nix)       
        #(import ./config/i3blocks/default.nix)
        #(import ./config/kitty/default.nix)
        (import ./config/vscode/default.nix)
        (import ./config/picom/default.nix)
        (import ./config/rofi/default.nix { inherit config pkgs colors; })
        (import ./config/polybar/default.nix)
        #"${fetchTarball "https://github.com/msteen/nixos-vscode-server/tarball/master"}/modules/vscode-server/home.nix"


    ];

    # vs code ssh modul fix 
    #services.vscode-server.enable = true;


    home = {
        file = {
            ".config/i3/config".source = ./config/i3/config;
            ".config/i3/i3blocks/i3blocks.conf".source = ./config/i3blocks/i3blocks.conf;
            ".config/kitty/kitty.conf".source = ./config/kitty/kitty.conf;
        };
    
        packages = with pkgs; [
            gcc
            lm_sensors # used for i3blocks temperatur
            spotify
            playerctl
            acpi # used for i3blocks battery
            sxiv # used for wallpaper manager
            obsidian
            maestral
            maestral-gui
            keepassxc
            discord
            dolphin
            flameshot
            polybar
        ];
    };

    nixpkgs.config = {
        allowUnfree = true;
        allowBroken = true;
        allowUnfreePredicate = _: true;
    };

}