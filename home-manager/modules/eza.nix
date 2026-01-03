{ pkgs, ... }:

{
  programs.eza = {
    enable = true;

    # força o eza do nixpkgs unstable
    package = pkgs.eza;

    enableZshIntegration = true;
    colors = "always";
    git = true;
    icons = "always";
    extraOptions = [
      "--group-directories-first"
      "--header"
    ];
  };
}
