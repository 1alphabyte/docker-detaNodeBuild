FROM golang:latest AS build

WORKDIR /fakeroot
RUN git clone https://github.com/deta/space-cli.git --depth=1 . && \
  go build .

FROM node:latest

COPY --from=build /fakeroot/space /root/.detaspace/bin/space

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y sudo && \
  corepack enable && \
  corepack prepare pnpm@latest-8 --activate

LABEL "com.azure.dev.pipelines.agent.handler.node.path"="/usr/local/bin/node"