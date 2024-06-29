ARG RUST_VERSION="1.79-alpine"

FROM rust:${RUST_VERSION} as development

LABEL author="Tiagocode <santiagomm1997@gmail.com>"
LABEL mantainer="Tiagocode <santiagomm1997@gmail.com>"
LABEL org.opencontainers.image.source="https://github.com/tiagocodecom/back-office"

ARG RUST_APP_PORT=8080

WORKDIR /tmp/app

RUN apk update && \
    apk add --no-cache musl-dev && \
    apk add --no-cache  \
        openssl  \
        openssh \
        curl  \
        bash  \
        git \
        unzip \
        zsh

RUN curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash

RUN cargo binstall -y cargo-watch && \
    cargo binstall -y sqlx-cli

COPY . .

EXPOSE $RUST_APP_PORT

ENV PORT $RUST_APP_PORT

CMD ["cargo", "watch", "-x", "run"]
