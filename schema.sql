create table user 
	( 
		user_id int unsigned not null auto_increment primary key, 
		email text, 
		password text,
		approved tinyint,
		god tinyint
	);


create table organization
(
    organization_id int unsigned not null auto_increment primary key,
    name text,
    type text,
    note text,
    size text,
    description text,
    logo_url text,
    qr_url text,
    url text
);

create table organization_contact
(
    organization_contact_id int unsigned not null auto_increment primary key,
    organization_id int unsigned,
    contact_type enum('email', 'phone', 'mobile', 'website', 'skype', 'twitter'),
    contact_info text
);

create table project
(
    project_id int unsigned not null auto_increment primary key,
    disaster_id int unsigned not null,
    name text,
    type text,
    description text,
    date_start date,
    date_end date,
    funded enum('yes', 'no'),
    lending_type text
);

create table organization_project
(
    organization_project_id int unsigned not null auto_increment primary key,
    organization_id int unsigned,
    project_id int unsigned,
    feed_url text
);

create table disaster
(
    disaster_id int unsigned not null auto_increment primary key,
    location_lat text,
    location_lon text,
    name text,
    area_name text,
    area_abbreviation text,
    type text,
    population_affected int unsigned,
    severity text,
    lending_type enum('none', 'IDA', 'BBDV')
);
