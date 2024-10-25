# Use the official WordPress image as the base
FROM wordpress:latest

# Install MySQL server
RUN apt-get update && apt-get install -y default-mysql-server

# Configure MySQL
RUN service mysql start && \
    mysql -e "CREATE DATABASE wordpress;" && \
    mysql -e "CREATE USER 'user'@'localhost' IDENTIFIED BY 'password';" && \
    mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'user'@'localhost';" && \
    mysql -e "FLUSH PRIVILEGES;"

# Set environment variables for WordPress
ENV WORDPRESS_DB_HOST=localhost:3306
ENV WORDPRESS_DB_USER=user
ENV WORDPRESS_DB_PASSWORD=password
ENV WORDPRESS_DB_NAME=wordpress

# Start MySQL and Apache on container start
CMD service mysql start && apache2-foreground
