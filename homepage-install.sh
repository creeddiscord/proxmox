cd ~ && mkdir -p ~/dockers/homepage/ && echo '---
version: "3.3"
services:
  homepage:
    image: ghcr.io/benphelps/homepage:latest
    container_name: homepage
    volumes:
      - ./config:/config
      - ./media:/wdnas4tb
      - ./media:/wdnas6tb
    ports:
      - 3000:3000
    restart: unless-stopped' >> ~/dockers/homepage/docker-compose.yml && cd ~/dockers/homepage && docker pull ghcr.io/benphelps/homepage:latest && docker compose up -d
