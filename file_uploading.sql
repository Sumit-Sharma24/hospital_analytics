set global local_infile = 1;
SHOW VARIABLES LIKE 'local_infile';

load data local infile 'D:/Hospital+Patient+Records/encounters.csv'
into table encounters
fields terminated by ','
ignore 1 rows
(encounter_id, @date1, @date2, patient_id, organization_id, payer_id, encounter_class, code, description, base_encounter_cost,
total_claim_cost, payer_coverage, @reason_code, reason_description)
set
start_time = str_to_date(@date1, '%Y-%m-%dT%H:%i:%sZ'),
stop_time = str_to_date(@date2, '%Y-%m-%dT%H:%i:%sZ'),
reason_code = NULLIF(@reason_code, '');

select * from encounters;

LOAD DATA LOCAL INFILE 'D:/Hospital+Patient+Records/organizations.csv'
INTO TABLE organizations
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'D:/Hospital+Patient+Records/patients.csv'
INTO TABLE patients
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
IGNORE 1 ROWS
(
patient_id,
@birth_date,
@death_date,
prefix,
first_name,
last_name,
suffix,
maiden_name,
martial_status,
race,
ethnicity,
gender,
birth_place,
address,
city,
state,
country,
patient_zip,
@lat,
@lon
)
SET
birth_date = NULLIF(@birth_date, ''),
death_date = NULLIF(@death_date, ''),
lat = CAST(TRIM(@lat) AS DECIMAL(10,6)),
lon = CAST(TRIM(@lon) AS DECIMAL(10,6));

LOAD DATA LOCAL INFILE 'D:/Hospital+Patient+Records/payers.csv'
INTO TABLE payers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
IGNORE 1 ROWS
(
payer_id,
payer_name,
address,
city,
state_headquartered,
payer_zip,
phone
);

LOAD DATA LOCAL INFILE 'D:/Hospital+Patient+Records/procedures.csv'
INTO TABLE procedures
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
IGNORE 1 ROWS
(
@start_time,
@stop_time,
patient_id,
encounter_id,
code,
description,
base_cost,
@reason_code,
reason_description
)
SET
start_time = STR_TO_DATE(@start_time, '%Y-%m-%dT%H:%i:%sZ'),
stop_time  = STR_TO_DATE(@stop_time, '%Y-%m-%dT%H:%i:%sZ'),
reason_code = NULLIF(@reason_code, '');