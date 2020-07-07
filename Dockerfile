ARG DOCKERHUB_TAG
FROM runtimeverificationinc/runtimeverification-firefly:${DOCKERHUB_TAG}

RUN    apt-get update        \
    && apt-get upgrade --yes \
    && apt-get install --yes \
                    curl

RUN    curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get update                                          \
    && apt-get upgrade --yes                                   \
    && apt-get install --yes nodejs

ARG USER_ID=1000
ARG GROUP_ID=1000
RUN groupadd -g $GROUP_ID user && useradd -m -u $USER_ID -s /bin/sh -g user user

USER user:user
WORKDIR /home/user

ENV NPM_PACKAGES=/home/user/.npm-packages
ENV PATH=$NPM_PACKAGES/bin:$PATH
RUN npm config set prefix $NPM_PACKAGES

ENV LC_ALL=C.UTF-8
