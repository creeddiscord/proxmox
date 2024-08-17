cd ~ && mkdir -p ~/dockers/chromium/ && echo '---
services:
  chromium:
    image: kasmweb/chromium:develop	
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
      - 3000:3000
      - 3001:3001
    shm_size: "1gb"
    restart: unless-stopped' > ~/dockers/chromium/docker-compose.yml && cd ~/dockers/chromium && docker compose up -d
