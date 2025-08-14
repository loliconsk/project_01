FROM criyle/go-judge:latest AS go-judge 
FROM debian:latest
# 安装基本依赖
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    && rm -rf /var/lib/apt/lists/*

    # 安装 Java (OpenJDK 8)
RUN apt update && apt install openjdk-11-jdk  \
    && rm -rf /var/lib/apt/lists/*

# 安装 C/C++ 编译器 (GCC/G++)
RUN apt-get update && apt-get install -y --no-install-recommends \
    g++ \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# 安装 Python 3
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*


WORKDIR /opt
COPY --from=go-judge /opt/go-judge /opt/mount.yaml /opt/
EXPOSE 5050/tcp 5051/tcp 5052/tcp
ENTRYPOINT ["./go-judge"]
