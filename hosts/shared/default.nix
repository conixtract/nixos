{config, pkgs, ...}: 

let
    gugi-font = pkgs.callPackage ../../derivs/gugi-font.nix {  };
    dancing-script = pkgs.callPackage ../../derivs/dancing-script.nix{  };
in
{
    # Bootloader.  
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Enable networking
    networking.networkmanager.enable = true;

    # sound with pipewire
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        # If you want to use JACK applications, uncomment this
        jack.enable = true;
    };
    hardware.pulseaudio.enable = false;

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

    # Configure keymap in X11
    services.xserver.xbk = {
        layout = "de";
        Variant = "neo_qwertz";
    };

    fonts.packages = with pkgs; [
        (nerdfonts.override { fonts = [ "Iosevka" "CascadiaCode" "JetBrainsMono" ]; })
        font-awesome
        #gugi-font
        dancing-script
    ];

    environment.systemPackages = with pkgs; [
        pipewire
        pulseaudio # see following link for explaination why pulseaudio is needed https://www.reddit.com/r/NixOS/comments/wyu3rj/comment/ilyz3zq/?utm_source=share&utm_medium=web2x&context=3
        alsa-utils #used for i3blocks volume and managing audio
    ];
}