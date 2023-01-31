const express = require('express');
const router = express.Router();
const mysql = require('promise-mysql');
const config = require("../../config");

initDb = async () => {
    pool = await mysql.createPool(config.pool);
}

initDb();

router.get('/', function(req,res){
    res.send('Welcome to LibraEase API');
});

router.route('/author').get(async function(req,res){
    try{
        let conn = await pool.getConnection();
        let rows = await conn.query(`SELECT * FROM author`);
        conn.release();
        res.send(rows);
    } catch(e){
        console.log(e);
        return res.json({"code": 100, "status": "Error with query"});
    }
}).post(async function(req,res){
    const author = {
        name: req.body.name,
        surname: req.body.surname
    }
    console.log(req.body);
    // console.log(author);

    try{
        let conn = await pool.getConnection();
        let q = await conn.query('INSERT INTO author SET ?', author);
        conn.release();
        res.json({status: 'OK', insertId:q.insertId});
    } catch(e){
        console.log(e);
        res.json({status: 'NOT OK'});
    }
});

module.exports = router;