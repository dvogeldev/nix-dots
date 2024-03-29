{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.hardware.keyd;
in {
  options.hardware.keyd = with types; {
    enable = mkBoolOpt false "Enable keyd";
  };

  config = mkIf cfg.enable {
    services.keyd = {
      enable = true;
      keyboards.default = {
        ids = [ "*" ];
	settings.main = {
	  capslock = "overload(control, esc)";
	  esc = "capslock";
	  # shift = "oneshot(shift)";
	  leftalt = "oneshot(alt)";
	  rightalt = "oneshot(altgr)";
        };
      };
    };
  };
}
