cd ~ && docker stop watchtower && docker rm watchtower && docker image prune --all -y && mkdir -p ~/dockers/watchtower/ && echo '---
version: "3"

services:
  watchtower:
    container_name: watchtower
    restart: always
    environment:
      WATCHTOWER_SCHEDULE: 0 0 * * * *
      TZ: Europe/London
      WATCHTOWER_CLEANUP: "true"
      WATCHTOWER_DEBUG: "true"
    image: containrrr/watchtower:latest
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock' > ~/dockers/watchtower/docker-compose.yml && cd ~/dockers/watchtower && docker compose up -d
