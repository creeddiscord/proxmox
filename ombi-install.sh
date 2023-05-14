cd && mkdir -p ~/dockers/ombi/ && echo '---
version: "2.1"
services:
  ombi:
    image: lscr.io/linuxserver/ombi:development
    container_name: ombi
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/London
      - BASE_URL=/ombi #optional
    volumes:
      - ./config:/config
    ports:
      - 3579:3579
    restart: unless-stopped' >> ~/dockers/ombi/docker-compose.yml && cd ~/dockers/ombi && docker pull lscr.io/linuxserver/ombi:development && docker compose up -d
