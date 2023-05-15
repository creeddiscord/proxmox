cd ~ && mkdir -p ~/dockers/homepage/ && echo '---
version: "3.3"

volumes:
  4tb:
    driver_opts:
      type: cifs
      o: "file_mode=0777,dir_mode=0777,iocharset=utf8,vers=3.1.1,rw,uid=1000,gid=1000,sec=ntlmssp"
      device: //192.168.0.110/Public/

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
