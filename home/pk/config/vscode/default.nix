{ pkgs, ... } :
{
    programs.vscode = {
        enable = true;
        extensions = with pkgs.vscode-extensions; [
            bbenoist.nix
            dracula-theme.theme-dracula
            esbenp.prettier-vscode
            ms-vscode.cpptools
            ms-vscode-remote.remote-ssh
            # James-Yu.latex-workshop
        ];
    };
}