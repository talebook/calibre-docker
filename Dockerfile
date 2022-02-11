FROM debian:9

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install tzdata && \
    apt-get install python-pip unzip supervisor sqlite3 git nginx python-setuptools curl -y --no-install-recommends && \
    apt-get install calibre=2.75.1+dfsg-1 -y

ENTRYPOINT ["/bin/bash"]
