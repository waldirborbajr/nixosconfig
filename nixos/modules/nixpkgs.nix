{

#  nixpkgs.config.allowUnfree = true;

  nixpkgs.config = {
    # === Package Permissions ===
    allowUnfree = true;                 # Allow proprietary packages (VS Code, Slack, etc.)
    allowBroken = false;                              # Prevent installation of known broken packages
    allowInsecure = false;                            # Prevent installation of packages with security vulnerabilities

    # === Package-Specific Overrides ===
    permittedInsecurePackages = [
      # Add specific packages here if needed for compatibility
      # Example: "package-name-version"
    ];
  };

  nix.settings = {
    experimental-features = [
        "nix-command"                                 # Enable new CLI commands (nix build, nix run, etc.)
        "flakes"                                      # Enable Nix flakes for reproducible configurations
        "ca-derivations"                              # Content-addressed derivations for enhanced security
        "fetch-closure"                               # Secure closure fetching from trusted sources  
    ];
    auto-optimise-store = true;
  };

 # nix.gc = {
 #   automatic = true;
 #   dates = "weekly";
 #   options = "--delete-older-than 7d";
 # };

   # === Automatic Maintenance ===
   nix.gc = {
      automatic = true;                               # Enable automatic garbage collection
      dates = "weekly";
      options = "--delete-older-than 3d --max-freed 10G"; # Keep 21 days, max 10GB freed per run
    };

  # nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
