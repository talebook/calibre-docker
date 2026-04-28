FROM debian:13-slim

ARG TARGETARCH
ARG TARGETVARIANT
ENV DEBIAN_FRONTEND=noninteractive
ENV PIP_BREAK_SYSTEM_PACKAGES=1

# 安装基础系统（包含 PyQt5 系统包）
RUN apt-get update && \
    apt-get install -y \
        tzdata \
        python3 \
        python3-pip \
        python3-venv \
        nginx \
        supervisor \
        sqlite3 \
        curl \
        wget \
        unzip \
        git \
        ca-certificates \
        # PyQt5 系统包
        python3-pyqt5 \
        python3-pyqt5.qtwebengine \
        python3-pyqt5.qtsql \
        python3-pyqt5.qtmultimedia \
        # Calibre 相关依赖
        python3-dateutil \
        python3-cssselect \
        python3-lxml \
        python3-pil \
        python3-psutil \
        python3-chardet \
        python3-html5lib \
        fonts-liberation && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 根据架构安装 Calibre
RUN echo "Installing Calibre via apt for $TARGETARCH $TARGETVARIANT" && \
    apt-get update && \
    apt-get install -y calibre && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*;

# 验证 Calibre 安装
RUN echo "Verifying Calibre installation..." && \
    if command -v calibre > /dev/null 2>&1; then \
        echo "Calibre installed successfully" && \
        calibre --version; \
    else \
        echo "Calibre installation failed" && \
        exit 1; \
    fi

# 验证 PyQt5 安装
RUN echo "Verifying PyQt5 installation..." && \
    python3 -c "import PyQt5; print('PyQt5 imported successfully')" && \
    python3 -c "import PyQt5.QtWebEngine; print('PyQt5.QtWebEngine imported successfully')"

# 安装 Python 包（使用 --break-system-packages）
RUN pip3 install --no-cache-dir --break-system-packages \
    flask \
    sqlalchemy \
    requests \
    beautifulsoup4

# 创建应用用户
RUN useradd -m -u 1000 -s /bin/bash talebook && \
    mkdir -p /app /data && \
    chown talebook:talebook /app /data

USER talebook
WORKDIR /app

CMD ["/bin/bash"]