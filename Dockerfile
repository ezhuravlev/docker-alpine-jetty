FROM frolvlad/alpine-oraclejdk8:cleaned

ENV JETTY_VERSION 9.3.7.v20160115
ENV JETTY_HOME /usr/local/jetty
ENV JETTY_RUN /run/jetty
ENV JETTY_STATE $JETTY_RUN/jetty.state
ENV JETTY_BASE /var/lib/jetty
ENV TMPDIR /tmp/jetty

ENV JETTY_TGZ_URL https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-distribution/$JETTY_VERSION/jetty-distribution-$JETTY_VERSION.tar.gz

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
# RUN useradd -U -s /bin/false
RUN addgroup jetty && adduser -s /bin/bash -D -G jetty jetty

RUN apk --no-cache --update add --virtual build-dependencies ca-certificates tar &&\
    mkdir ${JETTY_HOME} && \
    wget -q -O - "${JETTY_TGZ_URL}" | \
    tar xzv --strip-components 1 -C ${JETTY_HOME} && \
    rm -rf ${JETTY_HOME}/demo-base && \
    rm -rf ${JETTY_HOME}/javadoc && \
    mkdir -p "${JETTY_BASE}" "${JETTY_RUN}" "${TMPDIR}" && \
    chown -R jetty:jetty  "${JETTY_BASE}" "${JETTY_RUN}" "${TMPDIR}" && \
    ls -la /usr/local/jetty/ && \
    apk del build-dependencies

EXPOSE 8080

COPY ./docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

#CMD ["--help"]
