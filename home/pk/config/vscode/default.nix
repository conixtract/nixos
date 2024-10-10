{ pkgs, ... } :
{
    programs.vscode = {
        enable = true;
        package = pkgs.vscode.fhs;
        # package = pkgs.vscode.fhsWithPackages (ps: with ps; [ gdb pkg-config ]);
        extensions = with pkgs.vscode-extensions; [
            bbenoist.nix
            dracula-theme.theme-dracula
            alefragnani.bookmarks
            esbenp.prettier-vscode
            ms-vscode.cpptools
            ms-vscode-remote.remote-ssh
            # James-Yu.latex-workshop
            ms-vscode.cmake-tools
            valentjn.vscode-ltex
        ];
    };
}
