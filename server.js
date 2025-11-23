const express = require('express');
const os = require('os');
const app = express();
const port = process.env.PORT || 6000;


app.get('/', (req, res) => {
res.send(`<h1>Capstone Node App</h1><p>Hostname: ${os.hostname()}</p>`);
});


app.get('/health', (req, res) => res.json({ status: 'ok', time: new Date().toISOString() }));


app.listen(port, '0.0.0.0', () => console.log(`App listening on ${port}`));
