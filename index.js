const express = require('express');
const app = express();
var mysql = require('mysql');
var cors = require('cors')
var path = require('path');
const port = 3000;
app.use(cors())
app.set('views', __dirname + '/views');
app.use("/assets", express.static(path.join(__dirname, 'assets')));


var connection = mysql.createConnection({
    host: 'localhost',
    port: 3307,
    user: 'root',
    password: '',
    database: 'tms'
  })

connection.connect(function(err){
    if(!err)
    console.log("database connected");
    else
    console.log("database not connected");
  })

app.get('/',(req,res)=>{
    res.send("hello");
 })

app.get('/movies', (req, res) => {
  connection.query('SELECT * FROM movie',(err,rows,fields)=>{
    if (err) {
      console.log("File read failed:", err);
      return;
    }
    try{
        console.log(rows)
        res.json({rows})
        
    }catch (err) {
        console.log('error parsing JSON',err)
    }
    });
});

app.get('/addMovie',(req,res)=>{
  res.sendFile(path.join(__dirname,'./form.html'));
})

 
app.listen(port, () => {
    console.log(`Example app listening at http://localhost:${port}`)
  })