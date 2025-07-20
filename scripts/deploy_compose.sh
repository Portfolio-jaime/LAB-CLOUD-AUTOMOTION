mkdir -p ~/deploy
cat > ~/deploy/docker-compose.yml <<EOF
version: "3"
services:
  go-api:
    image: <TU-REGISTRY>/go-api:latest
    ports:
      - "8080:8080"
    restart: always

  py-worker:
    image: <TU-REGISTRY>/py-worker:latest
    restart: always
EOF
