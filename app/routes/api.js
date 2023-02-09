const express = require('express');
const router = express.Router();
const mysql = require('promise-mysql');
const config = require("../../config");
const jwt = require('jsonwebtoken');
const {secret} = require("../../config");

initDb = async () => {
    pool = await mysql.createPool(config.pool);
}

initDb();

router.get('/', function(req,res){
    res.send('Welcome to LibraEase API');
});
router.route('/genre').get(async function(req,res){
    try{
        let conn = await pool.getConnection();
        let rows = await conn.query(`SELECT * FROM genre`);
        conn.release();
        res.send(rows);
    } catch(e){
        console.log(e);
        return res.json({"code": 100, "status": "Error with query"});
    }
});
router.route('/genre/:id').get(async function(req,res){
    try {
        let conn = await pool.getConnection();
        let rows = await conn.query('SELECT * FROM genre WHERE idGenre=?',req.params.id);
        conn.release();
        res.json({ status: 'OK', genre:rows[0]});
    } catch (e){
        console.log(e);
        return res.json({"code" : 100, "status" : "Error with query"});
    }
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
});
router.route('/author/:id').get(async function(req,res){
    try {
        let conn = await pool.getConnection();
        let rows = await conn.query('SELECT * FROM author WHERE idAuthor=?',req.params.id);
        conn.release();
        res.send(rows[0]);
    } catch (e){
        console.log(e);
        return res.json({"code" : 100, "status" : "Error with query"});
    }
});
router.route('/publisher').get(async function(req,res){
    try{
        let conn = await pool.getConnection();
        let rows = await conn.query(`SELECT * FROM publisher`);
        conn.release();
        res.send(rows);
    } catch(e){
        console.log(e);
        return res.json({"code": 100, "status": "Error with query"});
    }
});
router.route('/publisher/:id').get(async function(req,res){
    try {
        let conn = await pool.getConnection();
        let rows = await conn.query('SELECT * FROM publisher WHERE idPublisher=?',req.params.id);
        conn.release();
        res.json({ status: 'OK', publisher:rows[0]});
    } catch (e){
        console.log(e);
        return res.json({"code" : 100, "status" : "Error with query"});
    }
});
router.route('/book').get(async function(req,res){
    try{
        let conn = await pool.getConnection();
        let rows = await conn.query(`SELECT * FROM book`);
        conn.release();
        res.send(rows);
    } catch(e){
        console.log(e);
        return res.json({"code": 100, "status": "Error with query"});
    }
});
router.route('/book/:ISBN').get(async function(req,res){
    try {
        let conn = await pool.getConnection();
        let rows = await conn.query('SELECT * FROM book WHERE ISBN=?',req.params.ISBN);
        conn.release();
        res.json(rows[0]);
    } catch (e){
        console.log(e);
        return res.json({"code" : 100, "status" : "Error with query"});
    }
});

router.use(function(req,res,next){
    let token = req.body.token || req.params.token || req.headers['x-access-token'] || req.query.token;
    if(token){
        jwt.verify(token, secret, function(err, decoded){
            if(err){
                res.status(403).send({status: false, message: 'Wrong token provided'});
            } else {
                req.decoded = decoded;
                next();
            }
        });
    } else{
        res.status(403).send({status: false, message: 'No token provided'});
    }
});

//GENRES
router.route('/genre').post(async function(req,res){
    const genre = {
        genre: req.body.genre
    }
    console.log(genre);

    try{
        let conn = await pool.getConnection();
        let q = await conn.query('INSERT INTO genre SET ?', genre);
        conn.release();
        res.json({status: 'OK', insertId:q.insertId});
    } catch(e){
        console.log(e);
        res.json({status: 'NOT OK'});
    }
}).put(async function(req,res){
    const genre = {
        genre: req.body.genre
    }
    console.log(genre);

    try {
        let conn = await pool.getConnection();
        let q = await conn.query('UPDATE genre SET ? WHERE idGenre = ?', [genre,req.body.id]);
        conn.release();
        res.json({ status: 'OK', changedRows:q.changedRows });
        console.log(q);
    } catch (e){
        res.json({ status: 'NOT OK' });
    }
}).delete(async function(req,res){
    res.json({"code" : 101, "status" : "Body in delete request"});
});

router.route('/genre/:id').delete(async function(req,res){
    try{
        let conn = await pool.getConnection();
        let q = await conn.query('DELETE FROM genre WHERE idGenre = ?', req.params.id);
        conn.release();
        res.json({status: 'OK', affectedRows: q.affectedRows});
    } catch (e) {
        console.log(e);
        res.json({status: 'NOT OK'});
    }
});

//AUTHOR
router.route('/author').post(async function(req,res){
    const author = {
        name: req.body.name,
        surname: req.body.surname
    }

    try{
        let conn = await pool.getConnection();
        let q = await conn.query('INSERT INTO author SET ?', author);
        conn.release();
        res.json({status: 'OK', insertId:q.insertId});
    } catch(e){
        console.log(e);
        res.json({status: 'NOT OK'});
    }
}).put(async function(req,res){
    const author = {
        name: req.body.name,
        surname: req.body.surname
    }
    console.log(author);

    try {
        let conn = await pool.getConnection();
        let q = await conn.query('UPDATE author SET ? WHERE idAuthor = ?', [author,req.body.id]);
        conn.release();
        res.json({ status: 'OK', changedRows:q.changedRows });
        console.log(q);
    } catch (e){
        res.json({ status: 'NOT OK' });
    }
}).delete(async function(req,res){
    res.json({"code" : 101, "status" : "Body in delete request"});
});

router.route('/author/:id').delete(async function(req,res){
    try{
        let conn = await pool.getConnection();
        let q = await conn.query('DELETE FROM author WHERE idAuthor = ?', req.params.id);
        conn.release();
        res.json({status: 'OK', affectedRows: q.affectedRows});
    } catch (e) {
        console.log(e);
        res.json({status: 'NOT OK'});
    }
});

//PUBLISHERS
router.route('/publisher').post(async function(req,res){
    const publisher = {
        name: req.body.name
    }
    console.log(publisher);

    try{
        let conn = await pool.getConnection();
        let q = await conn.query('INSERT INTO publisher SET ?', publisher);
        conn.release();
        res.json({status: 'OK', insertId:q.insertId});
    } catch(e){
        console.log(e);
        res.json({status: 'NOT OK'});
    }
}).put(async function(req,res){
    const publisher = {
        name: req.body.name
    }
    console.log(publisher);

    try {
        let conn = await pool.getConnection();
        let q = await conn.query('UPDATE publisher SET ? WHERE idPublisher = ?', [publisher,req.body.id]);
        conn.release();
        res.json({ status: 'OK', changedRows:q.changedRows });
        console.log(q);
    } catch (e){
        res.json({ status: 'NOT OK' });
    }
}).delete(async function(req,res){
    res.json({"code" : 101, "status" : "Body in delete request"});
});

router.route('/publisher/:id').delete(async function(req,res){
    try{
        let conn = await pool.getConnection();
        let q = await conn.query('DELETE FROM publisher WHERE idPublisher = ?', req.params.id);
        conn.release();
        res.json({status: 'OK', affectedRows: q.affectedRows});
    } catch (e) {
        console.log(e);
        res.json({status: 'NOT OK'});
    }
});

//BOOKS
router.route('/book').post(async function(req,res){
    const book = {
        ISBN: req.body.ISBN,
        title: req.body.title,
        pages: req.body.pages,
        Genre_idGenre: req.body.idGenre,
        Author_idAuthor: req.body.idAuthor,
        Publisher_idPublisher: req.body.idPublisher
    }
    console.log(book);

    try{
        let conn = await pool.getConnection();
        let q = await conn.query('INSERT INTO book SET ?', book);
        conn.release();
        res.json({status: 'OK', insertId:q.insertId});
    } catch(e){
        console.log(e);
        res.json({status: 'NOT OK'});
    }
}).put(async function(req,res){
    const book = {
        ISBN: req.body.ISBN,
        title: req.body.title,
        pages: req.body.pages,
        Genre_idGenre: req.body.idGenre,
        Author_idAuthor: req.body.idAuthor,
        Publisher_idPublisher: req.body.idPublisher
    }
    console.log(book);

    try {
        let conn = await pool.getConnection();
        let q = await conn.query('UPDATE book SET ? WHERE ISBN = ?', [book,req.body.ISBN]);
        conn.release();
        res.json({ status: 'OK', changedRows:q.changedRows });
        console.log(q);
    } catch (e){
        res.json({ status: 'NOT OK' });
    }
}).delete(async function(req,res){
    res.json({"code" : 101, "status" : "Body in delete request"});
});

router.route('/book/:ISBN').delete(async function(req,res){
    try{
        let conn = await pool.getConnection();
        let q = await conn.query('DELETE FROM BOOK WHERE ISBN = ?', req.params.ISBN);
        conn.release();
        res.json({status: 'OK', affectedRows: q.affectedRows});
    } catch (e) {
        console.log(e);
        res.json({status: 'NOT OK'});
    }
});

//LIBRARY
router.route('/library').get(async function(req,res){
    try{
        let conn = await pool.getConnection();
        let rows = await conn.query(`SELECT * FROM library`);
        conn.release();
        res.send(rows);
    } catch(e){
        console.log(e);
        return res.json({"code": 100, "status": "Error with query"});
    }
}).post(async function(req,res){
    const entry = {
        User_idUser: req.body.idUser,
        Book_ISBN: req.body.ISBN,
        Progress: 0,
        Status: "reading"
    }
    console.log(entry);

    try{
        let conn = await pool.getConnection();
        let q = await conn.query('INSERT INTO library SET ?', entry);
        conn.release();
        res.json({status: 'OK', insertId:q.insertId});
    } catch(e){
        console.log(e);
        res.json({status: 'NOT OK'});
    }
}).put(async function(req,res){
    const entry = {
        Progress: req.body.progress,
        Status: req.body.status
    }

    try {
        let conn = await pool.getConnection();
        let q = await conn.query('UPDATE library SET ? WHERE User_idUser = ? AND Book_ISBN=?', [entry,req.body.idUser,req.body.ISBN]);
        conn.release();
        res.json({ status: 'OK', changedRows:q.changedRows });
        console.log(q);
    } catch (e){
        res.json({ status: 'NOT OK' });
    }
});

router.get('/me',function (req,res){
    console.log(req.decoded);
    res.send({status: 200, user:req.decoded});
});

module.exports = router;