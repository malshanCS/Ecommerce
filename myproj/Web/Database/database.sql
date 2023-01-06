create database final;
use final;

create table product(
  ID int not null auto_increment,
  title varchar(50),
  brand varchar(50),
  image blob,
  base numeric(8,2),
  reg_data datetime default NULL,
  weight varchar(20),
  primary key (ID)
);
# insert products
insert into product(title,brand,image,base,reg_data,weight) values ('Iphone 13 mini','Apple','assets/products/iphone13mini.jpg',120000,'2022-12-31 11:11:11','250g');
insert into product(title,brand,image,base,reg_data,weight) values ('Iphone 13 pro','Apple','assets/products/iphone13pro.jpg',175000,'2022-12-31 11:11:11','400g');
insert into product(title,brand,image,base,reg_data,weight) values ('Iphone 14 plus','Apple','assets/products/iphone14plus.jpg',250000,'2022-12-31 11:11:11','450g');
insert into product(title,brand,image,base,reg_data,weight) values ('Iphone 14','Apple','assets/products/iphone14.jpg',200000,'2022-12-31 11:11:11','400g');
insert into product(title,brand,image,base,reg_data,weight) values ('Sony WX-2000','Sony','assets/products/sonyheadphone1.png',75000,'2022-12-31 11:11:11','150g');
insert into product(title,brand,image,base,reg_data,weight) values ('Sony MX-45','Sony','assets/products/sonyheadphone2.png',50000,'2022-12-31 11:11:11','120g');
insert into product(title,brand,image,base,reg_data,weight) values ('Green mini wireless Mic','Green','assets/products/GreenMiniWirelessMicrophone.png',10000,'2022-12-31 11:11:11','50g');
insert into product(title,brand,image,base,reg_data,weight) values ('Powerlogy Compact power bank','Powerlogy','assets/products/PowerologyCompact.png',15000,'2022-12-31 11:11:11','150g');


create table category(
    cat_id int auto_increment,
    name varchar(20),
    description varchar(50) default null,
    primary key (cat_id)
);
# add cats
insert into category(name, description) values ('Mobile Phones','Mobile phones only');
insert into category(name, description) values ('Accessories','Accessories only');
insert into category(name, description) values ('Headphones','Headphones only');

select * from category;


create table subcategory(
    sub_cat_id int auto_increment,
    cat_id int,
    name varchar(20) UNIQUE ,
    primary key (sub_cat_id)
);

insert into subcategory(cat_id, name) VALUES (1,'Smart Phones');
insert into subcategory(cat_id, name) VALUES (1,'Tablets');
insert into subcategory(cat_id, name) VALUES (1,'Button Phones');
insert into subcategory(cat_id, name) VALUES (2,'Wireless Headset');
insert into subcategory(cat_id, name) VALUES (2,'Wired Headset');
insert into subcategory(cat_id, name) VALUES (3,'Phone Accessories');





create table belongs(
    product_id int,
    cat_id int,
    sub_cat_id int,
    primary key (product_id,cat_id,sub_cat_id)
);
# ---------------------------------------------------------------------------------------------

create table variation(
    var_id int not null auto_increment,
    PID int,
    name varchar(50),
    primary key (var_id)
);


create table variant_option(
    opt_id int not null auto_increment,
    var_id int,
    name varchar(50),
    primary key (opt_id)
);


create table combination(
    sku varchar(50),
    opt_id int,
    description varchar(50),
    primary key (sku,opt_id)
);


create table stock(
    sku varchar(50) unique,
    initial_stock int,
    avai_stock int,
    unit_price numeric(8,2),
    primary key (sku)
);

create table cart_item(
    item_id int not null auto_increment,
    sku varchar(50),
    cart_id int,
    units int,
    primary key (item_id)
);



create table cart(
    cart_id int not null auto_increment,
    user_id int,
    state varchar(50),
    primary key (cart_id)

);



create table order_details(
    order_id int not null auto_increment,
    user_id int,
    cart_id int,
    payment_type ENUM('On delivery','Card','Paypal'),
    primary key (order_id)
);



create table billing_details(
    bill_id int auto_increment,
    order_id int,
    bill_total numeric(12,2),
    date_time DATETIME,
    payment_state ENUM('Rejected','Accepted','Pending'),
    primary key (bill_id)
);




create table delivery_details(
    delivery_id int not null auto_increment,
    order_id int,
    del_person_id int,
    reg_customer_id int,
    delivery_state ENUM('Delivered','On store','Picked up'),
    location_id int,
    primary key (delivery_id)
);



create table delivery_person(
    del_person_id int,
    name varchar(50),
    contact_number varchar(10) check ( char_length(contact_number)=10),
    primary key (del_person_id)
);

create table user(
    id int not null auto_increment,
    type ENUM('Registered','Guest'),
    primary key (id)
);

create table registered_customer(
    ID int not null auto_increment,
    user_id int,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(60) unique,
    password varchar(50) unique not null,
    primary key (ID)
);


create table mobile(
    mobile_id int not null auto_increment,
    registered_customer_id int,
    mobile_number varchar(10) check ( char_length(mobile_number)=10),
    primary key (mobile_id)
);


create table address(
    location_id int auto_increment,
    is_home_address boolean,
    PO_box varchar(20),
    street varchar(50),
    city_id int,
    zip_code int,
    registered_customer_id int,
    primary key (location_id)
);


create table city(
    city_id int auto_increment,
    city_name varchar(50),
    is_main_city boolean,
    primary key (city_id)
);

create table card_details(
    card_id int auto_increment,
    registered_customer_id int,
    bank varchar(50),
    is_verified boolean,
    primary key (card_id)
);

# foreign Keys
ALTER TABLE subcategory
ADD FOREIGN KEY (cat_id) REFERENCES category(cat_id);
ALTER TABLE belongs
ADD FOREIGN KEY (product_id) REFERENCES product(ID);
ALTER TABLE belongs
ADD FOREIGN KEY (cat_id) REFERENCES category(cat_id);
ALTER TABLE belongs
ADD FOREIGN KEY (sub_cat_id) REFERENCES subcategory(sub_cat_id);
ALTER TABLE variation
ADD FOREIGN KEY (PID) REFERENCES product(ID);
alter table variant_option add column pid int;

ALTER TABLE variant_option
ADD FOREIGN KEY (var_id) REFERENCES variation(var_id);
ALTER TABLE variant_option
ADD FOREIGN KEY (pid) REFERENCES product(id);
ALTER TABLE combination
ADD FOREIGN KEY (sku) REFERENCES stock(sku);
ALTER TABLE combination
ADD FOREIGN KEY (opt_id) REFERENCES variant_option(opt_id);
ALTER TABLE cart_item
ADD FOREIGN KEY (sku) REFERENCES stock(sku);
ALTER TABLE cart_item
ADD FOREIGN KEY (cart_id) REFERENCES cart(cart_id);
ALTER TABLE cart
ADD FOREIGN KEY (user_id) REFERENCES user(id);
ALTER TABLE order_details
ADD FOREIGN KEY (user_id) REFERENCES registered_customer(ID);
ALTER TABLE order_details
ADD FOREIGN KEY (cart_id) REFERENCES cart(cart_id);
ALTER TABLE billing_details
ADD FOREIGN KEY (order_id) REFERENCES order_details(order_id);
ALTER TABLE delivery_details
ADD FOREIGN KEY (order_id) REFERENCES order_details(order_id);
ALTER TABLE delivery_details
ADD FOREIGN KEY (del_person_id) REFERENCES delivery_person(del_person_id);
ALTER TABLE delivery_details
ADD FOREIGN KEY (reg_customer_id) REFERENCES registered_customer(ID);
ALTER TABLE delivery_details
ADD FOREIGN KEY (location_id) REFERENCES address(location_id);
ALTER TABLE registered_customer
ADD FOREIGN KEY (user_id) REFERENCES user(id);
ALTER TABLE mobile
ADD FOREIGN KEY (registered_customer_id) REFERENCES registered_customer(ID);
ALTER TABLE address
ADD FOREIGN KEY (city_id) REFERENCES city(city_id);

ALTER TABLE address
ADD FOREIGN KEY (registered_customer_id) REFERENCES registered_customer(ID);
ALTER TABLE card_details
ADD FOREIGN KEY (registered_customer_id) REFERENCES registered_customer(ID);


# Create view
SELECT * FROM belongs;

INSERT INTO belongs values (1,1,1);
INSERT INTO belongs values (2,1,1);
INSERT INTO belongs values (3,1,1);
INSERT INTO belongs values (4,1,1);

INSERT INTO belongs values (5,3,4);
INSERT INTO belongs values (6,3,5);

INSERT INTO belongs values (7,2,6);
INSERT INTO belongs values (8,2,6);


DELETE from belongs where product_id=5;
DELETE from belongs where product_id=6;



DROP VIEW IF EXISTS prodCat;
create view prodCat as
select p.title,p.base,p.image, s.name,p.ID
from (product p join belongs b on p.ID = b.product_id) join category s on b.cat_id = s.cat_id;