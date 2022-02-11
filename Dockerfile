FROM debian:11

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata && \
    apt-get install -y --no-install-recommends python3-pip unzip supervisor sqlite3 git nginx python-setuptools curl && \
    apt-get install -y calibre=5.12.0+dfsg-1+deb11u1

RUN mv /tmp/sources.list /etc/apt/sources.list

# debian里安装的pyqt5版本v5.15.2有问题（issue talebook/talebook#124），需要更新为5.15.3
RUN pip install pyqt5==5.15.3

ENTRYPOINT ["/bin/bash"]
