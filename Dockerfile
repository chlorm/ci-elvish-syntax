FROM golang:latest AS builder

RUN go get -d -v github.com/elves/elvish@latest
RUN go install -v github.com/elves/elvish@latest

FROM opensuse/leap:latest AS runner

COPY --from=builder /go/bin/elvish /usr/local/bin/elvish
COPY entrypoint.bash /entrypoint.bash

ENTRYPOINT [ "bash", "/entrypoint.bash" ]
