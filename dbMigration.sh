#!/bin/sh

# Script to run npm install and execute index.js
echo "Starting npm installation..."

# Run npm install
npm install

echo "npm installation completed."
echo "Starting node application..."

# Execute the Node.js script
node index.js

echo "DB Migration completed."
