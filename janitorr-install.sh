cd ~ && mkdir -p ~/dockers/janitorr/ && echo '---
version: 3

services:
  janitorr:
    container_name: janitorr
    image: schaka/janitorr:develop
    ports:
      - 8978:8978
    volumes:
      - /appdata/janitorr/config:/config 
      - /share_media:/data
    restart: unless-stopped' > ~/dockers/janitorr/docker-compose.yml && cd ~/dockers/janitorr && docker compose up -d
