FROM ubuntu as builder

RUN apt-get update -yqq && \
    apt-get install -yq libvncserver-dev libgcrypt-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update -yqq && \
    apt-get install -yq build-essential make curl

WORKDIR /bochs

RUN curl -sL http://bochs.sourceforge.net/svn-snapshot/bochs-20180819.tar.gz | tar xz --strip-components=1

RUN ./configure --with-vncsrv && \
    make

FROM ubuntu

RUN apt-get update -yqq && \
    apt-get install -yq libvncserver-dev libgcrypt-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /bochs/bios/* /usr/share/bochs/bios/
COPY --from=builder /bochs/bochs /usr/bin/bochs

ENV BXSHARE=/usr/share/bochs/bios

EXPOSE 5900

WORKDIR /mnt
CMD ["bochs","-q"]
