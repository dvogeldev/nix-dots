{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.services.ssh;
in {
  options.services.ssh = with types; {
    enable = mkBoolOpt false "Enable ssh";
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      ports = [22];
      # PermitRootLogin = "prohibit-password";
    };

    users.users = let 
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJGvp5IARt6x0bwBtdG3GU7RssDecKX9CiBSVVZ1lLdI david@dvpc";
    in
    {
      root.openssh.authorizedKeys.keys = [
        publicKey
      ];
      ${config.user.name}.openssh.authorizedKeys.keys = [
        publicKey
      ];
    };

    home.file.".ssh/config".text = ''
      identityfile ~/.ssh/key 
    '';
  };
}
