FROM golang:latest AS builder

RUN go install -v src.elv.sh/cmd/elvish@latest

FROM opensuse/leap:latest AS runner

COPY --from=builder /go/bin/elvish /usr/local/bin/elvish
COPY entrypoint.bash /entrypoint.bash

ENTRYPOINT [ "bash", "/entrypoint.bash" ]
