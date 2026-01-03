{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;

    # força o Firefox Developer Edition do nixpkgs unstable
    package = pkgs.firefox-devedition;
  };
}
