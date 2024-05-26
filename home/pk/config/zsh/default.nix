{ ... } :

{
    programs.zsh = {
        enable = true;
        autosuggestion.enable = true;
        # enableAutosuggestions = true;
        enableCompletion = true;
        initExtra = "eval \"$(direnv hook zsh)\"";

        shellAliases = {
            la = "ls -a -l -h";
            ls = "ls --color=auto";
            update = "sudo nixos-rebuild switch";
            upgrade = "nix-channel --update && sudo nixos-rebuild switch --upgrade";
            update-remote = "sudo nixos-rebuild --build-host admin@80.141.189.40 --use-remote-sudo switch";
            take-out-trash = "sudo nix-collect-garbage --delete-older-than 5d";
            open = "xdg-open";
            vpn = "openconnect --authenticate -v vpn.rwth-aachen.de --useragent=AnyConnect -b --authgroup=\"RWTH-VPN (Full Tunnel)\" --user=\"fx245575\"";
            thesis = "cd ~/dev/bachelor-thesis/ && nix-shell shell.nix";
        };

        oh-my-zsh = {
            enable = true;
            plugins = [
            ];
        };
    };
}