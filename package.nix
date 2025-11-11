{
  lib,
  rustPlatform,
  atk,
  cairo,
  dbus,
  glib,
  openssl,
  pkg-config,
  treefmt,
  zlib,
  systemd,
  systemdLibs,
  llvm,
  wayland,
  llvmPackages,
  curl,
  gcc,
  xorg,
  libGL,
  libxkbcommon,
  freetype,
  vulkan-validation-layers,
  vulkan-headers,
  vulkan-loader,
  vulkan-tools,
  expat,
  makeBinaryWrapper,
  slimevr-wrangler-src,
}:
rustPlatform.buildRustPackage (_finalAttrs: {
  pname = "slimevr-wrangler";
  version = "0.11.0";

  src = slimevr-wrangler-src.outPath;

  buildInputs = [
    curl
    gcc
    openssl
    pkg-config
    zlib
    freetype
    expat
    systemdLibs
    llvmPackages.libclang
    xorg.libX11
    xorg.libXcursor
    xorg.libXi
    xorg.libXrandr
    libGL
    libxkbcommon
    freetype
    freetype.dev
    vulkan-validation-layers
    vulkan-headers
    vulkan-loader
    vulkan-tools
    wayland
  ];

  nativeBuildInputs = [
    atk
    cairo
    dbus
    dbus.lib
    glib.out
    openssl.out
    pkg-config
    zlib
    systemd
    llvm
    expat
    makeBinaryWrapper
  ];

  runtimeLibs = [
    wayland
    vulkan-validation-layers
    vulkan-loader
    libxkbcommon
    xorg.libX11
    xorg.libXcursor
    xorg.libXi
    xorg.libXrandr
    llvmPackages.libclang
  ];

  postInstall = ''
    wrapProgram $out/bin/slimevr-wrangler \
      --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath _finalAttrs.runtimeLibs}"
  '';

  VK_LAYER_PATH = "${vulkan-validation-layers}/share/vulkan/explicit_layer.d";
  LIBCLANG_PATH = "${llvmPackages.libclang.lib}/lib";

  cargoHash = "sha256-dM8yjPEHpsrmleO1pSQk8uGTtuexvBMbOFaI8Nd7KWs=";

  meta = {
    mainProgram = "slimevr-wrangler";
    description = "Use Joycons as SlimeVR trackers with this middleware application";
    homepage = "https://github.com/carl-anders/slimevr-wrangler/";
    license = [lib.licenses.mit lib.licenses.asl20];
    maintainers = [];
  };
})
