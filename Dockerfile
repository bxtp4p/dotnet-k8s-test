FROM alpine:3.15

WORKDIR /opt/sfx

ADD https://github.com/signalfx/signalfx-dotnet-tracing/releases/download/v0.1.15/signalfx-dotnet-tracing-0.1.15-musl.tar.gz signalfx-dotnet-tracing-musl.tar.gz

RUN tar -xf signalfx-dotnet-tracing-musl.tar.gz -C .

CMD cp -r opt /