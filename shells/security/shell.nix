let pkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/refs/tags/24.05.tar.gz") {}; in
pkgs.mkShell {
  buildInputs = with pkgs; [
    # Generic programmes
    busybox
    curl
    lynx
    mariadb
    minicom
    python312Packages.names
    p7zip
    socat
    wget

    # "Specific" programmes
    ares-rs
    cero
    changetower
    creds
    girsh
    gobuster
    goreplay
    john
    nmap
    pwntools
    ronin groff # nroff for help subcmd
    routersploit
    tlsx

    # Net tools
    inetutils
    ipcalc
    junkie
    macchanger
    netmask
    netsniff-ng
    ngrep
    termshark
    wireshark
    wireshark-cli
    xh

    # Host welfare
    clamav
    lynis
    vulnix

    # Monitors
    btop
    htop
    iftop
    iotop

    # Protocols clients
    cifs-utils
    freerdp
    openvpn
    samba

    # OSINT helpers
    cloudbrute
    exiflooter
    maigret
    metabigor
    p0f
    snscrape
    socialscan
    theharvester

    # Binary
    bingrep
    cutter
    gdb
    ghidra
    yara

    # Radio
    aircrack-ng
    airgeddon
    bully
    cowpatty
    dbmonster
    horst
    iw
    kismet
    netscanner
    pixiewps
  ];
}
