create database hospital_db;

use hospital_db;

CREATE TABLE encounters (
    encounter_id VARCHAR(200) PRIMARY KEY,
    start_time TIMESTAMP,
    stop_time TIMESTAMP,
    patient_id VARCHAR(200),
    organization_id VARCHAR(200),
    payer_id VARCHAR(200),
    encounter_class VARCHAR(100),
    code VARCHAR(50),
    description VARCHAR(500),
    base_encounter_cost DECIMAL(10,2),
    total_claim_cost DECIMAL(10,2),
    payer_coverage DECIMAL(10,2),
    reason_code VARCHAR(50),
    reason_description VARCHAR(500),

    CONSTRAINT fk_patient
        FOREIGN KEY (patient_id)
        REFERENCES patients(patient_id),

    CONSTRAINT fk_org
        FOREIGN KEY (organization_id)
        REFERENCES organizations(organization_id),
        
    CONSTRAINT fk_payer
        FOREIGN KEY (payer_id)
        REFERENCES payers(payer_id)
);

create table organizations (
	organization_id varchar(200) primary key,
    name varchar(200),
    address varchar(100),
    city varchar(50),
    state varchar(50),
    zip varchar(10),
    lat decimal(10, 6),
    lon decimal(10, 6)
);

create table patients (
	patient_id varchar(200) primary key,
    birth_date date,
    death_date date,
    prefix varchar(10),
    first_name varchar(50),
    last_name varchar(50),
    suffix varchar(10),
    maiden_name varchar(50),
    martial_status varchar(50),
    race varchar(50),
    ethnicity varchar(50),
    gender varchar(10),
    birth_place varchar(100),
    address varchar(100),
    city varchar(50),
    state varchar(50),
    country varchar(50),
    patient_zip varchar(10),
    lat decimal(10, 6),
    lon decimal(10, 6)
);

create table payers (
	payer_id varchar(200) primary key,
    payer_name varchar(50),
    address varchar(100),
    city varchar(50),
    state_headquartered varchar(50),
    payer_zip varchar(10),
    phone varchar(50)
);

CREATE TABLE procedures (
    start_time TIMESTAMP,
    stop_time TIMESTAMP,

    patient_id VARCHAR(200),
    encounter_id VARCHAR(200),

    code VARCHAR(50),
    description VARCHAR(500),
    base_cost DECIMAL(10,2),
    reason_code VARCHAR(50),
    reason_description VARCHAR(500),

    CONSTRAINT fk_proc_patient
        FOREIGN KEY (patient_id)
        REFERENCES patients(patient_id),

    CONSTRAINT fk_proc_encounter
        FOREIGN KEY (encounter_id)
        REFERENCES encounters(encounter_id)
);