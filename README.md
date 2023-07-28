# WordPress on OpenLiteSpeed and nginx

[![PHP 8.2](https://github.com/ComputeStacks/cs-docker-wordpress/actions/workflows/php8-2.yml/badge.svg)](https://github.com/ComputeStacks/cs-docker-wordpress/actions/workflows/php8-2.yml)

[![PHP 8.1](https://github.com/ComputeStacks/cs-docker-wordpress/actions/workflows/php8-1.yml/badge.svg)](https://github.com/ComputeStacks/cs-docker-wordpress/actions/workflows/php8-1.yml)

[![PHP 8.0](https://github.com/ComputeStacks/cs-docker-wordpress/actions/workflows/php8-0.yml/badge.svg)](https://github.com/ComputeStacks/cs-docker-wordpress/actions/workflows/php8-0.yml)

[![PHP 7.4](https://github.com/ComputeStacks/cs-docker-wordpress/actions/workflows/php7-4.yml/badge.svg)](https://github.com/ComputeStacks/cs-docker-wordpress/actions/workflows/php7-4.yml)

[![PHP 7.3](https://github.com/ComputeStacks/cs-docker-wordpress/actions/workflows/php7-3.yml/badge.svg)](https://github.com/ComputeStacks/cs-docker-wordpress/actions/workflows/php7-3.yml)


## Submitting Issues

If you encounter a technical issue, you may [open an issue](https://github.com/ComputeStacks/cs-docker-wordpress/issues). However, for questions or how-to's, please [post on our forum](https://forum.computestacks.com).


## Contributing

Contributions are welcome! Before you submit a pull request, feel free to [post on our forum](https://forum.computestacks.com) your idea and we can have a discussion.

## Local testing
To test the image locally, you require a database container. You can use the following commands to get a environment running quickly.

First, generate some random passwords and set some variables;

```bash
export MYSQL_ROOT_PASSWORD=$(openssl rand -base64 32)
export MYSQL_PASSWORD=$(openssl rand -base64 32)
export MYSQL_USER=wordpress_user
export MYSQL_DATABASE=wordpress
```

Create a bridge network to make sure the containers can communicate:

```bash
docker network create wordpress-dev-network
```

Then, start the database container:

```bash
docker run -d \
  --name wordpress-db \
  --network wordpress-dev-network \
  -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD \
  -e MYSQL_DATABASE=wordpress \
  -e MYSQL_USER=wordpress_user \
  -e MYSQL_PASSWORD=$MYSQL_PASSWORD \
  --hostname wordpress-db \
  --rm mariadb:latest
```

Then, you can start the WordPress container:

```bash
docker run -d --rm \
  --name wordpress-dev \
  --network wordpress-dev-network \
  -p 80:80 \
  -e WORDPRESS_DB_HOST=wordpress-db \
  -e WORDPRESS_DB_USER=root \
  -e WORDPRESS_DB_PASSWORD=$MYSQL_ROOT_PASSWORD \
  -e WORDPRESS_DB_NAME=wordpress \
  -e WORDPRESS_EMAIL=admin@nowhere.local \
  php8.2-nginx
```