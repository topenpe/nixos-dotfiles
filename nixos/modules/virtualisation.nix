{
  pkgs,
  config,
  lib,
  ...
}:

{
  options.queenOfVirt.enable = lib.mkEnableOption "Enable Virt-Manager";

  config = lib.mkIf config.queenOfVirt.enable {
    virtualisation.libvirtd = {
      enable = true;
      onBoot = "ignore";
    };

    programs.virt-manager.enable = true;
  };
}
