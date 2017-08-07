FROM alpine:3.6 as builder
ENV SRC_DIR /usr/local/src/ethudp
RUN apk add --no-cache build-base openssl-dev lz4-dev linux-headers
RUN echo $SRC_DIR
ADD . $SRC_DIR
RUN make -C $SRC_DIR

FROM alpine:3.6
RUN apk add --no-cache lz4-libs openssl
COPY --from=builder /usr/local/src/ethudp/EthUDP /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/EthUDP"]
