# Шаг 1: Берем чистый Alpine, чтобы "одолжить" менеджер пакетов apk
FROM alpine:latest AS alpine

# Шаг 2: Берем официальный образ n8n
FROM n8nio/n8n:latest

# Шаг 3: Переносим утилиту apk и ее системные зависимости из первого образа во второй
COPY --from=alpine /sbin/apk /sbin/apk
COPY --from=alpine /lib/libapk.so* /lib/
COPY --from=alpine /usr/lib/libapk.so* /usr/lib/

# Шаг 4: Временно включаем права суперпользователя
USER root

# Шаг 5: Инициализируем apk и устанавливаем curl, ffmpeg и шрифты
RUN apk update && \
    apk add --no-cache curl ffmpeg ttf-dejavu

# Шаг 6: Возвращаем права обратно обычному пользователю (требование безопасности)
USER node
