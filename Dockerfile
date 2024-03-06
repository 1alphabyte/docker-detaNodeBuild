FROM golang:latest AS build

WORKDIR /fakeroot
RUN git clone https://github.com/deta/space-cli.git --depth=1 . && \
  go build .

FROM node:latest

COPY --from=build /fakeroot/space /root/.detaspace/bin/space

RUN corepack enable && corepack prepare pnpm@latest-8 --activate