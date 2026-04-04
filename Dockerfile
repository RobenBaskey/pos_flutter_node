# Dockerfile
FROM nginx:alpine

# Remove default nginx config
RUN rm /etc/nginx/conf.d/default.conf

# Copy custom nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy Flutter web build
COPY build/web /usr/share/nginx/html

# Expose port 3001
EXPOSE 3001

CMD ["nginx", "-g", "daemon off;"]