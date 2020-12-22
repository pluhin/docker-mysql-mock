FROM ubuntu:18.04
ENV DEBIAN_FRONTEND "noninteractive"
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y git cmake tzdata build-essential libevent-dev doxygen libmysqlclient-dev && \
    apt-get install -y libncurses5-dev pkg-config libtirpc-dev bison && \
    git clone https://github.com/mysql/mysql-server.git /opt/mysql-server && \
    cd /opt/mysql-server && \
    mkdir build && cd build && \
    cmake ..  -DDOWNLOAD_BOOST=1 -DWITH_BOOST=/opt/boost && \
    make install && \
    apt remove --purge --auto-remove -y git cmake build-essential && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /opt/mysql-server

EXPOSE 3306
