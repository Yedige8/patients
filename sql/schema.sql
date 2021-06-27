create schema patients;

use patients;

create table patients
(
    patient_id        bigint unsigned auto_increment,
    patient_iin       varchar(12) unique not null,
    patient_full_name varchar(255)       not null,
    patient_address   varchar(255)       not null,
    patient_phone     varchar(20)        not null,
    primary key (patient_id)
);

create table history
(
    history_id       bigint unsigned auto_increment,
    patient_id       bigint unsigned not null,
    specialist       varchar(255)    not null,
    doctor_full_name varchar(255)    not null,
    diagnosis        varchar(255)    not null,
    complaints       text            not null,
    visit_date       date            not null,
    primary key (history_id),
    foreign key (patient_id) references patients (patient_id)
);
