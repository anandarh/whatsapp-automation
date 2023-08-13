# WhatsApp Automation

## Introduction

This project is a Node.js-based automation for WhatsApp utilizing the whatsapp-web.js library. 

To ensure platform independence and seamless deployment, the project has been dockerized.

## Pre-requisites

- Ensure you have Docker and Docker Compose installed on your machine.
- Node.js (If you plan to run the project outside Docker)

## Getting Started

### Via Docker
1. Clone the repository:
```bash
git clone https://github.com/anandarh/whatsapp-automation.git whatsapp_automation
cd whatsapp_automation
```

2. Build and run the Docker container with Docker Compose:
```bash
docker-compose up --build
```

Upon successful start, the QR code for WhatsApp web authentication will be displayed in the terminal. Scan the QR code with your WhatsApp mobile app to authenticate.

---

### Without Docker
1. Clone the repository:
```bash
git clone https://github.com/anandarh/whatsapp-automation.git whatsapp_automation
cd whatsapp_automation
```

2. Install the dependencies:
```bash
npm install
```

3. Start the application:
```bash
npm start
```

## Key Files & Directories

1. **`server.js`**: The core file of the application containing all the logic and event listeners for the WhatsApp automation.
2. **`Dockerfile`**: Contains all the instructions to dockerize the Node.js application ensuring it runs seamlessly across any platform.
3. **`docker-compose.yml`**: Simplifies the Docker commands for building and running the container. It also manages volumes for persisting node modules.
4. **`package.json`**: Lists the project details and its dependencies.


## Author

👤 Ananda R Herdianto

