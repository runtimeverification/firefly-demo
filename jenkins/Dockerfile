FROM runtimeverificationinc/ubuntu:bionic

RUN    apt-get update                   \
    && apt-get upgrade --yes            \
    && apt-get install --yes            \
        make software-properties-common

RUN    add-apt-repository ppa:ethereum/ethereum \
    && apt-get update                           \
    && apt-get install solc

USER user:user
