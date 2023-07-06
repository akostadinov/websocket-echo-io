FROM ruby:3.2-alpine as base

RUN apk add alpine-sdk

########################################
FROM base as build

ADD . .

RUN gem build websocket-echo-io.gemspec


########################################
FROM base

COPY bin/container-entrypoint.sh /usr/local/bin
COPY --from=build websocket-echo-io-*.gem /tmp/websocket-echo-io.gem
RUN apk add jemalloc && \
    gem install /tmp/websocket-echo-io.gem && \
    rm /tmp/websocket-echo-io.gem
ENTRYPOINT ["/bin/sh", "/usr/local/bin/container-entrypoint.sh"]
USER 65534
EXPOSE 3003
