FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    libtool \
    autotools-dev \
    automake \
    pkg-config \
    libssl1.0-dev \
    libevent-dev \
    bsdmainutils \
    libboost-all-dev \
    git \
    wget \
    zlib1g-dev

# Download and extract Bitcoin source
WORKDIR /tmp
RUN wget https://bitcoin.ninja/ancient-bitcoind/bitcoin-0.5.2-linux.tar.gz && \
    tar xzf bitcoin-0.5.2-linux.tar.gz && \
    cp bitcoin-0.5.2-linux/bin/64/bitcoind /usr/local/bin/ && \
    chmod +x /usr/local/bin/bitcoind && \
    rm -rf bitcoin-0.5.2-linux*

EXPOSE 8332 8333

CMD ["bitcoind"]
