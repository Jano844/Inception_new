FROM debian:bullseye

RUN apt-get update && apt-get install -y redis && rm -rf /var/lib/apt/lists/*

EXPOSE 6379

CMD ["redis-server", "--protected-mode", "no"]