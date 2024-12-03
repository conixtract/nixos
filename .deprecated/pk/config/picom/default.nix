{ colors, pkgs, ... }:

{
    services.picom = {

        /* package = pkgs.picom.overrideAttrs (old: {
            src = pkgs.fetchFromGitHub {
                owner = "fdev31";
                repo = "picom";
                rev = "7834dd3147ba605bba5cbe911bacfa8b217c37e0";
                sha256 = "05cd3yj3lv8nk433v0j2k86mhg72pf5lijkshqwarr8hp3h00cvx";
            };
        }); */

        enable = true;
        
        backend = "glx";
        fade = true;
        fadeDelta = 7;
        fadeSteps = [ 0.03 0.03 ];
        
        # Opacity
        activeOpacity = 1;
        inactiveOpacity = 0.8;

        opacityRules = [
            "90:class_g = 'kitty' && focused"
            "70:class_g = 'kitty' && !focused"
            "95:class_g = 'Code' && focused"
            "70:class_g = 'Code' && !focused"
            "100:class_g = 'i3lock'"
            "70:class_g = 'Spotify'"

        ];
        settings = {
            animations = true;
            animation-stiffness = 300.0;
            animation-dampening = 22.0;
            animation-clamping = true;
            animation-mass = 1;
            animation-for-open-window = "zoom";
            animation-for-menu-window = "slide-down";
            animation-for-transient-window = "slide-down";
            animation-for-prev-tag = "zoom";
            enable-fading-prev-tag = true;
            animation-for-next-tag = "zoom";
            enable-fading-next-tag = true;

            corner-radius = 20;

            shadow = false;
            shadow-radius = 15;
            shadow-offset-x = -15;
            shadow-offset-y = -15;
            shadow-exclude = [
                #"class_g ~= 'awesome'"
            ];
            rounded-corners-exclude = [
                "window_type = 'dock'"
            ];
            blur-background-exclude = [
                #"class_g ~= 'discord'"
            ];
            blur = {
                method = "dual_kawase";
                strength = 5.0;
                deviation = 1.0;
                kernel = "11x11gaussian";
            };
            blur-background = true;
            blur-background-frame = true;
            blur-background-fixed = true;
            glx-no-stencil = true;
            glx-no-rebind-pixmap = true;
            xrender-sync-fence = true;
            use-damage = true;
        };
    };
}

# reference
# https://github.com/yshui/picom/blob/next/picom.sample.conf