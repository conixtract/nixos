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
        };

        oh-my-zsh = {
            enable = true;
            plugins = [
            ];
        };
    };
}