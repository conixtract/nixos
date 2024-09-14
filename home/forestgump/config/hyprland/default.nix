{ pkgs, ... } :

{
    programs.kitty.enable = true;    # required for the default Hyprland config;
    # home.file.".config/hypr/hyprland.conf".source = ./config/hyprland/hyprland.conf;

    wayland.windowManager.hyprland = {
        enable = true;
        xwayland.enable = true;
        extraConfig = builtins.readFile ./hyprland.conf;
    };
}