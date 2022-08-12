FROM golang:1.19.0-alpine AS build-binary

RUN apk add --no-cache git=2.36.2-r0 make=4.3-r0
RUN git clone https://github.com/percona/mongodb_exporter.git

WORKDIR /go/mongodb_exporter
RUN make build


FROM alpine:3.11.5

EXPOSE 9216

COPY --from=build-binary /go/mongodb_exporter/mongodb_exporter /bin/mongodb_exporter

ENV MONGODB_URI=mongodb://db:27017

ENTRYPOINT ["/bin/mongodb_exporter"]
