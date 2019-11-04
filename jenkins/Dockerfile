FROM runtimeverificationinc/ubuntu:bionic

RUN    apt-get update              \
    && apt-get upgrade --yes       \
    && apt-get install --yes       \
        curl                       \
        g++                        \
        gcc                        \
        git                        \
        make                       \
        software-properties-common

RUN    add-apt-repository ppa:ethereum/ethereum \
    && apt-get update                           \
    && apt-get install --yes solc

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install --yes nodejs
RUN npm install -g npx

USER user:user
