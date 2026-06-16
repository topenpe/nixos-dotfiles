{ lib, config, pkgs, ... }:

{ # Here I include some packages needed for running virtual machines
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        runAsRoot = false;
        swtpm.enable = true;
      };
    };
  };

  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [
    virt-viewer
    looking-glass-client
    spice-gtk
    spice-vdagent
  ];
}
