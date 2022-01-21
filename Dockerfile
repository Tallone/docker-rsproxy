FROM co1e/debian-aliyun:slim
ENV CARGO_HOME=/root/.cargo \
    PATH=/root/.cargo/bin:$PATH

RUN apt-get install curl gcc ca-certificates libc6-dev git -y && \
    mkdir ~/.cargo && \
    touch ~/.cargo/config && \
    echo '[source.crates-io]\n\
        replace-with = "rsproxy"\n\
        [source.rsproxy]\n\
        registry = "https://rsproxy.cn/crates.io-index"\n\
        [registries.rsproxy]\n\
        index = "https://rsproxy.cn/crates.io-index"\n\
        [net]\n\
        git-fetch-with-cli = true' > /root/.cargo/config && \
    echo 'export RUSTUP_DIST_SERVER="https://rsproxy.cn"\n\
        export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"' >> ~/.bashrc && \
    export RUSTUP_DIST_SERVER="https://rsproxy.cn"; export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup" && \
    curl --proto '=https' --tlsv1.2 -sSf https://rsproxy.cn/rustup-init.sh >> rustup-init.sh && \
    sh rustup-init.sh -y --default-toolchain nightly && \
    rm rustup-init.sh && \
    chmod -R a+w $CARGO_HOME;
