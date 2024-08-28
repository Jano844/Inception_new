# Use the Alpine Linux base image version 3.18
FROM alpine:3.18

# Update the package list, upgrade installed packages, and install nginx and openssl without caching the package index
RUN apk update && apk upgrade && apk add --no-cache nginx openssl

# Copy the Nginx configuration file from the host to the container
COPY ./conf/default.conf /etc/nginx/nginx.conf

# Copy the SSL certificate and key from the host to the container
COPY ./conf/ssl/jsanger.42.fr.crt /etc/nginx/ssl/jsanger.42.fr.crt
COPY ./conf/ssl/jsanger.42.fr.key /etc/nginx/ssl/jsanger.42.fr.key

# Expose port 443 to allow HTTPS traffic
EXPOSE 443

# Set the default command to run nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]

