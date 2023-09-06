# Use the Alpine Linux variant of the Node.js 16 image
FROM node:current-alpine3.18

# Prevent Puppeteer from downloading a bundled version of Chromium
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true

# Specify the path to the Chromium executable that Puppeteer should use
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

# Set the path to the Chromium executable for other applications 
# or libraries that might need it
ENV CHROME_PATH=/usr/bin/chromium-browser

# Start with updating the package repositories and installing necessary packages
RUN apk update && \
    apk upgrade && \
    apk add --no-cache chromium udev ttf-freefont && \
    rm -rf /var/cache/apk/* && \
    mkdir -p data

# Set /app as the working directory
WORKDIR /app

# Copy package files and install dependencies
COPY ["package.json", "package-lock.json*", "npm-shrinkwrap.json*", "./"]
RUN npm install --production && \
    npm cache clean --force && \
    mv node_modules data/ && \
    ln -s data/node_modules node_modules && \
    rm -rf package.json package-lock.json npm-shrinkwrap.json

# Copy the rest of the application files
COPY . .

# Default command to run the application when the container starts
CMD ["npm", "start"]
