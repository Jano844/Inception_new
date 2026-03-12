*This project has been created as part of the 42 curriculum by jsanger*

## Description

This project, named Inception, aims to create a complete web infrastructure using Docker containers. It demonstrates the orchestration of multiple services to build a scalable and secure web application environment. The infrastructure includes:

- **WordPress**: Content management system for the main website
- **MariaDB**: Database server for data persistence
- **Redis**: In-memory data structure store for caching
- **Nginx**: Reverse proxy and load balancer for handling web traffic
- **FTP**: File transfer protocol server for file management
- **Adminer**: Web-based database administration tool
- **Backend**: Custom Python Flask application
- **Website**: Custom simple webapplication with js html and css

The goal is to containerize all components and manage them through Docker Compose, ensuring isolation, scalability, and ease of deployment.

- **Virtual Machines vs Docker**: instead of provisioning full operating systems as in VMs, Docker uses lightweight containers sharing the host kernel, which reduces overhead and speeds up deployment.
- **Secrets vs Environment Variables**: sensitive data (passwords, keys) are managed using Docker secrets where supported, rather than plain environment variables which can be exposed in process listings or image history.
NOT HERE I USED A .ENV FOR ALL PERSONAL DATA
- **Docker Network vs Host Network**: services default to isolated bridge networks for security, while the host network mode skips isolation and maps container ports directly to the host, useful for performance tests.
- **Docker Volumes vs Bind Mounts**: volumes are managed by Docker and suited for persistent data, whereas bind mounts link directories from the host filesystem, giving direct access to local files during development.

My volumes:
Inception uses Named Volumes with the local driver and explicit host paths (/home/<user>/data/). The o: bind is an internal Linux mount option of the driver — the volumes remain fully managed by Docker and are not classic Bind Mounts.


## Instructions

### Prerequisites
- Docker and Docker Compose installed on your system
- Make/Cmake for easy start

### Setup
1. Clone this repository to your local machine.
2. Navigate to the `srcs/` directory.
3. Copy the environment file template:
   ```bash
   cp .env_example .env
   ```
4. Edit the `.env` file and fill in the required values (database credentials, domain name, WordPress settings, etc.).

### Running the Project
Use the provided Makefile for easy management:

- **Build the services**: `make build`
- **Start all services**: `make up`
- **Stop all services**: `make down`
- **View logs**: `make logs`
- **Check service status**: `make ps`
- **Full Cleanup (remove all dockerrelated proccesses)** `make remove`

### Accessing the Services
- WordPress site: https://intralogin.42.fr:433 (SSL enabled)
- Adminer: https://intralogin.42.fr:433/adminer
- FTP: localhost:21 (use FTP client with credentials from .env)
- Backend API: https://intralogin.42.fr/api/"API endpoints (ping)"
- Custom Website: https://intralogin.42.fr/website

### Volumes
- WordPress files: `$HOME/data/wordpress`
- MariaDB data: `$HOME/data/mariadb`

## Architecture

The services are connected through a custom Docker network (`inception-net`) and communicate securely. Nginx acts as the reverse Proxy, routing traffic to appropriate services based on the domain and path.

## Resources

### Documentation and Tutorials
- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [WordPress Documentation](https://wordpress.org/support/)
- [MariaDB Documentation](https://mariadb.com/kb/en/documentation/)
- [Redis Documentation](https://redis.io/documentation)
- [Nginx Documentation](https://nginx.org/en/docs/)
- [Adminer Documentation](https://www.adminer.org/)
- [Flask Documentation](https://flask.palletsprojects.com/) (for backend)
- [Express.js Documentation](https://expressjs.com/) (for website)

### AI Usage
- AI as resource for explaining, writing html/css, error messages, documentation

## Additional Notes
- Ensure ports 443, 8080, 4242, 3306, 21, 21100-21110, 9000, and 5000 are available on your system.
- The project uses SSL certificates (self-signed for development).
- All services are configured to restart on failure for production-like behavior.