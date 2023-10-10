cd ~ && mkdir -p ~/dockers/mealie/ && echo '---
version: "3.7"
services:
  mealie:
    image: ghcr.io/mealie-recipes/mealie:nightly
    container_name: mealie
    ports:
        - "9925:9000" # 
    deploy:
      resources:
        limits:
          memory: 1000M # 
    volumes:
      - mealie-data:/app/data/
    environment:
    # Set Backend ENV Variables Here
      - ALLOW_SIGNUP=true
      - PUID=1000
      - PGID=1000
      - TZ=Europe/London
      - MAX_WORKERS=1
      - WEB_CONCURRENCY=1
      - BASE_URL=https://meals.stroudy.tv
    restart: always

volumes:
  mealie-data:
    driver: local' > ~/dockers/mealie/docker-compose.yml && cd ~/dockers/mealie && docker compose up -d
