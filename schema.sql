create table organization
(
    organization_id int unsigned not null auto_increment,
    name text,
    type text,
    note text,
    size text,
    description text,
    qr_url text,
    url text,
);

create table organization_contact
(
    organization_id int unsigned,
    contact_type enum('email', 'phone', 'mobile', 'website', 'skype', 'twitter'),
    contact_info text,
);

create table project
(
    project_id int unsigned not null auto_increment,
    disaster int unsigned not null,
    name text,
    type text,
    description text,
    feed_url text,
    date_start date,
    date_end date,
    funded enum('yes', 'no'),
    lending_type text,
);

create table organization_project
(
    organization_id int unsigned,
    project_id int unsigned,
);

create table disaster
(
    disaster_id int unsigned not null auto_increment,
    location_lat text,
    location_lon text,
    name text,
    area_name text,
    area_abbreviation text,
    type text,
    population_affected int unsigned,
    severity text,
    lending_type enum('none', 'IDA', 'BBDV'),
);
