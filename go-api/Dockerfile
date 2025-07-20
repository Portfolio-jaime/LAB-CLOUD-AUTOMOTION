FROM golang:1.22 AS builder
WORKDIR /app
COPY . .
RUN go mod init myapp && go get github.com/gin-gonic/gin && go build -o server .

FROM gcr.io/distroless/base-debian11
COPY --from=builder /app/server /server
EXPOSE 8080
CMD ["/server"]
