FROM runtimeverificationinc/ubuntu:bionic

RUN    apt-get update                  \
    && apt-get upgrade --yes           \
    && apt-get install --yes           \
            autoconf                   \
            bison                      \
            clang-8                    \
            cmake                      \
            flex                       \
            gcc                        \
            git                        \
            libboost-test-dev          \
            libcrypto++-dev            \
            libffi-dev                 \
            libgflags-dev              \
            libjemalloc-dev            \
            libmpfr-dev                \
            libprocps-dev              \
            libsecp256k1-dev           \
            libssl-dev                 \
            libtool                    \
            libyaml-dev                \
            lld-8                      \
            llvm-8-tools               \
            make                       \
            maven                      \
            openjdk-11-jdk             \
            pandoc                     \
            pkg-config                 \
            python3                    \
            rapidjson-dev              \
            software-properties-common \
            zip                        \
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

RUN wget -qO- https://get.haskellstack.org/ | bash -

USER user:user
