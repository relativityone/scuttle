FROM golang:1.23.1-alpine AS dev 

FROM dev AS build
ARG VERSION="local"
COPY . /app
WORKDIR /app
RUN go get -d
RUN go test -test.timeout 30s 
RUN CGO_ENABLED=0 go build -o scuttle -ldflags="-X 'main.Version=${VERSION}'"

FROM scratch
COPY --from=build /app/scuttle /scuttle
