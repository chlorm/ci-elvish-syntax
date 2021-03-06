FROM golang:latest AS builder

RUN go get -d -v github.com/elves/elvish
RUN go install -v github.com/elves/elvish

FROM opensuse/leap:latest AS runner

COPY --from=builder /go/bin/elvish /usr/local/bin/elvish
COPY entrypoint.bash /entrypoint.bash

ENTRYPOINT [ "bash", "/entrypoint.bash" ]
