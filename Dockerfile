FROM golang:1.17-alpine AS build

WORKDIR /go/src/voting

COPY . .

RUN go mod download

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -installsuffix cgo -o voting .

FROM alpine:latest

WORKDIR /opt/voting

COPY --from=build /go/src/voting .

EXPOSE 3000

CMD ["./voting"]