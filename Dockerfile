FROM ubuntu:18.04
ENV DEBIAN_FRONTEND "noninteractive"
ADD mysql-server /opt/mysql-server
RUN apt-get update -y && \
    apt-get install -yqq git cmake tzdata build-essential libevent-dev doxygen libmysqlclient-dev && \
    apt-get install -yqq libncurses5-dev pkg-config libtirpc-dev bison && \
    mkdir -p /opt/{lib,plugins,mysql} && mkdir -p /opt/mysql/test && \
    mkdir /opt/build && cd /opt/build && \
    cmake ../mysql-server  -DDOWNLOAD_BOOST=1 -DWITH_BOOST=/opt/boost -DINSTALL_LIBDIR=/opt/lib -DINSTALL_PLUGINDIR=/opt/plugins -DINSTALL_MYSQLTESTDIR=/opt/mysql/test  && \
    make install && \
    apt remove --purge --auto-remove -y git cmake build-essential libevent-dev doxygen libncurses5-dev pkg-config libtirpc-dev bison && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /opt/mysql-server /opt/mysql /opt/plugins /opt/lib /opt/boost && \
    mv /opt/build/library_output_directory/ /tmp && \
    mv /opt/build/plugin_output_directory/ /tmp && \
    mv /opt/build/runtime_output_directory/ /tmp && \
    rm -rf /opt/build/*  && \
    mv /tmp/library_output_directory/ /opt/build/ && \
    mv /tmp/plugin_output_directory/ /opt/build/ && \
    mv /tmp/runtime_output_directory/ /opt/build/ && \
    rm  /opt/build/runtime_output_directory/pfs_connect_attr-t /opt/build/runtime_output_directory/mysqld
