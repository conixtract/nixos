{ ... } :

{
    programs.zsh = {
        enable = true;
        enableAutosuggestions = true;
        enableCompletion = true;

        shellAliases = {
            la = "ls -a -l -h";
            ls = "ls --color=auto";
            update = "sudo nixos-rebuild switch";
            upgrade = "nix-channel --update && sudo nixos-rebuild switch --upgrade";
            take-out-trash = "sudo nix-collect-garbage --delete-older-than 5d";
        };

        oh-my-zsh = {
            enable = true;
            plugins = [
            ];
        };
    };
}