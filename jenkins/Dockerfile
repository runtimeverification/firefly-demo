FROM runtimeverificationinc/ubuntu:bionic

RUN    apt-get update                \
    && apt-get upgrade --yes         \
    && apt-get install --yes         \
            autoconf                 \
            binutils-dev             \
            bison                    \
            clang-8                  \
            cmake                    \
            curl                     \
            flex                     \
            g++                      \
            gcc                      \
            gperf                    \
            jq                       \
            libboost-all-dev         \
            libcap-dev               \
            libcrypto++-dev          \
            libdouble-conversion-dev \
            libevent-dev             \
            libffi-dev               \
            libgflags-dev            \
            libgoogle-glog-dev       \
            libiberty-dev            \
            libjemalloc-dev          \
            libkrb5-dev              \
            liblz4-dev               \
            liblzma-dev              \
            libmpfr-dev              \
            libnuma-dev              \
            libprocps-dev            \
            libprotobuf-dev          \
            libsasl2-dev             \
            libsecp256k1-dev         \
            libsnappy-dev            \
            libsodium-dev            \
            libssl-dev               \
            libtool                  \
            libyaml-dev              \
            libzstd-dev              \
            lld-8                    \
            llvm-8-tools             \
            make                     \
            maven                    \
            netcat-openbsd           \
            opam                     \
            openjdk-11-jdk           \
            pandoc                   \
            pkg-config               \
            protobuf-compiler        \
            python3                  \
            python-pygments          \
            python-recommonmark      \
            python-sphinx            \
            rapidjson-dev            \
            time                     \
            unzip                    \
            wget                     \
            zlib1g-dev

RUN    git clone 'https://github.com/z3prover/z3' --branch=z3-4.6.0 \
    && cd z3                                                        \
    && python scripts/mk_make.py                                    \
    && cd build                                                     \
    && make -j8                                                     \
    && make install                                                 \
    && cd ../..                                                     \
    && rm -rf z3

RUN    add-apt-repository ppa:ethereum/ethereum \
    && apt-get update                           \
    && apt-get install --yes solc

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install --yes nodejs
RUN npm install -g npx

RUN wget -qO- https://get.haskellstack.org/ | bash -

USER user:user
