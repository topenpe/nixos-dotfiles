let pkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/refs/tags/24.05.tar.gz") {}; in
pkgs.mkShell {
  buildInputs = with pkgs; [
    (pkgs.python312.withPackages (python312Packages: [
      python312Packages.pip
      python312Packages.torch
      python312Packages.torchaudio
      python312Packages.torchvision
    ]))
  ];

  shellHook = ''
    export HSA_OVERRIDE_GFX_VERSION=10.3.0
  '';
}
