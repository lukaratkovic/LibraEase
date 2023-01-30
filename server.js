const express = require('express');
const app = express();
const bodyParser = require('body-parser');
const mysql = require('promise-mysql');
const path = require('path');
const cors = require('cors');
const config = require('./config');

initDb = async () => {
    pool = await mysql.createPool(config.pool);
}

initDb();