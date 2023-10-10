cd ~ && mkdir -p ~/dockers/kasm/ && echo '---
version: "2.1"
services:
  kasm:
    image: lscr.io/linuxserver/kasm:latest
    container_name: kasm
    privileged: true
    environment:
      - KASM_PORT=443
    volumes:
      - /opt:/opt
    ports:
      - 3000:3000
      - 443:443
    restart: unless-stopped' > ~/dockers/kasm/docker-compose.yml && cd ~/dockers/kasm && docker compose up -d
