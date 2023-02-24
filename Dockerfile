FROM public.ecr.aws/docker/library/golang:1.19
RUN apt-get update && apt-get install -y jq
WORKDIR /app
COPY ./go-libp2p-relay-daemon ./
COPY ./init.sh ./
RUN go build -buildvcs=false -o /app/libp2p-relay-daemon ./cmd/libp2p-relay-daemon
EXPOSE 6060/tcp
EXPOSE 4001/tcp
EXPOSE 4001/udp
CMD bash /app/init.sh && /app/libp2p-relay-daemon -config /app/config.json -id /app/identity.key
