const fs = require('fs');
const qrcode = require('qrcode-terminal');
const { Client} = require('whatsapp-web.js');

// Set up the WhatsApp client with specific Puppeteer options
const client = new Client({
    puppeteer: {
        headless: 'new',
        args: [
            "--no-sandbox",
            "--disable-setuid-sandbox",
            "--disable-gpu"
        ]
	}
});

// Event listener to log loading screens with their progress and message
client.on('loading_screen', (percent, message) => {
    console.log('LOADING SCREEN', percent, message);
});

// Event listener to generate and display QR code when required for authentication
// This event will not be fired if a session is specified
client.on('qr', qr => {
    // console.log('QR RECEIVED', qr);
    qrcode.generate(qr, {small: true});
});

// Event listener to log authentication failures
client.on('auth_failure', msg => {
    console.error('AUTHENTICATION FAILURE', msg);
});

// Event listener to indicate when the client is ready
client.on('ready', () => {
    console.log('Client is ready!');
});

// Event listener to log disconnections and their reasons
client.on('disconnected', (reason) => {
    console.log('Client was logged out', reason);
});

// Initialize the WhatsApp client
client.initialize();
 