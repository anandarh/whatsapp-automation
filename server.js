const qrcode = require('qrcode-terminal');
const { Client, LocalAuth} = require('whatsapp-web.js');

// Set up the WhatsApp client
const client = new Client({
    // Configuration for Puppeteer, a headless browser automation library
    puppeteer: {
        headless: 'new',
        args: [
            "--no-sandbox",
            "--disable-setuid-sandbox",
            "--disable-gpu"
        ]
	},
    // Use a local authentication strategy for client authentication
    // It is possible to not re-authenticate every time the client is restarted
    authStrategy: new LocalAuth({
        dataPath: './data/client_auth'
    }),
});

// Event listener to log loading screens with their progress and message
client.on('loading_screen', (percent, message) => {
    console.log('LOADING SCREEN', percent, message);
});

// Event listener to generate and display QR code when required for authentication
// This event will not be fired if a session is specified
client.on('qr', qr => {
    // console.log(qr);
    qrcode.generate(qr, {small: true});
});

// Event listener to log authentication failures
client.on('auth_failure', msg => {
    console.error('AUTHENTICATION FAILURE', msg);
});

// Event listener to indicate when the client is ready
client.on('ready', () => {
    console.log('Client is ready!');
    // client.getChats().then((chats) => {
    //     const monitoringGroup = chats.find((chat) => chat.name === 'Test');
    //     monitoringGroup.sendMessage('Automated message!').then((message) => {
    //         console.log('Message sent', `[${message.ack}]`)
    //     });
    // })
});

// Event listener to log disconnections and their reasons
client.on('disconnected', (reason) => {
    console.log('Client was logged out', reason);
});

// Initialize the WhatsApp client
client.initialize();
 