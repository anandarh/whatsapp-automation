# Use the slim variant of the Node.js 16 image based 
# on the Debian Bullseye as the base image
# To support docker running on apple silicon chips
FROM node:16-bullseye-slim

# Prevent Puppeteer from downloading a bundled version of Chromium
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true

# Specify the path to the Chromium executable that Puppeteer should use
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# Set the path to the Chromium executable for other applications 
# or libraries that might need it
ENV CHROME_PATH=/usr/bin/chromium

# Ensure that Debian-based image installations won't prompt for user input 
# (useful for automating installs)
ENV DEBIAN_FRONTEND=noninteractive

# Start with updating the package repositories
RUN apt update -qq

# Install required packages quietly without recommended packages
RUN apt install -qq -y --no-install-recommends \
    chromium \
    fonts-roboto fonts-croscore \
    # Clean up cached files to reduce image size
    && rm -rf /var/lib/apt/lists/* \
    # Delete any Debian package files from /src
    && rm -rf /src/*.deb

# Set /app as the working directory
WORKDIR /app

# Only copy NPM files, rather than copying the entire working directory
# This allows us to take advantage of cached Docker layers
COPY ["package.json", "package-lock.json*", "npm-shrinkwrap.json*", "./"]

# Install the dependencies
RUN npm install

# Copy all files to the current working directory
COPY . .

# Relocating the node_modules directory into a data directory 
RUN mkdir -p data && mv node_modules data/ && ln -s data/node_modules node_modules

# Default command to run the application when the container starts
CMD ["npm", "start"]

