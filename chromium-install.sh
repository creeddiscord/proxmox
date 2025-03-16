cd ~ && mkdir -p ~/dockers/chromium/ && echo '---
services:
  chromium:
    image: linuxserver/chromium:latest
    container_name: chromium
    security_opt:
      - seccomp:unconfined #optional
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/London
      - CHROME_CLI=https://www.google.com/ #optional
    volumes:
      - ./config:/config
    ports:
      - 6901:6901
      - 3001:3001
    shm_size: "1gb"
    restart: unless-stopped' > ~/dockers/chromium/docker-compose.yml && cd ~/dockers/chromium && docker compose up -d
