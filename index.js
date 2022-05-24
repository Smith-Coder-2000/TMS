var express = require('express');
var bodyParser = require('body-parser');
var multer = require('multer');
var upload = multer();
var app = express();
var mysql = require('mysql');
var cors = require('cors')
var path = require('path');
const bcrypt = require('bcryptjs');
var nodemailer = require('nodemailer');
const fs = require('fs');


app.use(bodyParser.json()); 
app.use(bodyParser.urlencoded({ extended: true })); 
app.use(upload.any()); 
app.use(express.static('public'));



var passwordValidator = require('password-validator');
var schema = new passwordValidator();

const port = 3000;
app.use(cors())
app.set('views', __dirname + '/views');
app.use("/assets", express.static(path.join(__dirname, 'assets')));
var date_obj = new Date();

var transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: 'theatexbangalore@gmail.com',
    pass: 'aiyghqdkebmeozhi'
  }
});


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
    port: 3306,
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
  res.sendFile(path.join(__dirname,'./form.html'));
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
            connection.query(`SELECT * from customer where email='${emails}'`,function(errr,row){
              console.log(row)
              if (errr) throw errr
                res.redirect('/send?r='+row[0].cust_id+'&r='+password+'&r='+emails);
            })
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

app.post('/login',(req,res)=>{
  try{
    var id=req.body.id;
    var pass=req.body.password;
    var count=0;
    connection.query(`SELECT cust_id,password from customer where cust_id=${id}`,function(err,rows){
      if (err) throw err
      if(rows.length!=0){
        var password_hash=rows[0]["password"];
        const verified = bcrypt.compareSync(pass, password_hash.toString());
        if(verified){
          count=1;
        }
      }
      if(count==1){
        res.send({"encrypt":bcrypt.hashSync(pass, 10),"cust_id":id})
      }
      else{
        res.status(404).send('Not Found');
      }
    })
  }
  catch{
    res.status(404).send('Not Found');
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


app.post('/addMovie',(req,res)=>{
    var name=req.body.movie_name;
    var genre=req.body.genre;
    var release_date=req.body.release_date;
    var director=req.body.director;
    var starring=req.body.starring;
    var language=req.body.language;
    var duration=req.body.duration;
    var rating=req.body.rating;
    var price=req.body.price;
    if(name!=""&&genre!=""&&release_date!=""&&director!=""&&starring!=""&&language!=""&&req.files[0].originalname!=""&&duration!=""&&rating!=""&&price!=""){
          connection.query(`INSERT INTO movie VALUES (0,'${name}','${genre}','${release_date}','assets/images/${req.files[0].originalname}','${director}','${starring}','${language}',${duration},${rating},${price})`,function(err){
            if (err) throw err
            res.send("movie added successfully")
          })
      } 
      else{
        res.send('please dont leave the fields blank');
      }
})

app.post('/deleteMovies',(req,res)=>{
  var id=req.body.movie_id;
  connection.query(`SELECT * FROM movie where movie_id=${id}`,(err,rows)=>{
    if(rows.length!=0){
      connection.query(`DELETE FROM movie where movie_id=${id}`,(err,rows)=>{
        res.send("movie deleted successfully")
      })
    }
    else{
      res.send("movie not found")
    }
  })
})

app.get('/screens',(req,res)=>{
  connection.query(`SELECT * FROM screens`,(err,rows)=>{
    res.json({rows})
  })
})

app.post('/assignScreen',(req,res)=>{
  var movie_id=req.body.movie_id;
  var screen_id=req.body.screen_id;
  var date=req.body.date;
  var start_time=req.body.start_time;
  var end_time=req.body.end_time;
  console.log(date)
  var datetime = new Date();  
  if(date>datetime.toISOString().slice(0,10)){
    if(start_time=="08:00"||start_time=="13:00"||start_time=="18:00"||start_time=="23:00"){
      connection.query(`SELECT * FROM movie where movie_id=${movie_id}`,(err,movie)=>{
        if(movie.length!=0){
          connection.query(`SELECT * FROM screens where screen_id=${screen_id}`,(err,screen)=>{
            if(screen.length!=0){
              connection.query(`select * from shows where date = '${String(date)}' and screen_id=${screen_id} and start_time='${start_time}';`,(err,rows)=>{
                if(rows.length==0){
                  connection.query(`INSERT into shows VALUES(0,'${start_time}','${end_time}','${date}',${screen_id},${movie_id})`,(err)=>{
                    res.send("show successfully created")
                  })
                }
                else{
                  res.send("screen is already assigned to a movie")
                }
              })
            }
            else{
              res.send("invalid screen")
            }
          })
        }
        else{
          res.send("invalid movie")
        }
      })
    }
    else{
      res.send("invalid time")
    }
  }
  else{
    res.send("please select valid date")
  }
})

app.get('/getShows',(req,res)=>{
  connection.query(`SELECT * FROM shows`,(err,rows)=>{
    res.json({rows})
  })
})

app.post('/deleteShow',(req,res)=>{
  var id=req.body.show_id;
  connection.query(`SELECT * FROM shows where show_id=${id}`,(err,rows)=>{
    if (err) throw err
    if(rows.length!=0){
      connection.query(`DELETE FROM shows where show_id=${id}`,(err)=>{
        if (err) throw err
        res.send("show deleted successfully")
      })
    }
    else{
      res.send("show not found")
    }
  })
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
      connection.query(`SELECT seat_id from ticket_details where show_id=${index};`,function(err,row1){
        if (err) throw err
        res.json({"seats":row,"booked":row1,"show_id":index,"screen_id":rows})
      })
    })
  })
})

//

app.get('/seats',(req,res)=>{
  console.log(req.query.a)
  try{
    connection.query(`SELECT * FROM shows where show_id=${req.query.a[0]} and start_time>=CURTIME() and date=CURDATE()`,function(err,day1){
      if (err) throw err;
      connection.query(`SELECT * FROM shows where show_id=${req.query.a[0]} and date>CURDATE()`,function(err,day2){
      if (err) throw err;
        connection.query(`SELECT cust_id from customer where cust_id=${req.query.a[1]}`,function(err,customer){
          if (err) throw err;
          if(day1.length!=0 || day2.length!=0 && customer.length!=0){
            connection.query(`SELECT screen_id,movie_id from shows where show_id=${req.query.a[0]};`,function(err,row){
              if (err) throw err;
                connection.query(`SELECT * from seats where screen_id=${row[0].screen_id} AND seat_id NOT IN (SELECT seat_id from ticket_details where show_id=${req.query.a[0]})`,function(err,rows){
                  if (err) throw err;
                  var count=0
                  for(i=2;i<req.query.a.length;i++){
                    for(j=0;j<rows.length;j++){
                      if(rows[j].seat_id==req.query.a[i]){
                        count++;
                      } 
                    }
                  }
                  console.log(count)
                  if(count==req.query.a.length-2){
                    connection.query(`SELECT price from movie where movie_id=${row[0].movie_id}`,function(err,price){
                      if (err) throw err;
                      connection.query(`INSERT INTO ticket VALUES (null,${count},${count*price[0].price},${req.query.a[0]},${req.query.a[1]},0)`,function(err){
                        if (err) throw err;
                      connection.query(`SELECT ticket_id from ticket where show_id=${req.query.a[0]}`,function(err,tic){
                        if (err) throw err;
                        for(i=2;i<req.query.a.length;i++){
                          connection.query(`INSERT into ticket_details VALUES(${req.query.a[i]},${tic[0].ticket_id},${req.query.a[0]})`,function(err){
                            if (err) throw err;
                          })  
                        }
                      }) 
                    })
                  }) 
                  res.send("please proceed to payment and wait for confirmation");
                    return;
                  }
                  else{
                    res.send('invalid seats');
                    return;
                  }
              })
            })
          }
          else{
            res.send('invalid show or customer id');
            return;
          }
        })
      })
    })
  }
  catch{
    res.send('invalid seat or show');
    return;
  }
})

app.get('/confirmation',(req,res)=>{
  connection.query(`SELECT A.* from ticket A where A.show_id in (SELECT B.show_id from shows B where start_time>=CURTIME() and date=CURDATE()) and status=0`,(err,rows)=>{
    if (err) throw err
    connection.query(`SELECT A.* from ticket A where A.show_id in (SELECT B.show_id from shows B where date>CURDATE() and status=0)`,(err,row)=>{
      if (err) throw err
      res.json({rows,row})  
    })
  })
})

app.get('/confirm',(req,res)=>{
  if(req.query.a[1]==1){
    connection.query(`UPDATE ticket SET status = 1 WHERE ticket_id = ${req.query.a[0]};`,(err)=>{
      if (err) throw err
      mail=req.query.a[2];
      console.log(mail)
      var mailOptions = {
        from: 'theatexbangalore@gmail.com@gmail.com',
        to: `${mail}`,
        subject: `Welcome to theatex`,
        text:`here is your ticket\n ticket id:${req.query.a[0]}\n Just show this ticket id at the entrance\n\nEnjoy the movie\n\nEnjoy Theatex\nThank you`
      };
      transporter.sendMail(mailOptions, function(err, info){
        if (err) {
          res.status(404).send('Not sent');
          throw err
        } else {
          res.send("email successfully sent")
        }
      });
    })
  }
  else if(req.query.a[1]==0){
    connection.query(`DELETE from ticket_details WHERE ticket_id = ${req.query.a[0]};`,(err)=>{
      if (err) throw err
      connection.query(`DELETE from ticket WHERE ticket_id = ${req.query.a[0]};`,(err)=>{
        if (err) throw err
        res.send("ticket are deleted")
      })
  })
}
})


app.get('/offers',(req,res)=>{
  
})



app.get('/send',(req,res)=>{
  var id=req.query.r[0];
  var password=req.query.r[1];
  var mail=req.query.r[2];
  console.log(mail)
  var mailOptions = {
    from: 'theatexbangalore@gmail.com@gmail.com',
    to: `${mail}`,
    subject: `Welcome to theatex`,
    text:`here is your Credentials\n user id:${id}\n password:${password}\nThis is a computer generated mail\n\nEnjoy Theatex\nThank you`
  };
  transporter.sendMail(mailOptions, function(err, info){
    if (err) {
      res.status(404).send('Not sent');
      throw err
    } else {
      res.send("email successfully sent")
    }
  });
})


 
app.listen(port, () => {
    console.log(`Example app listening at http://localhost:${port}`)
  })