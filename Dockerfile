FROM ethereum/client-go:v1.7.2

LABEL maintainer="ian.schreuder@gmail.com"

ENV GENESIS_NONCE="0xabbbcbdbadbdcded" \
    GENESIS_CHAIN_ID=1984 \
    DATA_DIR="/root/.ethereum"

ENV APP_DIR   /svc
WORKDIR $APP_DIR

ADD svc/* $APP_DIR/
RUN chmod +x $APP_DIR/*.sh

# DEFINED in ethereum/client-go
#EXPOSE 8545 8546 30303 30303/udp 30304/udp
EXPOSE 30310
EXPOSE 30310/udp

ENTRYPOINT $APP_DIR/start.sh

