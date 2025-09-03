FROM golang:1.25.0 AS builder 
WORKDIR /app 
COPY go.mod go.sum ./ 
RUN go mod download
COPY ./app ./ 
RUN CGO_ENABLED=0 go build -o server .


FROM alpine:3.21.3
WORKDIR /app 
COPY --from=builder /app/server ./ 
EXPOSE 7000 
CMD ["./server"]

