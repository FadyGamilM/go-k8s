FROM golang:1.21 as build_gok8s
ENV CGO_ENABLED 0
ARG BUILD_REF

WORKDIR /app

COPY go.mod /app

COPY main.go /app

RUN go build -ldflags "-X main.build=${BUILD_REF}"

FROM alpine:3.18

ARG BUILD_DATE
ARG BUILD_REF

WORKDIR /app

COPY --from=build_gok8s /app /app

CMD [ "./gok8s" ]

LABEL org.opencontainers.image.created="${BUILD_DATE}" \
    org.opencontainers.image.title="gok8s" \
    org.opencontainers.image.authors="fady gamil <gamilfady605@gmail.com>" \ 
org.opencontainers.image.revision="${BUILD_REF}" \ 
org.opencontainers.image.vendor="FG"
