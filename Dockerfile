# Dockerfile for Flutter Web + Nginx (port 3001)

# Use lightweight Nginx image
FROM nginx:alpine

# Set working directory inside container
WORKDIR /usr/share/nginx/html

# Copy your locally built Flutter web files
COPY build/web/ .

# Copy custom nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose the port you want
EXPOSE 3001

# Run Nginx in foreground
CMD ["nginx", "-g", "daemon off;"]