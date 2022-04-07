{ pkgs ? import <nixpkgs> {}, }:

pkgs.stdenv.mkDerivation rec {
    pname = "cassandra-cpp";
    version = "2.16.2";

    src = pkgs.fetchgit {
      url = "https://github.com/datastax/cpp-driver.git";
      rev = "refs/tags/${version}";
      sha256 = "sha256-NAvaRLhEvFjSmXcyM039wLC6IfLws2rkeRpbE5eL/rQ=";
    };

    LIBUV_ROOT_DIR = "${pkgs.libuv}/";
    buildInputs = pkgs.lib.optional pkgs.stdenv.hostPlatform.isUnix pkgs.bash;
    nativeBuildInputs = with pkgs; [
      zlib
      cmake
      libuv
      openssl
    ];

    enableParallelBuilding = true;
    outputs = [ "dev" "out" ];

    meta = with pkgs.lib; {
      description = "DataStax CPP cassandra driver";
      license = with licenses; [ mit ];
      platforms = platforms.all;
    };
}

