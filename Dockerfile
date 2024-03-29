FROM golang:1.21.6-bookworm

WORKDIR /go/src/app
COPY ./go.mod ./go.mod
COPY ./go.sum ./go.sum
RUN go get -d -v ./...
COPY ./main.go ./main.go
COPY ./server ./server

RUN GOOS=`uname| tr '[:upper:]' '[:lower:]'` GOARCH=amd64 go build -ldflags "-s -w" -o speech-to-text

FROM debian:bookworm-20240130

WORKDIR /go/src/app

COPY --from=0 /go/src/app/speech-to-text /
RUN useradd -ms /bin/bash www && \
    chown -R www:www /go/src/app && \
    chmod 550 /speech-to-text

USER www

CMD ["/speech-to-text"]
