let
  #nixpkgs = builtins.fetchTarball https://github.com/nixos/nixpkgs/archive/fe776684583f74a7fe4817271fd30e95ffcd50ca.tar.gz;
  nixpkgs = builtins.fetchTarball https://github.com/nixos/nixpkgs/archive/0d722e8e1b409fddebb33a3d190e32dc89de1d3d.tar.gz;
  #nixpkgs = builtins.fetchTarball https://github.com/nixos/nixpkgs/archive/e38accb2b0e6b3d2d0ed8a5c642661bbcbfb3d4f.tar.gz;
  rust-overlay = builtins.fetchTarball https://github.com/oxalica/rust-overlay/archive/master.tar.gz;
  pkgs = import nixpkgs { overlays = [ (import rust-overlay) ]; };
in
pkgs.mkShell rec {
  buildInputs = [
    pkgs.alsa-lib
    pkgs.libxkbcommon
    pkgs.openssl
    pkgs.python3
    pkgs.udev
    pkgs.vulkan-loader
    pkgs.wasm-bindgen-cli
    pkgs.wayland
    pkgs.xorg.libX11
    pkgs.xorg.libXcursor
    pkgs.xorg.libXi
    pkgs.xorg.libXrandr
    pkgs.cargo-outdated
    (pkgs.rust-bin.stable."1.68.0".default.override {
      targets = [ "wasm32-unknown-unknown" ];
    })
  ];
  nativeBuildInputs = [ pkgs.pkg-config ];
  LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath buildInputs;
}
