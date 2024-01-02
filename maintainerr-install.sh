cd ~ && mkdir -p ~/dockers/maintainerr/ && echo '---
version: "3"

services:
  maintainerr:
    image: jorenn92/maintainerr:latest
    container_name: maintainerr
    volumes:
      - ./data:/opt/data
    environment:
      - TZ=Europe/London
    ports:
      - 8154:80
    restart: unless-stopped' > ~/dockers/maintainerr/docker-compose.yml && cd ~/dockers/maintainerr && docker compose up -d
