{ pkgs, ... } :

{
    programs.kitty.enable = true;    # required for the default Hyprland config;
    wayland.windowManager.hyprland = {
        extraConfig = "./hyprland.conf";
    };
}