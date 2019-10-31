FROM runtimeverificationinc/ubuntu:bionic

RUN    apt-get update                                                  \
    && apt-get upgrade --yes                                           \
    && apt-get install --yes                                           \
        clang-8 cmake curl dh-make git libcrypto++-dev libjemalloc-dev \
        libprocps-dev libprotobuf-dev libsecp256k1-dev libssl-dev      \
        netcat-openbsd pandoc pkg-config protobuf-compiler             \
        software-properties-common sudo

RUN    add-apt-repository ppa:ethereum/ethereum \
    && apt-get update                           \
    && apt-get install --yes solc

USER user:user
