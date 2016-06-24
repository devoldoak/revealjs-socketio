# Dockerfile for a reveal.js socket.io server


FROM alpine:3.3

MAINTAINER Romain Pigeyre <rpigeyre@gmail.com>

ENV REVEALJS_VERSION 3.3.0

RUN \
    # For wget with https
    apk update && \
    apk add ca-certificates && \
    update-ca-certificates && \
    # Install NodeJS
    apk add nodejs \
            python \
            make \
            g++ && \
    # Update NPM
    npm install -g npm && \

#RUN \
    # Get revealJS
    cd /tmp && \
    wget https://github.com/hakimel/reveal.js/archive/${REVEALJS_VERSION}.tar.gz && \
    tar xzf ${REVEALJS_VERSION}.tar.gz && \
    # Build socket.io directory
    mv reveal.js-${REVEALJS_VERSION}/plugin/multiplex /socket.io && \
    # Purge temporary resources
    rm /tmp/${REVEALJS_VERSION}.tar.gz && \
    # Install mandatory dependencies
    cd /socket.io && \
    npm install express \
                socket.io --save && \

#RUN \
    # Remove old apk
    apk del python \
            sqlite-libs \
            readline \
            ncurses-libs \
            ncurses-terminfo \
            ncurses-terminfo-base \
            gdbm \
            libffi \
            expat \
            libbz2 \
            make \
            g++ \
            libc-dev \
            musl-dev \
            gcc \
            mpc1 \
            mpfr3 \
            pkgconfig \
            pkgconf \
            libatomic \
            libgomp \
            isl \
            gmp \
            binutils \
            binutils-libs 

WORKDIR /socket.io

EXPOSE 8080

CMD ["node", "index.js"]