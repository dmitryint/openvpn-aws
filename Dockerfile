FROM golang:1.13-alpine AS build

WORKDIR /go/src/github.com/amadigan/openvpn-aws
COPY . /go/src/github.com/amadigan/openvpn-aws/
RUN go install -mod vendor ./...
RUN du -h /go/bin/openvpn-aws





FROM alpine:3.22

RUN apk add --no-cache openvpn iptables

WORKDIR /vpn
ADD configs/openvpn.conf /vpn/
COPY --from=build /go/bin/openvpn-aws /vpn/

EXPOSE 1194/udp
ENTRYPOINT ["/vpn/openvpn-aws"]
