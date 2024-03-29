{pkgs, ...}: {
  home.packages = with pkgs; [
    #- tools
    devenv
    docker
    sccache
    yt-dlp
    wget
    htop
    fzf
    ripgrep
    fd
    bat
    fastfetch
    gh
    tree-sitter
    imagemagick
    websocat
    bitwarden-cli
    pandoc
    jujutsu
    #- languages
    #-- js
    nodejs_20
    bun
    deno
    #-- c
    clang-tools
    #-- nix
    nil
    # nixfmt
    alejandra
    statix
    #-- lua
    lua-language-server
    #-- typst
    typst
    typst-lsp
    typst-preview
    #-- python
    nodePackages.pyright
    ruff-lsp
    #-- zig
    zig
    zls
    #-- golang
    go
    gopls
    gofumpt
  ];
}
