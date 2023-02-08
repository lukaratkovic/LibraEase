module.exports={
    port:  process.env.PORT || 8081,
    pool: {
        connectionLimit : 100,
        host     : 'localhost',
        user     : 'root',
        password : '',
        database : 'libraease',
        debug    :  false
    },
    secret: 'm8B6CMFn%dbS^68^B#1&^3x4J9ZbE#hy'
}