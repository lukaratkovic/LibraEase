const express = require('express');
const app = express();
const bodyParser = require('body-parser');
const path = require('path');
const cors = require('cors');
const config = require('./config');

app.use(express.static(__dirname+'/public/app'));
app.use(bodyParser.urlencoded({extended: true}));
app.use(bodyParser.json());
app.use(cors());

const authRouter = require('./app/routes/auth');
const apiRouter = require('./app/routes/api');

app.use('/auth', authRouter);
app.use('/api', apiRouter);
app.get('*',function(req,res){
    res.sendFile(path.join(__dirname, '/public/app/index.html'));
})

app.listen(config.port);
console.log(`Running on port ${config.port}`);