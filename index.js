var express = require('express');
var bodyParser = require('body-parser');
var multer = require('multer');
var upload = multer();
var app = express();
var mysql = require('mysql');
var cors = require('cors')
var path = require('path');
const bcrypt = require('bcryptjs');


app.use(bodyParser.json()); 
app.use(bodyParser.urlencoded({ extended: true })); 
app.use(upload.array()); 
app.use(express.static('public'));

var passwordValidator = require('password-validator');
var schema = new passwordValidator();

const port = 3000;
app.use(cors())
app.set('views', __dirname + '/views');
app.use("/assets", express.static(path.join(__dirname, 'assets')));
var date_obj = new Date();





schema
.is().min(8)                                    
.is().max(100)                                  
.has().uppercase()                              
.has().lowercase()                             
.has().digits(2)                                
.has().not().spaces()                           
.is().not().oneOf(['Passw0rd', 'Password123']);



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
  res.sendFile(path.join(__dirname,'./test.html'));
 })
  

app.post('/register',(req,res)=>{
  var name=req.body.cust_name;  
  var phn=req.body.phone_number;
  var emails=req.body.email;
  var password=req.body.password;
  var count=0;
 console.log(count)
  if (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(emails))
  {
    if(schema.validate(password)){
        connection.query('SELECT email FROM customer', function (err,rows) {
          if (err) throw err
          console.log(rows.length)
          for(var i=0;i<rows.length;i++)
          {
            if(emails==rows[i].email){
              count=1;
              console.log("hello")
              break;
            }
          }
        if(count==1){
          res.send("Email id already registered");
        }
        else{
          connection.query(`INSERT INTO customer VALUES (null,'${name}',0,${phn},'${emails}','${bcrypt.hashSync(password, 10)}')`,function(err){
            if (err) throw err
            res.send("successfully registered");
          }) 
        }
      })
      }
      else{
        res.send("enter strong password");
      }
    } 
  else{
      res.send("Invalid email format");
  }
  
})

app.get('/movies', (req, res) => {
  connection.query('SELECT * FROM movie',(err,rows,fields)=>{
    if (err) {
      console.log("File read failed:", err);
      return;
    }
    try{
        res.json({rows})
        
    }catch (err) {
        console.log('error parsing JSON',err)
    }
    });
});

app.get('/addMovie',(req,res)=>{
  res.sendFile(path.join(__dirname,'./form.html'));
})

app.get('/movie/:index',(req,res) => {
  var index= req.params["index"];
  connection.query(`SELECT * FROM shows where movie_id=${index} and start_time>=CURTIME() and date=CURDATE()`,(err,rows,fields)=>{
    connection.query(`SELECT * FROM shows where movie_id=${index} and date>CURDATE()`,(err,row,fields)=>{
    if (err) {
      console.log("File read failed:", err);
      return;
    }
    try{
        console.log(row)
        console.log(rows)
        res.json({rows,row})
        
    }catch (err) {
        console.log('error parsing JSON',err)
    }
    });
  })
})


app.get('/movie/show/:index',(req,res)=>{
  var index= req.params["index"];
  connection.query(`SELECT screen_id from shows where show_id=${index}`,function(err,rows){
    if (err) throw err
    connection.query(`SELECT * from seats where screen_id=${rows[0].screen_id}`,function(err,row){
      if (err) throw err
      res.json({row,index,rows})
    })
  })
})

app.post('/login',(req,res)=>{

  var id=req.body.id;
  var pass=req.body.password;

  var count=0;
  connection.query(`SELECT cust_id,password from customer`,function(err,rows){
    if (err) throw err
    for(var i=0;i<rows.length;i++)
          {
            var password_hash=rows[i]["password"];
            const verified = bcrypt.compareSync(pass, password_hash.toString());
            if(id==rows[i].cust_id && verified){
              count=1;
              break;
            }
          }
        if(count==1){
          res.send(bcrypt.hashSync(pass, 10))
        }
        else{
          res.status(404).send('Not Found');
        }
})
})
 
app.listen(port, () => {
    console.log(`Example app listening at http://localhost:${port}`)
  })