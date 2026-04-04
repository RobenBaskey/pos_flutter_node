# Dockerfile
FROM nginx:alpine

# Remove default Nginx config
RUN rm /etc/nginx/conf.d/default.conf

# Copy custom nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy Flutter web build
COPY build/web /usr/share/nginx/html

# Expose container port
EXPOSE 8081

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]