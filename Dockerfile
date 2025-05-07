FROM node:20-alpine AS jsbuilder
RUN corepack enable && corepack prepare pnpm@latest --activate
COPY package.json .
COPY pnpm-lock.yaml .
COPY entry.tsx .
RUN pnpm i
RUN npx esbuild entry.tsx \
   --bundle \
   --minify \
   --format=esm \
   --target=es2022 \
   --outfile=bundle.js

FROM golang:1.23-alpine AS builder
WORKDIR /app
COPY . .
COPY --from=jsbuilder bundle.js ./src/static/bundle.js
RUN cd src && go build -o ../graphpg ./...

FROM alpine:3.21

ENV HOST=http://localhost:9000/graphql
ENV TITLE="GraphQL Playground"
ENV PORT=8080
ENV THEME=dark

WORKDIR /app
COPY --from=builder /app/graphpg .
EXPOSE 8080
ENTRYPOINT  ["./graphpg"]