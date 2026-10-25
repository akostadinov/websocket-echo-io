FROM ruby:3.2-alpine3.20 as base

RUN apk add alpine-sdk

########################################
FROM base as build

ADD . .

RUN bundle config set --local frozen true && \
    bundle config set --local without "development:test" && \
    bundle install && \
    gem build websocket-echo-io.gemspec && \
    gem install --local websocket-echo-io-*.gem && \
    rm -rf websocket-echo-io-*.gem /usr/local/bundle/cache /usr/local/bundle/config


########################################
FROM base

COPY bin/container-entrypoint.sh /usr/local/bin
COPY --from=build /usr/local/bundle /usr/local/bundle
RUN apk add jemalloc openssl-dev
ENTRYPOINT ["/bin/sh", "/usr/local/bin/container-entrypoint.sh"]
USER 65534
EXPOSE 3003
