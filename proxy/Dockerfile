# syntax=docker/dockerfile:1
FROM nginx:1.22

# Add static repo
ADD https://github.com/reallyreadit/static.git /static
# Add web repo
ADD https://github.com/reallyreadit/web.git /web

# Copy nginx configuration
COPY ./nginx.conf /etc/nginx/nginx.conf

EXPOSE 80