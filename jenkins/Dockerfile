FROM runtimeverificationinc/ubuntu:bionic

RUN    apt-get update                                                         \
    && apt-get upgrade --yes                                                  \
    && apt-get install --yes                                                  \
        autoconf                    \
        bison                       \
        clang-8                     \
        cmake                       \
        curl                        \
        flex                        \
        gcc                         \
        jq                          \
        libboost-test-dev           \
        libcrypto++-dev             \
        libffi-dev                  \
        libjemalloc-dev             \
        libmpfr-dev                 \
        libprocps-dev               \
        libprotobuf-dev             \
        libsecp256k1-dev            \
        libssl-dev                  \
        libtool                     \
        libyaml-dev                 \
        lld-8                       \
        llvm-8-tools                \
        make                        \
        maven                       \
        netcat-openbsd              \
        opam                        \
        openjdk-11-jdk              \
        pandoc                      \
        pkg-config                  \
        protobuf-compiler           \
        python3                     \
        python-pygments             \
        python-recommonmark         \
        python-sphinx               \
        rapidjson-dev               \
        software-properties-common  \
        time                        \
        zlib1g-dev

RUN    add-apt-repository ppa:ethereum/ethereum \
    && apt-get update                           \
    && apt-get install --yes solc

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install --yes nodejs
RUN npm install -g npx

RUN wget -qO- https://get.haskellstack.org/ | bash -

USER user:user
