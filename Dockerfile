FROM golang as builder
WORKDIR /go/src/github.com/dmage/git-build-watcher
ADD . .
RUN CGO_ENABLED=0 go install .

FROM alpine
RUN apk update && apk add ca-certificates && update-ca-certificates && rm -rf /var/cache/apk/*
COPY --from=builder /go/bin/git-build-watcher /usr/bin/git-build-watcher
USER 1000
CMD ["/usr/bin/git-build-watcher"]
