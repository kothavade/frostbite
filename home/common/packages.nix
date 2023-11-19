{ pkgs, ... }: {
  home.packages = with pkgs; [
    # tools
    docker
    sccache
    yt-dlp
    wget
    htop
    fzf
    ripgrep
    fd
    bat
    delta
    fastfetch
    gh
    github-copilot-cli
    tree-sitter
    # languages
    typst
    nodejs_20
    bun
    clang-tools
    nil
    nixfmt
    statix
  ];
}