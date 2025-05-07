FROM golang:1.23-alpine as builder
WORKDIR /app
COPY src .
RUN go build -o graphpg ./...

FROM alpine

ENV HOST http://localhost:9000/graphql
ENV TITLE "GraphQL Playground"
ENV PORT 8080
ENV THEME dark

WORKDIR /app
COPY --from=builder /app/graphpg .
EXPOSE 8080
ENTRYPOINT  ["./graphpg"]