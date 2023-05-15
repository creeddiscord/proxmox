cd ~ && mkdir -p ~/dockers/homepage/ && echo '---
version: "3.3"

volumes:
  4tb:
    driver_opts:
      type: cifs
      o: "uid=0,iocharset=utf8,noperm 0"
      device: "//192.168.0.110/Public"

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
