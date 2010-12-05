drop table if exists user;
drop table if exists media;
drop table if exists organization;
drop table if exists organization_media;
drop table if exists organization_contact;
drop table if exists project;
drop table if exists project_media;
drop table if exists organization_project;
drop table if exists organization_project_media;
drop table if exists disaster;

create table media
(
    media_id    int unsigned not null auto_increment primary key,
    media_type  varchar(255),
    media_url   text
);

create table user 
( 
    user_id int unsigned not null auto_increment primary key, 
    organization_id int unsigned,
    email text, 
    password text,
    approved tinyint,
    god tinyint
);

create table organization
(
    organization_id int unsigned not null auto_increment primary key,
	approved tinyint,
    name            text,
    type            text,
    note            text,
    size            text,
    description     text,
    logo_url        text,
    qr_url          text,
    url             text
);

create table organization_media
(
    organization_media_id int unsigned not null auto_increment primary key,
    organization_id int unsigned,
    media_id        int unsigned
);

create table organization_contact
(
    organization_contact_id int unsigned not null auto_increment primary key,
    organization_id int unsigned,
    contact_type enum('email', 'phone', 'mobile', 'website', 'skype', 'twitter'),
    contact_info text,
	contact_name text
);

create table project
(
    project_id      int unsigned not null auto_increment primary key,
	approved tinyint,
    disaster_id     int unsigned not null,
    name            text,
    type            text,
    description     text,
    date_start      date,
    date_end        date,
    funded          enum('yes', 'no'),
    lending_type    text
);

create table project_media
(
    project_media_id      int unsigned not null auto_increment primary key,
    project_id  int unsigned,
    media_id    int unsigned
);

create table organization_project
(
    organization_project_id int unsigned not null auto_increment primary key,
    organization_id         int unsigned,
    project_id              int unsigned,
    feed_url                text
);

create table organization_project_media
(
    organization_project_media_id int unsigned not null auto_increment primary key,
    organization_project_id int unsigned,
    media_id                int unsigned
);

create table disaster
(
    disaster_id         int unsigned not null auto_increment primary key,
	approved tinyint,
    location_lat        text,
    location_lon        text,
    name                text,
    area_name           text,
    area_abbreviation   text,
    type                text,
    population_affected int unsigned,
    severity            text,
    lending_type        enum('none', 'IDA', 'BBDV')
);
