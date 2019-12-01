FROM debian:testing

RUN apt-get update \
  && apt-get install -y --no-install-recommends gnupg dirmngr \
  && rm -rf /var/lib/apt/lists/* \
  && export GNUPGHOME="$(mktemp -d)" \
  && gpg --batch --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
  && gpg --batch --export --armor 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF > /etc/apt/trusted.gpg.d/mono.gpg.asc \
  && gpgconf --kill all \
  && rm -rf "$GNUPGHOME" \
  && apt-key list | grep Xamarin \
  && apt-get purge -y --auto-remove gnupg dirmngr

# https://www.mono-project.com/download/stable/
ARG MONO_VERSION=6.4.0.198
RUN echo "deb http://download.mono-project.com/repo/debian vs-stretch/snapshots/$MONO_VERSION main" > /etc/apt/sources.list.d/mono-official-vs.list

RUN  apt-get update \
  && apt-get install -y wget xz-utils build-essential libtool-bin cmake git curl vim \
     libgmp-dev libssl-dev libssl1.1 libxml2 lbzip2 libtinfo5 libtool zlib1g libicu63 \
     libpcre3-dev libevent-dev libboost-dev libjson-c-dev libblas-dev liblapack-dev libopenblas-dev \
     python python-numpy python3 python-ujson python3-ujson \
     mono-devel nuget \
     chezscheme gccgo gdc \
     luajit lua5.3 tcl tcllib jq php elixir clang-9 opam \
  && rm -rf /var/lib/apt/lists/* /tmp/* \
  && ln -s /usr/bin/clang-9 /usr/bin/clang

WORKDIR /opt

# https://www.ruby-lang.org/en/downloads/
RUN export VERSION=ruby-2.6.5 \
    && wget --progress=dot:giga -O - \
    https://cache.ruby-lang.org/pub/ruby/2.6/$VERSION.tar.gz \
    | tar -xz \
    && cd $VERSION \
    && ./configure --prefix=/opt/ruby && make -j && make install \
    && rm -rf $VERSION
ENV PATH="/opt/ruby/bin:${PATH}"

# https://www.rust-lang.org/tools/install
ENV CARGO_HOME="/opt/.cargo" PATH="/opt/.cargo/bin:${PATH}"
RUN wget -O - https://sh.rustup.rs | sh -s -- -y

ARG SCRIPTS_VER=unknown
COPY *.rb ./

ENTRYPOINT ["./run.rb"]

RUN cat /etc/os-release

