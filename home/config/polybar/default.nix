{ config, ... } :

{
    services.polybar = {
        enable = true;
        script = "./launch.sh";
        config = "${config.home.homeDirectory}/nixos/home/config/polybar/config.ini";
    };

}
