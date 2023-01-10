FROM golang:1.19.4-alpine AS builder

RUN apk update && apk add --no-cache

WORKDIR /src

COPY index.go .

RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-w -s" -a -installsuffix cgo -o index index.go

FROM scratch AS production

WORKDIR /app

COPY --from=builder /src/index .

CMD [ "./index" ]