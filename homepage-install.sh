cd ~ && mkdir -p ~/dockers/homepage/ && echo '---
version: "3.3"

volumes:
  4tb:
    driver: local
    driver_opts:
      type: cifs
      device: "/media/wdnas4tb"

services:
  homepage:
    image: ghcr.io/benphelps/homepage:latest
    container_name: homepage
    volumes:
      - ./config:/config
      - 4tb:/media/wdnas4tb
    ports:
      - 3000:3000
    restart: unless-stopped' > ~/dockers/homepage/docker-compose.yml && cd ~/dockers/homepage && docker pull ghcr.io/benphelps/homepage:latest && docker compose up -d
