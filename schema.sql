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
    media_id        int unsigned not null auto_increment primary key,
    media_type      varchar(255),
    media_url       text,
    media_caption   text
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
	approved        tinyint,
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
    approved        tinyint,
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
	approved            tinyint,
    location_lat        text,
    location_lon        text,
    name                text,
    area_name           text,
    area_abbreviation   text,
    date_start          date,
    type                text,
    population_affected int unsigned,
    severity            text,
    funded              enum('yes', 'no'),
    lending_type        enum('none', 'IDA', 'BBDV')
);

--------------------------------------------------------------------------------

-- disaster
insert into disaster
set
    location_lat        = "19.15",
    location_lon        = "-72.29",
    name                = "Haiti",
    area_name           = "Latin America & Caribbean",
    area_abbreviation   = "LAC",
    date_start          = "2010-12-01",
    type                = "hurricane",
    population_affected = "100000",
    severity            = "high",
    funded              = "yes",
    lending_type        = "IDA";

set @disaster_id = last_insert_id();

-- project
insert into project
set
    disaster_id     = @disaster_id,
    name            = "Some project name",
    type            = "Rebuilding Building",
    description     = "This is a rather long description.",
    date_start      = "2010-01-01",
    funded          = "yes",
    lending_type    = "IDA";

set @project_id = last_insert_id();

-- organization 1
insert into organization
set
    name        = "Red Cross",
    type        = "NGO",
    note        = "",
    size        = "Large",
    description = "Something rather nice",
    logo_url    = "http://www.redcross.org/files/site/images/logo.gif",
    qr_url      = "http://www.the2dcode.com/qr-code/120994",
    url         = "http://www.redcross.org";

set @organization_id = last_insert_id();

insert into organization_contact
set
    organization_id = @organization_id,
    contact_type    = "twitter",
    contact_name    = "Juan Muller",
    contact_info    = "http://twitter.com/juancmuller";

insert into organization_project
set
    organization_id = @organization_id,
    project_id      = @project_id,
    feed_url        = "http://twitter.com/favorites/13907922.rss";

-- organization 2
insert into organization
set
    name        = "Red Cross",
    type        = "NGO",
    note        = "",
    size        = "Large",
    description = "Something rather nice",
    logo_url    = "http://www.redcross.org/files/site/images/logo.gif",
    qr_url      = "http://www.the2dcode.com/qr-code/120994",
    url         = "http://www.redcross.org";

set @organization_id = last_insert_id();

insert into organization_contact
set
    organization_id = @organization_id,
    contact_type    = "twitter",
    contact_name    = "Juan Muller",
    contact_info    = "http://twitter.com/juancmuller";

insert into organization_project
set
    organization_id = @organization_id,
    project_id      = @project_id,
    feed_url        = "http://twitter.com/favorites/13907922.rss";

-- media
insert into media
set
    media_type      = "image/jpeg",
    media_url       = "http://www.amigosdeperu.org/STORE/haiti-disaster-2010.jpg",
    media_caption   = "People doing something or other.";

set @media_id = last_insert_id();

insert into media
set
    media_type      = "image/jpeg",
    media_url       = "http://frontiersfoundation.ca/system/files/images/DSC04685.preview.JPG",
    media_caption   = "People doing something or other.";

set @media_id = last_insert_id();

insert into media
set
    media_type      = "image/jpeg",
    media_url       = "http://cdn.necolebitchie.com/wp-content/uploads/2010/01/haiti-disaster-2.jpg",
    media_caption   = "People doing something or other.";

set @media_id = last_insert_id();

insert into media
set
    media_type      = "image/jpeg",
    media_url       = "http://media.komonews.com/images/100117_haiti_disaster.jpg",
    media_caption   = "";

set @media_id = last_insert_id();

insert into media
set
    media_type      = "image/jpeg",
    media_url       = "http://www.about-knowledge.com/wp-content/uploads/2010/01/haiti-disaster-relief.jpg",
    media_caption   = "";

set @media_id = last_insert_id();
