{
 lib,
 config,
 ...
};

{
 
  networking.networkmanager.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];

}
