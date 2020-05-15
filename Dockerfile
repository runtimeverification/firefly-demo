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

ARG USER_ID=1000
ARG GROUP_ID=1000
RUN groupadd -g $GROUP_ID user && useradd -m -u $USER_ID -s /bin/sh -g user user

USER user:user
WORKDIR /home/user
