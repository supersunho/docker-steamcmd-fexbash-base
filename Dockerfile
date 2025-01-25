FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive 

# Build arguments for cross-compilation
ARG TARGETPLATFORM

RUN apt update && apt-get install -y \
    build-essential \
    git \
    cmake \
    ninja-build \
    pkg-config \
    ccache \
    clang \
    llvm \
    lld \
    binfmt-support \
    libsdl2-dev \
    libepoxy-dev \
    libssl-dev \
    python3-setuptools \ 
    libgcc-12-dev-amd64-cross \
    libgcc-12-dev-arm64-cross \
    libgcc-12-dev-i386-cross  \
    libgcc-12-dev-armhf-cross \
    nasm \
    python3-clang 
RUN apt-get install -y \
    libstdc++-12-dev-amd64-cross \
    libstdc++-12-dev-arm64-cross \
    libstdc++-12-dev-i386-cross \
    libstdc++-12-dev-armhf-cross \
    squashfs-tools \
    squashfuse \
    libc-bin \ 
    libc6-dev-i386-amd64-cross \
    libc6-dev-amd64-i386-cross \
    lib32stdc++-12-dev-amd64-cross \ 
    expect \ 
    sudo \
    fuse \ 
    qtbase5-dev \
    qtdeclarative5-dev \
    curl

# Install platform-specific dependencies
RUN if [ "$TARGETPLATFORM" = "linux/arm64" ]; then \
        apt-get install -y \
        gcc-aarch64-linux-gnu \
        g++-aarch64-linux-gnu; \
    elif [ "$TARGETPLATFORM" = "linux/armv7" ]; then \
        apt-get install -y \
        gcc-arm-linux-gnueabihf \
        g++-arm-linux-gnueabihf; \
    else \
        echo "Unsupported platform: $TARGETPLATFORM" && exit 1; \
    fi 

# Clean up
RUN apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 
 