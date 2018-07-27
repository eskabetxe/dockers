FROM bitnami/minideb:stretch
MAINTAINER eskabetxe

RUN set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
	   autoconf automake curl flex g++ gcc gdb git \
	   libsasl2-dev libsasl2-modules libsasl2-modules-gssapi-mit libssl-dev libtool lsb-release \
	   make ntp openjdk-8-jdk openssl patch pkg-config python rsync unzip vim-common \
    && apt-get autoremove \
    && apt-get autoclean

WORKDIR /opt/git
RUN git clone https://github.com/apache/kudu
WORKDIR /opt/git/kudu

RUN thirdparty/build-if-necessary.sh

RUN mkdir -p build/release
RUN cd build/release
RUN ../../thirdparty/installed/common/bin/cmake -DCMAKE_BUILD_TYPE=release ../..
RUN make -j4

RUN sudo make DESTDIR=/opt/kudu install


COPY docker-entrypoint.sh /
RUN chmod a+x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
EXPOSE 8050 8051 7050 7051
#CMD ["help"]
