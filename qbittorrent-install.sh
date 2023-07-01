cd && mkdir -p ~/dockers/qbittorrent/ && echo '---
version: "2.1"
services:
  qbittorrent:
    image: lscr.io/linuxserver/qbittorrent:latest
    container_name: qbittorrent
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Etc/UTC
      - WEBUI_PORT=8080
    volumes:
      - ./config:/config
      - /media/nas4tb/Downloads:/downloads
    ports:
      - 8080:8080
      - 6881:6881
      - 6881:6881/udp
    restart: unless-stopped' >> ~/dockers/qbittorrent/docker-compose.yml && cd ~/dockers/qbittorrent && docker pull lscr.io/linuxserver/qbittorrent:latest && docker compose up -d