CREATE TABLE customer(
    cust_id int(10) NOT NULL AUTO_INCREMENT,
    cust_name varchar(25) NOT NULL,
    cust_age int(2) NOT NULL,
    phone_number int(12) NOT NULL,
    email varchar(25) NOT NULL,
    PRIMARY KEY (cust_id)
);

ALTER TABLE customer AUTO_INCREMENT=1000;
INSERT INTO customer VALUES (null,"Ashwin",22,"6289676192","ashwinkumar@gmail.com");
INSERT INTO customer VALUES (null,"Amber",23,"6289676193","amberlinda@gmail.com");
INSERT INTO customer VALUES (null,"Rapunzel",20,"9289676192","rapunzel12@gmail.com");
INSERT INTO customer VALUES (null,"Vikash",24,"9889676192","vikashkumar@gmail.com");
INSERT INTO customer VALUES (null,"Smith",21,"9089676192","smithcdgmail.com");

CREATE TABLE admin(
    admin_id int(5) NOT NULL AUTO_INCREMENT,
    admin_name varchar(25) NOT NULL,
    email varchar(25) NOT NULL,
    role varchar(25) NOT NULL,
    phone_number int(12) NOT NULL,
    PRIMARY KEY (admin_id)
);

ALTER TABLE admin AUTO_INCREMENT=100;

INSERT INTO admin VALUES (,"Vettel","Vettel@gmail.com","manager",9915647895);
INSERT INTO admin VALUES (,"Hamilton","Hamilton@gmail.com","manager",9915647897);
INSERT INTO admin VALUES (,"Ronaldo","Ronaldo@gmail.com","owner",9915647867);


CREATE TABLE movie(
    movie_id int(10) NOT NULL AUTO_INCREMENT,
    movie_name varchar(20) NOT NULL,
    genre varchar(10) NOT NULL,
    release_date DATE NOT NULL,
    movie_poster BLOB NOT NULL,
    director varchar(10) NOT NULL,
    starring varchar(25) NOT NULL,
    language varchar(20) NOT NULL,
    duration int(3) NOT NULL,
    rating float(2) NOT NULL,
    PRIMARY KEY (movie_id)
);
ALTER TABLE movie AUTO_INCREMENT=500;

INSERT INTO `movie`(`movie_id`, `movie_name`, `genre`, `release_date`, `movie_poster`, `director`, `starring`, `language`, `duration`, `rating`) VALUES 
(null,"KGF","action",'2022-04-14',"null","prasanth neel","yash","all",180,5);

INSERT INTO `movie`(`movie_id`, `movie_name`, `genre`, `release_date`, `movie_poster`, `director`, `starring`, `language`, `duration`, `rating`) VALUES 
(null,"The Flash","action",'2022-04-17',"null","Greg Berlanti","Grant Gustin","english",160,5);

INSERT INTO `movie`(`movie_id`, `movie_name`, `genre`, `release_date`, `movie_poster`, `director`, `starring`, `language`, `duration`, `rating`) VALUES 
(null,"Doctor Strange: In The Multiverse Of Madness","action",'2022-05-06',"null","Sam Raimi","Benedict Cumberbatch","english",126,0);

INSERT INTO `movie`(`movie_id`, `movie_name`, `genre`, `release_date`, `movie_poster`, `director`, `starring`, `language`, `duration`, `rating`) VALUES 
(null,"Runway 34","action",'2022-04-29',"null","Ajay Devgn","Ajay Devgn","hindi",190,0);

INSERT INTO `movie`(`movie_id`, `movie_name`, `genre`, `release_date`, `movie_poster`, `director`, `starring`, `language`, `duration`, `rating`) VALUES 
(null,"RRR","action",'2022-03-25',"null","S. S. Rajamouli","Jr. NTR,Ram Charan","all",182,5);


CREATE TABLE screens(
    screen_id int(2) NOT NULL,
    screen_type varchar(10) NOT NULL,
    screen_name varchar(10) NOT NULL,
    PRIMARY KEY (screen_id)
);

INSERT INTO SCREENS VALUES(1,"IMAX","AUDI_1");
INSERT INTO SCREENS VALUES(2,"GOLD","AUDI_2");
INSERT INTO SCREENS VALUES(3,"CLASSIC","AUDI_3");
INSERT INTO SCREENS VALUES(4,"CLASSIC","AUDI_4");

CREATE TABLE seats(
    seat_id int(10) NOT NULL,
    seat_name varchar(5) NOT NULL,
    seat_type varchar(5) NOT NULL,
    screen_id int(2) NOT NULL,
    PRIMARY KEY (seat_id),
    FOREIGN KEY (screen_id) REFERENCES screens(screen_id)
);

CREATE TABLE shows(
    show_id int(10) NOT NULL AUTO_INCREMENT,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    date DATE NOT NULL, 
    screen_id int(2) NOT NULL,
    movie_id int(10) NOT NULL,
    PRIMARY KEY (show_id),
    FOREIGN KEY (screen_id) REFERENCES screens(screen_id),
    FOREIGN KEY (movie_id) REFERENCES movie(movie_id)
);

INSERT INTO `shows`(`show_id`, `start_time`, `end_time`, `date`, `screen_id`, `movie_id`) VALUES (0,90,120,'2022-05-05',1,516);

CREATE TABLE ticket(
    ticket_id int(10) NOT NULL AUTO_INCREMENT,
    no_seats int(10) NOT NULL,
    price float(5,2) NOT NULL,
    show_id int(10) NOT NULL,
    cust_id int(10) NOT NULL,
    status varchar(10) NULL,
    PRIMARY KEY (ticket_id),
    FOREIGN KEY (show_id) REFERENCES shows(show_id),
    FOREIGN KEY (cust_id) REFERENCES customer(cust_id)
);

CREATE TABLE ticket_details(
    seat_id int(10) NOT NULL,
    ticket_id int(10) NOT NULL,
    show_id int(10) NOT NULL,
    FOREIGN KEY (seat_id) REFERENCES seats(seat_id),
    FOREIGN KEY (ticket_id) REFERENCES ticket(ticket_id),
    FOREIGN KEY (show_id) REFERENCES shows(show_id)
);

CREATE TABLE offers(
    offer_id int(10) NOT NULL,
    movie_id int(10) NOT NULL,
    price float(5,2) NOT NULL,
    validity DATE NOT NULL,
    PRIMARY KEY (offer_id),
    FOREIGN KEY (movie_id) REFERENCES movie(movie_id)
);

CREATE TABLE transaction(
    transaction_id int(10) NOT NULL AUTO_INCREMENT,
    date DATE NOT NULL,
    payment_type varchar(6) NOT NULL,
    status varchar(10) NOT NULL,
    total_pay float(5,2),
    ticket_id int(10) NOT NULL,
    offer_id int(10) NOT NULL,
    PRIMARY KEY (transaction_id),
    FOREIGN KEY (ticket_id) REFERENCES ticket(ticket_id),
    FOREIGN KEY (offer_id) REFERENCES offers(offer_id)
);

CREATE TABLE credential(
    cus_id int(10) NOT NULL,
    owner_id int(10) NOT NULL,
    passwd varchar(10) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES customer(cust_id),
    FOREIGN KEY (owner_id) REFERENCES admin(admin_id)
); 

CREATE TABLE credential(
    cus_id int(10),
    owner_id int(10),
    passwd varchar(10) NOT NULL,
    FOREIGN KEY (cus_id) REFERENCES customer(cust_id),
    FOREIGN KEY (owner_id) REFERENCES admin(admin_id)
); 
/* CREATE TABLE credential(
    user_id int(10) NOT NULL,
    passwd varchar(10) NOT NULL,
    PRIMARY KEY (user_id),
    FOREIGN KEY (user_id) REFERENCES customer(cust_id),
    FOREIGN KEY (user_id) REFERENCES admin(admin_id)
); */

