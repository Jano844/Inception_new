# Developer Documentation

## Environment Configuration

### Prerequisites
- Docker and Docker Compose installed
- Make utility
- Git

### Setup from Scratch

1. **Clone the repository:**
   ```bash
   git clone <repo_url>
   cd Inception_new
   ```

2. **Create .env file:**
   ```bash
   cd srcs
   cp .env_example .env
   ```

3. **Edit .env with your values:**


4. **Ensure SSL certificates exist:**
   - Located at: `srcs/requirements/nginx/conf/ssl/`

---

## Building and Launching

### Using Makefile (from project root)

```bash
make build      # Build all services
make up         # Start all containers
make down       # Stop containers
make logs       # View logs
make ps         # Check status
make clean      # Full cleanup (removes volumes)
make re         # Clean + build + up
```

### Manual Docker Compose (from srcs/ directory)

```bash
docker-compose build
docker-compose up -d
docker-compose down
docker-compose logs -f
```

---

## Container and Volume Management

### Access Running Containers

```bash
docker exec -it <container_name> /bin/bash

# Examples:
docker exec -it wordpress /bin/bash
docker exec -it mariadb /bin/bash
```

### Data Storage Locations

- **WordPress files:** `$HOME/data/wordpress` (container: `/var/www/html`)
- **MariaDB data:** `$HOME/data/mariadb` (container: `/var/lib/mysql`)

### Database Backup/Restore

The MariaDB container writes its data to /var/lib/mysql inside the container. But because of the volume mapping:
/home/<user>/data/mariadb  ←──→  /var/lib/mysql (inside container)
Whatever MariaDB writes to /var/lib/mysql actually lands on your VM host at /home/<user>/data/mariadb. The container just thinks it's writing locally.

---

## Modifying Services

After changing a Dockerfile or source files:

```bash
docker-compose build <service_name>
docker-compose restart <service_name>
```
