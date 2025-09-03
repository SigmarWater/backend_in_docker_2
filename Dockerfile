FROM golang:1.25.0 AS buidler 
WORKDIR /app 
COPY go.mod go.sum ./ 
RUN go mod download
COPY ./app ./ 
RUN CGO_ENABLE=0 GOOS=linux GOARCH=amd64 go build -o server .


FROM alpine:3.21.3
WORKDIR /app 
COPY --from=buidler ./app/server ./ 
EXPOSE 7000 
CMD ["./server"]

