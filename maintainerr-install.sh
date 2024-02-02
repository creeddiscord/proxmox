cd ~ && mkdir -p ~/dockers/maintainerr/ && echo '---
version: "3"

services:
  maintainerr:
    image: ghcr.io/jorenn92/maintainerr:latest
    container_name: maintainerr
    user: 1000:1000
    volumes:
      - ./data:/opt/data
    environment:
      - TZ=Europe/London
    ports:
      - 6246:6246
    restart: unless-stopped' > ~/dockers/maintainerr/docker-compose.yml && cd ~/dockers/maintainerr && docker compose up -d
