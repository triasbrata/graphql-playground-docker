FROM golang:1.23-alpine AS builder
WORKDIR /app
COPY . .
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