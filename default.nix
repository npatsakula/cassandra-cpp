{ pkgs ? import <nixpkgs> {}
, examples ? false
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
      cmake
      zlib libuv openssl.dev
    ];

    cmakeFlags = pkgs.lib.attrsets.mapAttrsToList
      (name: value: "-DCASS_BUILD_${name}:BOOL=${if value then "ON" else "OFF"}") {
        EXAMPLES = examples;
      };

    enableParallelBuilding = true;
    meta = with pkgs.lib; {
      description = "DataStax CPP cassandra driver";
      longDescription = ''
        A modern, feature-rich and highly tunable C/C++ client
        library for Apache Cassandra 2.1+ using exclusively Cassandra’s
        binary protocol and Cassandra Query Language v3.
      '';
      license = with licenses; [ asl20 ];
      platforms = platforms.all;
    };
}

