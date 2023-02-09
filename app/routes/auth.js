const express = require('express');
const crypto = require('crypto');
const mysql = require("promise-mysql");
const config = require("../../config");
const jwt = require('jsonwebtoken');
const {secret} = require("../../config");

let authRouter = express.Router();

initDb = async () => {
    pool = await mysql.createPool(config.pool);
}

initDb();

authRouter.post('/register',async function(req,res){
    let salt = crypto.randomBytes(128).toString('base64');
    let hash = crypto.pbkdf2Sync(req.body.password, salt, 10000, 64, 'sha512');
    let user = {
        username: req.body.username,
        password: hash.toString('hex'),
        email: req.body.email,
        level: req.body.level,
        salt: salt
    }
    try{
        let conn = await pool.getConnection();
        let q = await conn.query('INSERT INTO user SET ?', user);
        conn.release();
        res.json({status: 'OK', insertId:q.insertId});
    } catch(e){
        console.log(e);
        res.json({status: 'NOT OK'});
    }
}).post('/login', async function(req,res){
    try{
        let conn = await pool.getConnection();
        let rows = await conn.query('SELECT * FROM user WHERE username=?',req.body.username);
        conn.release;
        if(rows.length === 0)
            res.json({'status': 'NOT OK', description: "Username doesn't exist"});
        else{
            let compare = false;
            if(rows[0].salt){
                let hash = crypto.pbkdf2Sync(req.body.password, rows[0].salt, 10000, 64, 'sha512');
                compare = hash.toString('hex') === rows[0].Password;
                console.log(rows[0]);
            }
            if(compare){
                const token = jwt.sign({
                    idUser: rows[0].idUser,
                    username: rows[0].username,
                    email: rows[0].email,
                    level: rows[0].level
                }, secret, {
                    expiresIn: 3600
                });
                res.json({status: 200, token: token, user: rows[0]});
            } else if(rows.length > 0){
                res.json({status: 150, description: 'Wrong password'});
            }
        }
    }
    catch(e){
        console.log(e);
        res.json({code: 100, status: 'Error with query'});
    }
});

module.exports = authRouter;