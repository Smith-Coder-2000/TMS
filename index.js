const express = require('express');
const app = express();
var mysql = require('mysql');
var cors = require('cors')
var path = require('path');
var passwordValidator = require('password-validator');
var schema = new passwordValidator();
const req = require('express/lib/request');
const port = 3000;
app.use(cors())
app.set('views', __dirname + '/views');
app.use("/assets", express.static(path.join(__dirname, 'assets')));
var date_obj = new Date();
//Checking the crypto module
const crypto = require('crypto');
const { time } = require('console');
const algorithm = 'aes-256-cbc'; //Using AES encryption
const key = crypto.randomBytes(32);
const iv = crypto.randomBytes(16);

//Encrypting text
function encrypt(text) {
   let cipher = crypto.createCipheriv('aes-256-cbc', Buffer.from(key), iv);
   let encrypted = cipher.update(text);
   encrypted = Buffer.concat([encrypted, cipher.final()]);
   return { iv: iv.toString('hex'), encryptedData: encrypted.toString('hex') };
}

// Decrypting text
function decrypt(text) {
   let iv = Buffer.from(text.iv, 'hex');
   let encryptedText = Buffer.from(text.encryptedData, 'hex');
   let decipher = crypto.createDecipheriv('aes-256-cbc', Buffer.from(key), iv);
   let decrypted = decipher.update(encryptedText);
   decrypted = Buffer.concat([decrypted, decipher.final()]);
   return decrypted.toString();
}

// var hw = encrypt("Welcome to Tutorials Point...")
// console.log(hw)
// console.log(decrypt(hw))

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
    res.send("hello");
 })

app.post('/register',(req,res)=>{
  var name=req.body.cust_name;  
  var phn=req.body.phone_number;
  var email=req.body.email;
  var password=req.body.password;
  var count=0;
  if (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(email.value))
  {
    if(schema.validate(password.value)){
        connection.query('SELECT email FROM customer', function (err,rows) {
          if (err) throw err
          for(var i=0;i<rows.length;i++)
          {
            if(rows[i].email==email){
              count=1;
            }
          }
        })
        if(count=1){
          res.send("Email id already registered");
        }
        else{
          connection.query(`INSERT INTO customer VALUES (null,${name.value},0,${phn.value},${email.value})`,function(err){
            if (err) throw err
            connection.query(`SELECT cust_id WHERE email=${email}`,function(err,id){
              if (err) throw err
              connection.query(`INSERT INTO credential  VALUES (${id[0].cust_id},${encrypt(password.value)})`,function(err){
                if (err) throw err
              })
            })
          }) 
        }
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
  var password=req.body.password;
  console.log(id)
  console.log(password)
  var count=0;
  connection.query('SELECT * from credential',function(err,rows){
    if (err) throw err
    for(var i=0;i<rows.length;i++)
    {
      if(rows[i].user_id==id.value&&rows[i].passwd==password.value){
        count=1;
        break
      }
    }
    if(count==1){
      res.sendStatus(201,"success");
    }
    else{
      res.sendStatus(401,"unauthorized")
    }
  })
})
 
app.listen(port, () => {
    console.log(`Example app listening at http://localhost:${port}`)
  })