--- Create database
create database if not exists mydb;

-- use the database
use mydb;

-- Create table
create table if not exists countries (
    id int auto_increment primary key, 
    country varchar(255), 
    capital varchar(255), 
    leader varchar(255)
);

-- Insert data
insert into countries (country, capital, leader) values ("Kenya", "Nairobi", "William Ruto");
insert into countries (country, capital, leader) values ("Tanzania", "Dodoma", "Samia Suluhu");
insert into countries (country, capital, leader) values ("Uganda", "Kampala", "Yoweri Museveni");
insert into countries (country, capital, leader) values ("Australia", "Canberra", "Anthony Albanese");
insert into countries (country, capital, leader) values ("USA", "Washington", "Joe Biden");
insert into countries (country, capital, leader) values ("South Africa", "Pretoria", "Cyril Ramaphosa");

-- Create remote user
-- There has to be a more secure way to do this!..Right?
create user 'panther'@'%' identified by 'panther2024';

-- Grant all privileges to the user
grant all privileges on *.* to 'panther'@'%'; 

-- check user created : > SELECT User, Host FROM mysql.user;

-- Flush privileges to apply the changes
flush privileges;