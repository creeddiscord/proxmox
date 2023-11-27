cd && mkdir -p ~/dockers/qbittorrent/ && echo '---
version: "2.1"

services:
  qbittorrent:
    image: lscr.io/linuxserver/qbittorrent:latest
    container_name: qbittorrent
    environment:
      - PUID=0
      - PGID=0
      - TZ=Etc/UTC
      - WEBUI_PORT=8090
    volumes:
      - ./config:/config
      - /media/Downloads:/media/Downloads
    ports:
      - 8090:8090
      - 6881:6881
      - 6881:6881/udp
    restart: unless-stopped' >> ~/dockers/qbittorrent/docker-compose.yml && cd ~/dockers/qbittorrent && docker pull lscr.io/linuxserver/qbittorrent:latest && docker compose up -d
