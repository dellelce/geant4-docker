# vim:set ft=dockerfile
FROM alpine:3.9 as build

LABEL maintainer="Antonio Dell'Elce"

ARG PREFIX=/app/geant4
ENV INSTALLDIR  ${PREFIX}

# 1. Install compiler packages

RUN apk add bash vim wget gawk openssh-client   \
            gcc g++ git libc-dev make           \
            cmake bison file                    \
            perl                                \
            linux-headers

# 2. Install mkit

RUN v=geant4; cd && wget -O mkit.tar.gz -q "https://github.com/dellelce/mkit/archive/${v}.tar.gz" && \
    tar xf mkit.tar.gz && mv mkit-* mkit && ln -s ../mkit/mkit.sh bin && rm mkit.tar.gz

# 3. build with mkit

RUN /root/mkit/mkit.sh profile=geant4 $PREFIX

# 3a. remove uneeded files /clean build

# 4. Copy required files from build stage to finale stage
