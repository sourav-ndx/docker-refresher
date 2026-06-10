const http = require('http');
const os = require('os');

const PORT = process.env.PORT || 8080;

const server = http.createServer((req, res) => {
    // Collect system metadata to demonstrate shared kernel concepts in action!
    const responsePayload = {
        status: "Online",
        message: "DevOps Core Base: Sealed & Settled",
        runtime: `Node.js ${process.version}`,
        platform: process.platform,
        architecture: process.arch,
        container_hostname: os.hostname(), // Demonstrating UTS namespace separation
        system_load: os.loadavg(),
        timestamp: new Date().toISOString()
    };

    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify(responsePayload, null, 2));
});

server.listen(PORT, () => {
    console.log(`🚀 Secure production server running on port ${PORT}`);
});
