FROM amd64/ubuntu:20.04 AS base

#SLM Wallet
LABEL maintainer="TesBmcgLQsowvYEYPXpSHkkapoTbVV7Xfe"

EXPOSE 4766/tcp
EXPOSE 4767/tcp

ENV DEBIAN_FRONTEND=noninteractive

#Install runtime dependencies
RUN apt-get update && \
	apt-get install -y --no-install-recommends \
	bash wget net-tools libminiupnpc17 \
	libevent-2.1 libevent-pthreads-2.1 \
	libboost-system1.71 libboost-filesystem1.71 libboost-chrono1.71 \
	libboost-program-options1.71 libboost-thread1.71 \
	libzmq5 && \
	apt-get clean

FROM base AS build

#Install build dependencies
RUN apt-get update && \
	apt-get install -y --no-install-recommends \
	bash net-tools build-essential libtool autotools-dev automake \
	pkg-config libssl-dev libevent-dev bsdmainutils python3 \
	libboost-system1.71-dev libboost-filesystem1.71-dev libboost-chrono1.71-dev \
	libboost-program-options1.71-dev libboost-test1.71-dev libboost-thread1.71-dev \
	libzmq3-dev libminiupnpc-dev && \
	apt-get clean

#Copy source dir
COPY . /home/slimecoin/build/Slimecoin/
WORKDIR /home/slimecoin/build/Slimecoin

#build db4 from source
WORKDIR /home/slimecoin/build/Slimecoin/contrib
RUN ./install_db4.sh ../../

# build Slimecoincore
WORKDIR /home/slimecoin/build/Slimecoin
RUN ./autogen.sh && ./configure --disable-tests BDB_LIBS="-L/home/slimecoin/build/db4/lib -ldb_cxx-4.8" BDB_CFLAGS="-I/home/slimecoin/build/db4/include" --with-gui=no  && make -j4

FROM base AS final

#Add our service account user
RUN useradd -ms /bin/bash slimecoin && \
	mkdir /var/lib/slimecoin && \
	chown slimecoin:slimecoin /var/lib/slimecoin && \
	ln -s /var/lib/slimecoin /home/slimecoin/.slimecoin && \
	chown -h slimecoin:slimecoin /home/slimecoin/.slimecoin

VOLUME /var/lib/slimecoin

#Copy the compiled binaries from the build
COPY --from=build /home/slimecoin/build/Slimecoin/src/slimecoind /usr/local/bin/slimecoind
COPY --from=build /home/slimecoin/build/Slimecoin/src/slimecoin-cli /usr/local/bin/slimecoin-cli

WORKDIR /home/slimecoin
USER slimecoin

CMD /usr/local/bin/slimecoind -datadir=/var/lib/slimecoin -printtoconsole -onlynet=ipv4
