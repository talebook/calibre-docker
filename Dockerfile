FROM debian:11

RUN cp /etc/apt/sources.list /tmp/ && \
    sed 's@deb.debian.org@mirrors.tencentyun.com@' -i /etc/apt/sources.list && \
    sed 's@security.debian.org@mirrors.tencentyun.com@' -i /etc/apt/sources.list

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata && \
    apt-get install -y --no-install-recommends python3-pip unzip supervisor sqlite3 git nginx python-setuptools curl && \
    apt-get install -y calibre=5.12.0+dfsg-1+deb11u1

RUN mv /tmp/sources.list /etc/apt/sources.list

# debian里安装的pyqt5版本v5.15.2有问题（issue talebook/talebook#124），需要更新为5.15.3
RUN pip install pyqt5==5.15.3 -i https://mirrors.tencent.com/pypi/simple/

ENTRYPOINT ["/bin/bash"]
