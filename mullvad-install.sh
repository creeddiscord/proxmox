cd ~ && mkdir -p ~/dockers/mullvad/ && echo '---
services:
  mullvad-browser:
    image: lscr.io/linuxserver/mullvad-browser:latest
    container_name: mullvad-browser
    cap_add:
      - NET_ADMIN
    security_opt:
      - seccomp:unconfined #optional
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Etc/UTC
      - LOCAL_NET=192.168.0.0/24 #optional
    volumes:
      - ./config:/config
    ports:
      - 3000:3000
      - 3001:3001
    shm_size: "1gb"
    restart: always' > ~/dockers/mullvad/docker-compose.yml && cd ~/dockers/mullvad && docker compose up -d
