FROM node:18-bullseye

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

RUN npm install -g n8n

EXPOSE 5678

CMD ["n8n"]
