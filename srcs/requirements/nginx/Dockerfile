# Use the Alpine Linux base image version 3.18
FROM alpine:3.18

RUN apk update && apk upgrade && apk add --no-cache nginx openssl

# Copy the Nginx configuration file from the host to the container
COPY ./conf/default.conf /etc/nginx/nginx.conf
COPY ./conf/ssl/jsanger.42.fr.crt /etc/nginx/ssl/jsanger.42.fr.crt
COPY ./conf/ssl/jsanger.42.fr.key /etc/nginx/ssl/jsanger.42.fr.key

# Expose port 443 to allow HTTPS traffic
EXPOSE 443

# default command -> to run nginx forrderground
CMD ["nginx", "-g", "daemon off;"]

