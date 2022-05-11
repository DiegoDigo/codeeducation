FROM golang:1.12-alpine AS build_base

RUN apk add --no-cache git

WORKDIR /app/go-fullcycle

COPY go.mod .

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 go test -v

RUN go build -o ./out/go-fullcycle-app .


FROM scratch

COPY --from=build_base /app/go-fullcycle/out/go-fullcycle-app /app/go-fullcycle-app 

ENTRYPOINT ["/app/go-fullcycle-app"]

