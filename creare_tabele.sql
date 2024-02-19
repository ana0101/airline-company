create table modele_avioane (
id_model number(4),
nume_model varchar2(30),
nr_locuri number(4) constraint null_nr_locuri not null,
constraint pk_modele_avioane primary key(id_model));


create table avioane (
id_avion number(4),
data_achizitionare date default sysdate,
id_model number(4) constraint null_id_model_avion not null,
constraint pk_avioane primary key(id_avion),
constraint fk_avioane_model_avion foreign key(id_model) references modele_avioane(id_model));


create table tari (
id_tara number(4),
nume varchar2(30),
constraint pk_tari primary key(id_tara),
constraint unq_nume_tari unique(nume));


create table orase (
id_oras number(4),
nume varchar2(30),
id_tara number(4) constraint null_tara not null,
constraint pk_orase primary key(id_oras),
constraint fk_orase_tara foreign key(id_tara) references tari(id_tara));


create table aeroporturi (
id_aeroport number(4),
nume varchar2(30),
id_oras number(4) constraint null_oras not null,
constraint pk_aeroporturi primary key(id_aeroport),
constraint fk_aeroporturi_oras foreign key(id_oras) references orase(id_oras));


create table zboruri (
id_zbor number(4),
data_plecare date,
data_sosire date,
id_avion number(4) constraint null_avion not null,
id_aeroport_plecare number(4) constraint null_plecare not null,
id_aeroport_sosire number(4) constraint null_sosire not null,
constraint pk_zboruri primary key(id_zbor),
constraint fk_zboruri_avion foreign key(id_avion) references avioane(id_avion),
constraint fk_zboruri_plecare foreign key(id_aeroport_plecare) references aeroporturi(id_aeroport),
constraint fk_zboruri_sosire foreign key(id_aeroport_sosire) references aeroporturi(id_aeroport));


create table piloti (
id_pilot number(4),
nume varchar2(30) constraint null_nume_pilot not null,
prenume varchar2(30),
grad varchar2(30),
constraint pk_piloti primary key(id_pilot));


create table insotitori (
id_insotitor number(4),
nume varchar2(30) constraint null_nume_insotitor not null,
prenume varchar2(30),
constraint pk_insotitori primary key(id_insotitor));


create table echipaje_piloti (
id_zbor number(4),
id_pilot number(4),
constraint pk_echipaj_piloti primary key(id_zbor, id_pilot),
constraint fk_echipaj_piloti_zbor foreign key(id_zbor) references zboruri(id_zbor),
constraint fk_echipaj_piloti_pilot foreign key(id_pilot) references piloti(id_pilot));


create table echipaje_insotitori (
id_zbor number(4),
id_insotitor number(4),
constraint pk_echipaj_insotitori primary key(id_zbor, id_insotitor),
constraint fk_echipaj_insotitori_zbor foreign key(id_zbor) references zboruri(id_zbor),
constraint fk_echipaj_insotitori_insotitor foreign key(id_insotitor) references insotitori(id_insotitor));


create table clase (
id_clasa number(4),
nume varchar2(30),
constraint pk_clase primary key(id_clasa),
constraint unq_nume_clase unique(nume));


create table locuri (
id_loc number(4),
id_zbor number(4),
pret number(8,2) constraint null_pret not null,
id_clasa number(4) constraint null_clasa not null,
constraint pk_locuri primary key(id_loc, id_zbor),
constraint fk_locuri_zbor foreign key(id_zbor) references zboruri(id_zbor),
constraint fk_locuri_clasa foreign key(id_clasa) references clase(id_clasa));


create table pasageri (
id_pasager number(4),
numar_id varchar2(20) constraint null_nr_id_pasageri not null,
nume varchar2(30) constraint null_nume_pasageri not null,
prenume varchar2(30),
cetatenie varchar2(30) constraint null_cetatenie not null,
data_nastere date,
restrictie_meniu varchar2(30),
constraint pk_pasageri primary key(id_pasager));


create table clienti (
id_client number(4),
constraint pk_clienti primary key(id_client));


create table persoane_fizice (
id_persoana number(4),
numar_id varchar2(30) constraint null_nr_id_pers not null,
nume varchar2(30) constraint null_nume_pers not null,
prenume varchar2(30),
email varchar2(30),
constraint pk_pers primary key(id_persoana),
constraint fk_pers foreign key(id_persoana) references clienti(id_client));


create table agentii_turism (
id_agentie number(4),
nume varchar2(30),
constraint pk_agentii_turism primary key(id_agentie),
constraint fk_agentii_turism foreign key(id_agentie) references clienti(id_client));


create table reprezentanti_vanzari (
id_reprezentant number(4),
nume varchar2(30) constraint null_nume_reprez not null,
prenume varchar2(30),
constraint pk_reprez primary key(id_reprezentant),
constraint fk_reprez foreign key(id_reprezentant) references clienti(id_client));


create table rezervari (
id_rezervare number(4),
id_loc number(4) constraint null_loc not null,
id_zbor number(4) constraint null_zbor not null,
id_pasager number(4) constraint null_pasager not null,
id_client number(4) constraint null_client not null,
data_rezervare date default sysdate constraint null_data not null,
constraint pk_rezervari primary key(id_rezervare),
constraint fk_rezervari_loc_zbor foreign key(id_loc, id_zbor) references locuri(id_loc, id_zbor),
constraint unq_loc_zbor unique(id_loc, id_zbor),
constraint fk_rezervari_pasager foreign key(id_pasager) references pasageri(id_pasager),
constraint fk_rezervari_client foreign key(id_client) references clienti(id_client));


create table plati (
id_plata number(4),
id_rezervare number(4) constraint null_rez not null,
tip_plata varchar2(30),
constraint pk_plati primary key(id_plata),
constraint fk_plati foreign key(id_rezervare) references rezervari(id_rezervare),
constraint unq_rez unique(id_rezervare));


create table check_in (
id_check_in number(4),
id_rezervare number(4) constraint null_rez1 not null,
data_check_in date constraint null_data_check not null,
constraint pk_check_in primary key(id_check_in),
constraint fk_check_in foreign key(id_rezervare) references rezervari(id_rezervare),
constraint unq_rez1 unique(id_rezervare));


create table bagaje (
id_bagaj number(4),
id_check_in number(4) constraint null_check_in not null,
greutate number(5, 2) constraint null_greutate not null,
constraint pk_bagaje primary key(id_bagaj),
constraint fk_bagaje foreign key(id_check_in) references check_in(id_check_in));

