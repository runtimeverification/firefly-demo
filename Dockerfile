ARG DOCKERHUB_TAG
FROM runtimeverificationinc/runtimeverification-firefly:${DOCKERHUB_TAG}

USER root:root

RUN    apt-get update                          \
    && apt-get upgrade --yes                   \
    && apt-get install --yes                   \
                    curl                       \
                    software-properties-common

RUN    curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get update                                          \
    && apt-get upgrade --yes                                   \
    && apt-get install --yes nodejs

RUN    add-apt-repository ppa:ethereum/ethereum \
    && apt-get update                           \
    && apt-get upgrade --yes                    \
    && apt-get install --yes solc

USER user:user
WORKDIR /home/user

ENV LC_ALL=C.UTF-8
