# Stage 1: Build (optional if already built locally)
FROM ghcr.io/cirruslabs/flutter:latest AS build
WORKDIR /app
COPY . .
RUN flutter build web

# Stage 2: Serve with Nginx
FROM nginx:alpine
COPY --from=build /app/build/web /usr/share/nginx/html

# Optional: custom nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 3001
CMD ["nginx", "-g", "daemon off;"]