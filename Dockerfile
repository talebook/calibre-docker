FROM debian:11

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata && \
    apt-get install -y --no-install-recommends python3-pip unzip supervisor sqlite3 git nginx python-setuptools curl && \
    apt-get install -y calibre=5.12.0+dfsg-1+deb11u1

# debian里安装的pyqt5版本v5.15.2有问题，需要更新为5.15.3（issue talebook/talebook#124）
# ARM下安装失败，先仅安装X86
RUN if [ $(uname -m) == "x86_64" ]; then pip3 install -I pyqt5==5.15.3; fi

ENTRYPOINT ["/bin/bash"]
