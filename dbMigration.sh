#!/bin/sh

# Script to install Node.js, npm, and run a Node application
echo "Installing Node.js and npm..."

# Update package lists
apk update

# Install Node.js and npm
apk add --no-cache nodejs npm

echo "Node.js and npm installed successfully."

# Verify installations
echo "Node.js version: $(node -v)"
echo "npm version: $(npm -v)"

echo "Installing npm dependencies..."
# Run npm install
npm install

echo "npm dependencies installed."
echo "Starting node application..."

# Execute the Node.js script
node index.js

echo "Node application execution completed."
