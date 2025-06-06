FROM golang:1.24-alpine AS build

WORKDIR /go/src/github.com/amadigan/openvpn-aws
COPY . /go/src/github.com/amadigan/openvpn-aws/
RUN go install ./...
RUN du -h /go/bin/openvpn-aws





FROM alpine:3.22

RUN apk add --no-cache openvpn

WORKDIR /vpn
ADD configs/openvpn.conf /vpn/
COPY --from=build /go/bin/openvpn-aws /vpn/

EXPOSE 1194/udp
ENTRYPOINT ["/vpn/openvpn-aws"]
