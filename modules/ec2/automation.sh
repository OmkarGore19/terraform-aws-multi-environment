#!/bin/bash

# Update package lists
sudo apt update -y

# Install Nginx
sudo apt-get install nginx -y

# Check Nginx service status
sudo systemctl status nginx

# Start Nginx
sudo systemctl start nginx

# Create a custom web page
echo "Hello from terraform server" | sudo tee /var/www/html/index.html