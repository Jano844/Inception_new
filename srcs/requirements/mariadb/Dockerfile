
# Test container
#docker build -t "Image_name" .
#docker run -it "Image_name"



FROM debian:bullseye

RUN mkdir -p /run/mysqld && chmod 777 /run/mysqld \
	&& mkdir -p /var/lib/mysql && chmod 777 /var/lib/mysql

RUN apt-get update && apt-get upgrade -y \
	&& apt-get install mariadb-server -y

RUN chown mysql:mysql /var/lib/mysql

COPY ../conf/my.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ../tools/script.sh /
RUN chmod +x /script.sh

EXPOSE 3306

CMD ["/script.sh"]