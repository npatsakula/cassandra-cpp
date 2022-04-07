{
  pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs-channels/archive/b58ada326aa612ea1e2fb9a53d550999e94f1985.tar.gz") {}
}:

pkgs.stdenv.mkDerivation rec {
    pname = "cassandra-cpp";
    version = "2.16.2";

    src = pkgs.fetchgit {
      url = "https://github.com/datastax/cpp-driver.git";
      rev = "refs/tags/${version}";
      sha256 = "sha256-NAvaRLhEvFjSmXcyM039wLC6IfLws2rkeRpbE5eL/rQ=";
    };

    LIBUV_ROOT_DIR = "${pkgs.libuv}/";
    nativeBuildInputs = with pkgs; [
      zlib
      cmake
      libuv
      openssl
    ];
}

