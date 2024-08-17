cd ~ && mkdir -p ~/dockers/portainer_agent/ && echo '---
version: "3.2"

services:
  portainer_agent:
    container_name: portainer_agent
    image: portainer/agent:sts
    restart: always
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - /var/lib/docker/volumes:/var/lib/docker/volumes
    ports:
      - "9001:9001"' > ~/dockers/portainer_agent/docker-compose.yml && cd ~/dockers/portainer_agent && docker compose up -d
