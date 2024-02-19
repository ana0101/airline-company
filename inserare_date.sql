-- modele avioane --
create sequence secv_modele_avioane
start with 1
increment by 1
minvalue 0
maxvalue 100
nocycle
nocache;

insert into modele_avioane
values (secv_modele_avioane.nextval, 'Boeing 777', 12);
insert into modele_avioane
values (secv_modele_avioane.nextval, 'Airbus A340', 15);
insert into modele_avioane
values (secv_modele_avioane.nextval, 'Airbus A380', 20);
insert into modele_avioane
values (secv_modele_avioane.nextval, 'Boeing 757', 15);
insert into modele_avioane
values (secv_modele_avioane.nextval, 'Airbus A318', 12);
insert into modele_avioane
values (secv_modele_avioane.nextval, 'Airbus A320', 10);

select * from modele_avioane;


-- avioane --
create sequence secv_avioane
start with 0
increment by 1
minvalue 0
maxvalue 99
nocycle
nocache;

insert into avioane
values (secv_avioane.nextval, '08-jan-19', 3); 
insert into avioane
values (secv_avioane.nextval, '12-mar-15', 0); 
insert into avioane
values (secv_avioane.nextval, '20-jun-16', 3); 
insert into avioane
values (secv_avioane.nextval, '04-oct-16', 4); 
insert into avioane
values (secv_avioane.nextval, '14-mar-18', 1); 

select * from avioane;


-- tari --
insert into tari
values (0, 'Romania');
insert into tari
values (1, 'Germania');
insert into tari
values (2, 'Italia');
insert into tari
values (3, 'Norvegia');
insert into tari
values (4, 'Franta');

select * from tari;


-- orase --
insert into orase
values (0, 'Bucuresti', 0);
insert into orase
values (1, 'Cluj-Napoca', 0);
insert into orase
values (2, 'Frankfurt', 1);
insert into orase
values (3, 'Munich', 1);
insert into orase
values (4, 'Trondheim', 3);

select * from orase;


-- aeroporturi --
create sequence secv_aeroporturi
start with 0
increment by 1
minvalue 0
maxvalue 99
nocycle
nocache;

insert into aeroporturi 
values (secv_aeroporturi.nextval, 'Henri Coanda', 0);
insert into aeroporturi 
values (secv_aeroporturi.nextval, 'Aurel Vlaicu', 0);
insert into aeroporturi 
values (secv_aeroporturi.nextval, 'Avram Iancu', 1);
insert into aeroporturi 
values (secv_aeroporturi.nextval, null, 2);
insert into aeroporturi 
values (secv_aeroporturi.nextval, null, 3);

select * from aeroporturi;


-- zboruri --
create sequence secv_zboruri
start with 0
increment by 1
minvalue 0
maxvalue 99
nocycle
nocache;

insert into zboruri
values (secv_zboruri.nextval, to_date('2019-oct-12 15:30', 'yyyy-mon-dd hh24:mi'), to_date('2019-oct-12 17:30', 'yyyy-mon-dd hh24:mi'), 1, 0, 3);
insert into zboruri
values (secv_zboruri.nextval, to_date('2019-dec-16 14:40', 'yyyy-mon-dd hh24:mi'), to_date('2019-dec-16 15:20', 'yyyy-mon-dd hh24:mi'), 0, 1, 2);
insert into zboruri
values (secv_zboruri.nextval, to_date('2020-feb-23 10:30', 'yyyy-mon-dd hh24:mi'), to_date('2020-feb-23 12:15', 'yyyy-mon-dd hh24:mi'), 2, 4, 2);
insert into zboruri
values (secv_zboruri.nextval, to_date('2020-apr-5 20:00', 'yyyy-mon-dd hh24:mi'), to_date('2020-apr-5 21:30', 'yyyy-mon-dd hh24:mi'), 3, 2, 0);
insert into zboruri
values (secv_zboruri.nextval, to_date('2021-jun-11 18:20', 'yyyy-mon-dd hh24:mi'), to_date('2021-jun-11 20:00', 'yyyy-mon-dd hh24:mi'), 4, 3, 1);

select * from zboruri;


-- piloti --
create sequence secv_piloti
start with 0
increment by 1
minvalue 0
maxvalue 99
nocycle
nocache;

insert into piloti
values (secv_piloti.nextval, 'Albescu', 'Delia', 'pilot'); 
insert into piloti
values (secv_piloti.nextval, 'Lupei', 'Dan', 'pilot'); 
insert into piloti
values (secv_piloti.nextval, 'Albert', 'Andrei', 'copilot');
insert into piloti
values (secv_piloti.nextval, 'Grigorescu', 'Natalia', 'copilot');
insert into piloti
values (secv_piloti.nextval, 'Balan', 'Violeta', 'copilot');
insert into piloti
values (secv_piloti.nextval, 'Popescu', 'Luca', 'pilot');

select * from piloti;


-- insotitori --
create sequence secv_insotitori
start with 0
increment by 1
minvalue 0
maxvalue 99
nocycle
nocache;

insert into insotitori
values (secv_insotitori.nextval, 'Vasile', 'Livia');
insert into insotitori
values (secv_insotitori.nextval, 'Solomon', 'Isabella');
insert into insotitori
values (secv_insotitori.nextval, 'Popescu', 'Ruxandra');
insert into insotitori
values (secv_insotitori.nextval, 'Ciobanu', 'Simon');
insert into insotitori
values (secv_insotitori.nextval, 'Constantin', 'Rares');
insert into insotitori
values (secv_insotitori.nextval, 'Ianos', 'Matei');

select * from insotitori;


-- echipaje_piloti --
insert into echipaje_piloti
values (0, 0); 
insert into echipaje_piloti
values (0, 2); 
insert into echipaje_piloti
values (1, 1); 
insert into echipaje_piloti
values (1, 2); 
insert into echipaje_piloti
values (2, 1); 
insert into echipaje_piloti
values (2, 3); 
insert into echipaje_piloti
values (3, 0); 
insert into echipaje_piloti
values (3, 4); 
insert into echipaje_piloti
values (4, 0); 
insert into echipaje_piloti
values (4, 3); 
insert into echipaje_piloti
values (4, 1);

select * from echipaje_piloti;


-- echipaje_insotitori --
insert into echipaje_insotitori
values (0, 0);
insert into echipaje_insotitori
values (1, 2);
insert into echipaje_insotitori
values (1, 3);
insert into echipaje_insotitori
values (1, 0);
insert into echipaje_insotitori
values (2, 4);
insert into echipaje_insotitori
values (2, 5);
insert into echipaje_insotitori
values (3, 1);
insert into echipaje_insotitori
values (3, 2);
insert into echipaje_insotitori
values (4, 0);
insert into echipaje_insotitori
values (4, 2);
insert into echipaje_insotitori
values (4, 4);

select * from echipaje_insotitori;


-- clase --
insert into clase
values (0, 'economy');
insert into clase
values (1, 'business');
insert into clase
values (2, 'intai');

select * from clase;


-- locuri --
-- zbor 0 - avion 1 - tip avion 0 - 10 locuri
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (0, 40, 0, 0);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (1, 40, 0, 0);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (2, 50, 0, 0);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (3, 50, 0, 0);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (4, 50, 0, 0);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (5, 100, 1, 0);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (6, 100, 1, 0);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (7, 100, 1, 0);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (8, 110, 1, 0);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (9, 110, 1, 0);
-- zbor 1 - avion 0 - tip avion 3 - 12 locuri
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (0, 40, 0, 1);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (1, 40, 0, 1);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (2, 40, 0, 1);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (3, 40, 0, 1);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (4, 45, 0, 1);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (5, 45, 0, 1);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (6, 90, 1, 1);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (7, 90, 1, 1);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (8, 95, 1, 1);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (9, 95, 1, 1);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (10, 200, 2, 1);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (11, 200, 2, 1);
-- zbor 2 - avion 2 - tip avion 3 - 12 locuri
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (0, 60, 0, 2);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (1, 60, 0, 2);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (2, 60, 0, 2);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (3, 60, 0, 2);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (4, 70, 0, 2);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (5, 70, 0, 2);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (6, 180, 1, 2);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (7, 180, 1, 2);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (8, 180, 1, 2);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (9, 190, 1, 2);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (10, 350, 2, 2);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (11, 360, 2, 2);
-- zbor 3 - avion 3 - tip avion 4 - 15 locuri
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (0, 35, 0, 3);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (1, 35, 0, 3);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (2, 35, 0, 3);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (3, 35, 0, 3);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (4, 35, 0, 3);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (5, 40, 0, 3);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (6, 40, 0, 3);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (7, 40, 0, 3);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (8, 70, 1, 3);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (9, 70, 1, 3);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (10, 70, 1, 3);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (11, 80, 1, 3);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (12, 180, 2, 3);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (13, 180, 2, 3);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (14, 190, 2, 3);
-- zbor 4 - avion 4 - tip avion 1 - 20 locuri
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (0, 40, 0, 4);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (1, 40, 0, 4);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (2, 40, 0, 4);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (3, 40, 0, 4);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (4, 40, 0, 4);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (5, 40, 0, 4);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (6, 40, 0, 4);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (7, 45, 0, 4);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (8, 45, 0, 4);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (9, 45, 0, 4);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (10, 100, 1, 4);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (11, 100, 1, 4);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (12, 100, 1, 4);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (13, 110, 1, 4);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (14, 110, 1, 4);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (15, 300, 2, 4);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (16, 300, 2, 4);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (17, 300, 2, 4);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (18, 320, 2, 4);
insert into locuri(id_loc, pret, id_clasa, id_zbor)
values (19, 320, 2, 4);

select * from locuri;


-- pasageri --
insert into pasageri
values (0, '2940619092726', 'Cojocaru', 'Bianca', 'Romania', '19-jun-1994', null); 
insert into pasageri
values (1, '2911119199676', 'Petrescu', 'Mihaela', 'Romania', '19-nov-1991', null); 
insert into pasageri
values (2, '6040302227314', 'Avram', 'Emma', 'Romania', '02-mar-2004', 'vegetarian'); 
insert into pasageri
values (3, '6030321346602', 'Marin', 'Laura', 'Romania', '21-mar-2003', null); 
insert into pasageri
values (4, '1951017453233', 'Dumitru', 'Mihai', 'Romania', '17-oct-1995', 'diabet'); 
insert into pasageri
values (5, '1940706334322', 'Neagu', 'Teodor', 'Romania', '06-jul-1994', null); 
insert into pasageri
values (6, '5030309072901', 'Aliu', 'Matei', 'Romania', '09-mar-2003', null); 
insert into pasageri
values (7, '5959JJNLC2', 'Rosenberger', 'Ivonne', 'Germania', '11-apr-1992', null); 
insert into pasageri
values (8, '1327M3YY51', 'Kuntz', 'Hilbert', 'Germania', '23-oct-1992', null); 
insert into pasageri
values (9, 'F8624KW3J6', 'Leitz', 'Josef', 'Germania', '01-aug-2005', 'vegetarian'); 
insert into pasageri
values (10, 'GE3082692', 'Trevisani', 'Damiana', 'Italia', '02-jan-1981', null); 
insert into pasageri
values (11, 'OY37373564', 'Milani', 'Uranio', 'Italia', '30-nov-1996', null); 
insert into pasageri
values (12, '6000130251658', 'Pop', 'Viorela', 'Romania', '30-jan-2000', null);
insert into pasageri
values (13, '1920202339852', 'Petrescu', 'Petre', 'Romania', '02-feb-1992', 'diabet');
insert into pasageri
values (14, '5010321063853', 'Ionescu', 'Ion', 'Romania', '21-mar-2001', null);
insert into pasageri
values (15, '2961126231259', 'Popescu', 'Sara', 'Romania', '26-nov-1996', null);

select * from pasageri;


-- clienti --
create sequence secv_clienti
start with 0
increment by 1
minvalue 0
maxvalue 99
nocycle
nocache;

insert into clienti
values (secv_clienti.nextval);
insert into clienti
values (secv_clienti.nextval);
insert into clienti
values (secv_clienti.nextval);
insert into clienti
values (secv_clienti.nextval);
insert into clienti
values (secv_clienti.nextval);
insert into clienti
values (secv_clienti.nextval);
insert into clienti
values (secv_clienti.nextval);
insert into clienti
values (secv_clienti.nextval);
insert into clienti
values (secv_clienti.nextval);
insert into clienti
values (secv_clienti.nextval);
insert into clienti
values (secv_clienti.nextval);
insert into clienti
values (secv_clienti.nextval);
insert into clienti
values (secv_clienti.nextval);
insert into clienti
values (secv_clienti.nextval);
insert into clienti
values (secv_clienti.nextval);

select * from clienti;


-- persoane fizice --
insert into persoane_fizice
values (0, '6000130251658', 'Pop', 'Viorela', 'pop.viorela@gmail.com');
insert into persoane_fizice
values (1, '1920202339852', 'Petrescu', 'Petre', 'petrescu.petre@gmail.com');
insert into persoane_fizice
values (2, '5010321063853', 'Ionescu', 'Ion', 'ionescu.ion@gmail.com');
insert into persoane_fizice
values (3, '2961126231259', 'Popescu', 'Sara', 'popescu.sara@gmail.com');
insert into persoane_fizice
values (7, '2940619092726', 'Cojocaru', 'Bianca', 'cojocaru.bianca@gmail.com'); 
insert into persoane_fizice
values (8, '2911119199676', 'Petrescu', 'Mihaela', 'petrescu.mihaela@gmail.com'); 
insert into persoane_fizice
values (9, '6040302227314', 'Avram', 'Emma', 'avram.emma@gmail.com'); 
insert into persoane_fizice
values (10, '6030321346602', 'Marin', 'Laura', 'marin.laura@gmail.com'); 
insert into persoane_fizice
values (11, '1951017453233', 'Dumitru', 'Mihai', 'dumitru.mihai@gmail.com'); 
insert into persoane_fizice
values (12, '5959JJNLC2', 'Rosenberger', 'Ivonne', 'rosenberger.ivonne@gmail.com'); 
insert into persoane_fizice
values (13, 'F8624KW3J6', 'Leitz', 'Josef', 'leitz.josef@gmail.com'); 
insert into persoane_fizice
values (14, 'GE3082692', 'Trevisani', 'Damiana', 'trevisani.damiana@gmail.com'); 

select * from persoane_fizice;


-- agentii turism --
insert into agentii_turism
values (4, 'Sunny Travel');
insert into agentii_turism
values (5, 'Dream Travel');

select * from agentii_turism;


-- reprezentanti vanzari --
insert into reprezentanti_vanzari
values (6, 'Stan', 'Carmen');

select * from reprezentanti_vanzari;


-- rezervari --
-- zbor 0
insert into rezervari(id_rezervare, data_rezervare, id_loc, id_zbor, id_pasager, id_client)
values (0, to_date('2019-oct-05 15:00', 'yyyy-mon-dd hh24:mi'), 3, 0, 15, 3); 
insert into rezervari(id_rezervare, data_rezervare, id_loc, id_zbor, id_pasager, id_client)
values (1, to_date('2019-sep-12 10:40', 'yyyy-mon-dd hh24:mi'), 5, 0, 14, 2); 
insert into rezervari(id_rezervare, data_rezervare, id_loc, id_zbor, id_pasager, id_client)
values (2, to_date('2019-aug-03 19:50', 'yyyy-mon-dd hh24:mi'), 9, 0, 13, 1); 
insert into rezervari(id_rezervare, data_rezervare, id_loc, id_zbor, id_pasager, id_client)
values (3, to_date('2019-oct-10 23:20', 'yyyy-mon-dd hh24:mi'), 2, 0, 12, 0); 
insert into rezervari(id_rezervare, data_rezervare, id_loc, id_zbor, id_pasager, id_client)
values (4, to_date('2019-sep-24 04:10', 'yyyy-mon-dd hh24:mi'), 4, 0, 10, 4); 
-- zbor 1
insert into rezervari(id_rezervare, data_rezervare, id_loc, id_zbor, id_pasager, id_client)
values (5, to_date('2019-dec-15 04:10', 'yyyy-mon-dd hh24:mi'), 0, 1, 0, 0);
insert into rezervari(id_rezervare, data_rezervare, id_loc, id_zbor, id_pasager, id_client)
values (6, to_date('2019-dec-15 05:00', 'yyyy-mon-dd hh24:mi'), 2, 1, 9, 5); 
insert into rezervari(id_rezervare, data_rezervare, id_loc, id_zbor, id_pasager, id_client)
values (7, to_date('2019-dec-02 05:00', 'yyyy-mon-dd hh24:mi'), 3, 1, 10, 5);
insert into rezervari(id_rezervare, data_rezervare, id_loc, id_zbor, id_pasager, id_client)
values (8, to_date('2019-dec-02 05:00', 'yyyy-mon-dd hh24:mi'), 5, 1, 4, 5);
insert into rezervari(id_rezervare, data_rezervare, id_loc, id_zbor, id_pasager, id_client)
values (9, to_date('2019-nov-06 23:50', 'yyyy-mon-dd hh24:mi'), 11, 1, 4, 11);
insert into rezervari(id_rezervare, data_rezervare, id_loc, id_zbor, id_pasager, id_client)
values (10, to_date('2019-nov-02 14:00', 'yyyy-mon-dd hh24:mi'), 7, 1, 2, 6);
-- zbor 2
insert into rezervari(id_rezervare, data_rezervare, id_loc, id_zbor, id_pasager, id_client)
values (11, to_date('2020-feb-23 01:00', 'yyyy-mon-dd hh24:mi'), 0, 2, 1, 6);
insert into rezervari(id_rezervare, data_rezervare, id_loc, id_zbor, id_pasager, id_client)
values (12, to_date('2020-jan-20 04:00', 'yyyy-mon-dd hh24:mi'), 8, 2, 3, 6);
insert into rezervari(id_rezervare, data_rezervare, id_loc, id_zbor, id_pasager, id_client)
values (13, to_date('2020-jan-04 20:00', 'yyyy-mon-dd hh24:mi'), 11, 2, 6, 5);
insert into rezervari(id_rezervare, data_rezervare, id_loc, id_zbor, id_pasager, id_client)
values (14, to_date('2020-jan-04 20:00', 'yyyy-mon-dd hh24:mi'), 10, 2, 5, 5);
-- zbor 3
insert into rezervari(id_rezervare, data_rezervare, id_loc, id_zbor, id_pasager, id_client)
values (15, to_date('2020-apr-01 20:00', 'yyyy-mon-dd hh24:mi'), 9, 3, 11, 14);
insert into rezervari(id_rezervare, data_rezervare, id_loc, id_zbor, id_pasager, id_client)
values (16, to_date('2020-apr-01 20:20', 'yyyy-mon-dd hh24:mi'), 10, 3, 12, 14);
insert into rezervari(id_rezervare, data_rezervare, id_loc, id_zbor, id_pasager, id_client)
values (17, to_date('2020-apr-01 20:00', 'yyyy-mon-dd hh24:mi'), 3, 3, 2, 9);
insert into rezervari(id_rezervare, data_rezervare, id_loc, id_zbor, id_pasager, id_client)
values (18, to_date('2020-feb-20 15:00', 'yyyy-mon-dd hh24:mi'), 5, 3, 3, 10);
insert into rezervari(id_rezervare, data_rezervare, id_loc, id_zbor, id_pasager, id_client)
values (19, to_date('2020-mar-12 16:00', 'yyyy-mon-dd hh24:mi'), 12, 3, 7, 12);
insert into rezervari(id_rezervare, data_rezervare, id_loc, id_zbor, id_pasager, id_client)
values (20, to_date('2020-mar-12 18:00', 'yyyy-mon-dd hh24:mi'), 13, 3, 8, 12);
insert into rezervari(id_rezervare, data_rezervare, id_loc, id_zbor, id_pasager, id_client)
values (21, to_date('2020-feb-14 21:00', 'yyyy-mon-dd hh24:mi'), 7, 3, 0, 7);
-- zbor 4
insert into rezervari(id_rezervare, data_rezervare, id_loc, id_zbor, id_pasager, id_client)
values (22, to_date('2021-jun-11 00:00', 'yyyy-mon-dd hh24:mi'), 5, 4, 6, 0);
insert into rezervari(id_rezervare, data_rezervare, id_loc, id_zbor, id_pasager, id_client)
values (23, to_date('2021-apr-20 16:00', 'yyyy-mon-dd hh24:mi'), 10, 4, 5, 5);
insert into rezervari(id_rezervare, data_rezervare, id_loc, id_zbor, id_pasager, id_client)
values (24, to_date('2021-apr-20 16:30', 'yyyy-mon-dd hh24:mi'), 11, 4, 7, 5);
insert into rezervari(id_rezervare, data_rezervare, id_loc, id_zbor, id_pasager, id_client)
values (25, to_date('2021-apr-20 18:00', 'yyyy-mon-dd hh24:mi'), 12, 4, 8, 5);
insert into rezervari(id_rezervare, data_rezervare, id_loc, id_zbor, id_pasager, id_client)
values (26, to_date('2021-may-03 12:00', 'yyyy-mon-dd hh24:mi'), 3, 4, 14, 4);
insert into rezervari(id_rezervare, data_rezervare, id_loc, id_zbor, id_pasager, id_client)
values (27, to_date('2021-may-03 13:00', 'yyyy-mon-dd hh24:mi'), 4, 4, 15, 4);
insert into rezervari(id_rezervare, data_rezervare, id_loc, id_zbor, id_pasager, id_client)
values (28, to_date('2021-jun-10 11:00', 'yyyy-mon-dd hh24:mi'), 2, 4, 12, 6);
insert into rezervari(id_rezervare, data_rezervare, id_loc, id_zbor, id_pasager, id_client)
values (29, to_date('2021-mar-25 19:00', 'yyyy-mon-dd hh24:mi'), 18, 4, 11, 13);
insert into rezervari(id_rezervare, data_rezervare, id_loc, id_zbor, id_pasager, id_client)
values (30, to_date('2021-mar-10 13:00', 'yyyy-mon-dd hh24:mi'), 17, 4, 1, 8);

select * from rezervari;


-- plati --
create sequence secv_plati
start with 0
increment by 1
minvalue 0
maxvalue 99
nocycle
nocache;

insert into plati(id_plata, tip_plata, id_rezervare)
values (secv_plati.nextval, 'online', 0);
insert into plati(id_plata, tip_plata, id_rezervare)
values (secv_plati.nextval, 'online', 1);
insert into plati(id_plata, tip_plata, id_rezervare)
values (secv_plati.nextval, 'transfer bancar', 2);
insert into plati(id_plata, tip_plata, id_rezervare)
values (secv_plati.nextval, 'online', 3);
insert into plati(id_plata, tip_plata, id_rezervare)
values (secv_plati.nextval, 'online', 4);
insert into plati(id_plata, tip_plata, id_rezervare)
values (secv_plati.nextval, 'online', 5);
insert into plati(id_plata, tip_plata, id_rezervare)
values (secv_plati.nextval, 'online', 6);
insert into plati(id_plata, tip_plata, id_rezervare)
values (secv_plati.nextval, 'online', 7);
insert into plati(id_plata, tip_plata, id_rezervare)
values (secv_plati.nextval, 'transfer bancar', 8);
insert into plati(id_plata, tip_plata, id_rezervare)
values (secv_plati.nextval, 'transfer bancar', 9);
insert into plati(id_plata, tip_plata, id_rezervare)
values (secv_plati.nextval, 'transfer bancar', 10);
insert into plati(id_plata, tip_plata, id_rezervare)
values (secv_plati.nextval, 'transfer bancar', 11);
insert into plati(id_plata, tip_plata, id_rezervare)
values (secv_plati.nextval, 'online', 12);
insert into plati(id_plata, tip_plata, id_rezervare)
values (secv_plati.nextval, 'online', 13);
insert into plati(id_plata, tip_plata, id_rezervare)
values (secv_plati.nextval, 'online', 14);
insert into plati(id_plata, tip_plata, id_rezervare)
values (secv_plati.nextval, 'online', 15);
insert into plati(id_plata, tip_plata, id_rezervare)
values (secv_plati.nextval, 'online', 16);
insert into plati(id_plata, tip_plata, id_rezervare)
values (secv_plati.nextval, 'online', 17);
insert into plati(id_plata, tip_plata, id_rezervare)
values (secv_plati.nextval, 'online', 18);
insert into plati(id_plata, tip_plata, id_rezervare)
values (secv_plati.nextval, 'online', 19);
insert into plati(id_plata, tip_plata, id_rezervare)
values (secv_plati.nextval, 'transfer bancar', 20);
insert into plati(id_plata, tip_plata, id_rezervare)
values (secv_plati.nextval, 'transfer bancar', 21);
insert into plati(id_plata, tip_plata, id_rezervare)
values (secv_plati.nextval, 'transfer bancar', 22);
insert into plati(id_plata, tip_plata, id_rezervare)
values (secv_plati.nextval, 'online', 23);
insert into plati(id_plata, tip_plata, id_rezervare)
values (secv_plati.nextval, 'online', 24);
insert into plati(id_plata, tip_plata, id_rezervare)
values (secv_plati.nextval, 'online', 25);
insert into plati(id_plata, tip_plata, id_rezervare)
values (secv_plati.nextval, 'online', 26);
insert into plati(id_plata, tip_plata, id_rezervare)
values (secv_plati.nextval, 'online', 27);
insert into plati(id_plata, tip_plata, id_rezervare)
values (secv_plati.nextval, 'online', 28);
insert into plati(id_plata, tip_plata, id_rezervare)
values (secv_plati.nextval, 'online', 29);
insert into plati(id_plata, tip_plata, id_rezervare)
values (secv_plati.nextval, 'online', 30);

select * from plati;


-- check_in --
create sequence secv_check
start with 0
increment by 1
minvalue 0
maxvalue 99
nocycle
nocache;

-- zbor 0
insert into check_in(id_check_in, data_check_in, id_rezervare)
values (secv_check.nextval, to_date('2019-oct-19 15:10', 'yyyy-mon-dd hh24:mi'), 0);
insert into check_in(id_check_in, data_check_in, id_rezervare)
values (secv_check.nextval, to_date('2019-oct-19 14:30', 'yyyy-mon-dd hh24:mi'), 1);
insert into check_in(id_check_in, data_check_in, id_rezervare)
values (secv_check.nextval, to_date('2019-oct-19 12:00', 'yyyy-mon-dd hh24:mi'), 2);
insert into check_in(id_check_in, data_check_in, id_rezervare)
values (secv_check.nextval, to_date('2019-oct-19 13:30', 'yyyy-mon-dd hh24:mi'), 3);
insert into check_in(id_check_in, data_check_in, id_rezervare)
values (secv_check.nextval, to_date('2019-oct-19 15:00', 'yyyy-mon-dd hh24:mi'), 4);
-- zbor 1
insert into check_in(id_check_in, data_check_in, id_rezervare)
values (secv_check.nextval, to_date('2019-dec-16 14:30', 'yyyy-mon-dd hh24:mi'), 5);
insert into check_in(id_check_in, data_check_in, id_rezervare)
values (secv_check.nextval, to_date('2019-dec-16 13:30', 'yyyy-mon-dd hh24:mi'), 7);
insert into check_in(id_check_in, data_check_in, id_rezervare)
values (secv_check.nextval, to_date('2019-dec-16 12:30', 'yyyy-mon-dd hh24:mi'), 8);
insert into check_in(id_check_in, data_check_in, id_rezervare)
values (secv_check.nextval, to_date('2019-dec-16 13:00', 'yyyy-mon-dd hh24:mi'), 10);
-- zbor 2
insert into check_in(id_check_in, data_check_in, id_rezervare)
values (secv_check.nextval, to_date('2020-feb-23 10:10', 'yyyy-mon-dd hh24:mi'), 11);
insert into check_in(id_check_in, data_check_in, id_rezervare)
values (secv_check.nextval, to_date('2020-feb-23 08:00', 'yyyy-mon-dd hh24:mi'), 13);
insert into check_in(id_check_in, data_check_in, id_rezervare)
values (secv_check.nextval, to_date('2020-feb-23 09:30', 'yyyy-mon-dd hh24:mi'), 14);
-- zbor 3
insert into check_in(id_check_in, data_check_in, id_rezervare)
values (secv_check.nextval, to_date('2020-apr-5 19:00', 'yyyy-mon-dd hh24:mi'), 15);
insert into check_in(id_check_in, data_check_in, id_rezervare)
values (secv_check.nextval, to_date('2020-apr-5 19:30', 'yyyy-mon-dd hh24:mi'), 16);
insert into check_in(id_check_in, data_check_in, id_rezervare)
values (secv_check.nextval, to_date('2020-apr-5 18:00', 'yyyy-mon-dd hh24:mi'), 18);
insert into check_in(id_check_in, data_check_in, id_rezervare)
values (secv_check.nextval, to_date('2020-apr-5 16:20', 'yyyy-mon-dd hh24:mi'), 19);
insert into check_in(id_check_in, data_check_in, id_rezervare)
values (secv_check.nextval, to_date('2020-apr-5 19:00', 'yyyy-mon-dd hh24:mi'), 20);
insert into check_in(id_check_in, data_check_in, id_rezervare)
values (secv_check.nextval, to_date('2020-apr-5 19:20', 'yyyy-mon-dd hh24:mi'), 21);
-- zbor 4
insert into check_in(id_check_in, data_check_in, id_rezervare)
values (secv_check.nextval, to_date('2021-jun-11 18:00', 'yyyy-mon-dd hh24:mi'), 22);
insert into check_in(id_check_in, data_check_in, id_rezervare)
values (secv_check.nextval, to_date('2021-jun-11 15:00', 'yyyy-mon-dd hh24:mi'), 23);
insert into check_in(id_check_in, data_check_in, id_rezervare)
values (secv_check.nextval, to_date('2021-jun-11 14:00', 'yyyy-mon-dd hh24:mi'), 25);
insert into check_in(id_check_in, data_check_in, id_rezervare)
values (secv_check.nextval, to_date('2021-jun-11 17:30', 'yyyy-mon-dd hh24:mi'), 26);
insert into check_in(id_check_in, data_check_in, id_rezervare)
values (secv_check.nextval, to_date('2021-jun-11 18:10', 'yyyy-mon-dd hh24:mi'), 27);
insert into check_in(id_check_in, data_check_in, id_rezervare)
values (secv_check.nextval, to_date('2021-jun-11 14:30', 'yyyy-mon-dd hh24:mi'), 29);
insert into check_in(id_check_in, data_check_in, id_rezervare)
values (secv_check.nextval, to_date('2021-jun-11 15:00', 'yyyy-mon-dd hh24:mi'), 30);

select * from check_in;


-- bagaje --
create sequence secv_bagaje
start with 0
increment by 1
minvalue 0
maxvalue 99
nocycle
nocache;

insert into bagaje(id_bagaj, greutate, id_check_in)
values (secv_bagaje.nextval, 20, 1);
insert into bagaje(id_bagaj, greutate, id_check_in)
values (secv_bagaje.nextval, 10, 2);
insert into bagaje(id_bagaj, greutate, id_check_in)
values (secv_bagaje.nextval, 25, 2);
insert into bagaje(id_bagaj, greutate, id_check_in)
values (secv_bagaje.nextval, 20, 3);
insert into bagaje(id_bagaj, greutate, id_check_in)
values (secv_bagaje.nextval, 15, 12);
insert into bagaje(id_bagaj, greutate, id_check_in)
values (secv_bagaje.nextval, 10, 17);
insert into bagaje(id_bagaj, greutate, id_check_in)
values (secv_bagaje.nextval, 10, 18);
insert into bagaje(id_bagaj, greutate, id_check_in)
values (secv_bagaje.nextval, 20, 21);
insert into bagaje(id_bagaj, greutate, id_check_in)
values (secv_bagaje.nextval, 5, 21);
insert into bagaje(id_bagaj, greutate, id_check_in)
values (secv_bagaje.nextval, 10, 5);

select * from bagaje;

