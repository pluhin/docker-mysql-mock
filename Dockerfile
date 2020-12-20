FROM ubuntu:20.04

LABEL maintainer="pluhin@gmail.com"

ARG DEBIAN_FRONTEND=noninteractive

## Prerequisites
RUN apt-get update && \
    apt-get -yqq install wget cmake cmake-gui libaio-dev git build-essential g++ && \
    mkdir /mysql_source

## Add boost
# RUN git clone https://github.com/drbenmorgan/BoostBuilder.git BoostBuilder.git && \
#     mkdir Boost.Build && \
#     cd Boost.Build && \
#     cmake -DCMAKE_INSTALL_PREFIX=/opt/boost ../BoostBuilder.git && \
#     make


ADD mysql-server /mysql_source

WORKDIR /mysql_source
## Build 
RUN ls -l && \
    mkdir bld  && \
    cd bld && \ 
    cmake .. -DOWNLOAD_BOOST=OFF -DBUILD_CONFIG=mysql_release && \
    make