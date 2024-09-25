# Use debain Bullseye, and Install nginx and (openssl, dont use it yet) 
FROM debian:bullseye
RUN apt-get update && apt-get upgrade -y && apt-get install -y nginx openssl


# Copy the Nginx configuration file from the host to the container
COPY ./conf/default.conf /etc/nginx/nginx.conf
COPY ./conf/ssl/jsanger.42.fr.crt /etc/nginx/ssl/jsanger.42.fr.crt
COPY ./conf/ssl/jsanger.42.fr.key /etc/nginx/ssl/jsanger.42.fr.key

# Expose port 443 to allow HTTPS traffic
EXPOSE 443

# copy and start the nginx script 
COPY ./tools/script.sh /script.sh
RUN chmod +x /script.sh
CMD ["/script.sh"]


