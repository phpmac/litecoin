FROM ubuntu:latest

# 安装基础依赖
RUN apt-get update && apt-get install -y \
    libdb-dev \
    libdb++-dev \
    build-essential \
    libtool \
    autotools-dev \
    automake \
    pkg-config \
    bsdmainutils \
    python3 \
    libssl-dev \
    libevent-dev \
    libboost-system-dev \
    libboost-filesystem-dev \
    libboost-test-dev \
    libboost-thread-dev \
    libfmt-dev \
    libsqlite3-dev \
    libminiupnpc-dev \
    libzmq3-dev \
    libqt5gui5 \
    libqt5core5a \
    libqt5dbus5 \
    qttools5-dev \
    qttools5-dev-tools \
    libqrencode-dev \
    git \
    wget \
    && rm -rf /var/lib/apt/lists/*

# 克隆代码并编译
WORKDIR /litecoin
RUN git clone git@github.com:phpmac/litecoin.git . && \
    ./contrib/install_db4.sh `pwd` && \
    ./autogen.sh && \
    ./configure --disable-wallet --without-gui --without-miniupnpc && \
    make && \
    make install

# 设置默认命令
CMD ["litecoind"]