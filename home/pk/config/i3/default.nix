{ pkgs, ... } :

{
    xsession.windowManager.i3 = {
        enable = true;
        extraConfig = "/home/pk/nixos/home/pk/config/i3/config";

        /* extraPackages = with pkgs; [
            dmenu
            #i3status
            i3lock
            #i3blocks
        ]; */
    };
}