-- 12: Cereri sql complexe

-- 12.1
-- Cerin??: S? se ob?in? înso?itorii de zbor al c?ror nume con?ine litera „a” care au participat la zborurile din anii 2020 ?i 2021
-- care au plecat din ora?ul Frankfurt  ?i care au avut gradul de ocupare (câ?i pasageri au trecut de check-in
-- fa?? de câte locuri sunt în avionul respectiv) mai mic de 40%. 
-- Elemente: blocuri de cerere (clauza with), func?ie pe ?iruri de caractere, func?ie pe date calendaristice 
select distinct z.id_zbor, z.data_plecare, i.id_insotitor, i.nume, a.id_aeroport, o.nume oras
from insotitori_zbor i, echipaj_insotitori ei, zboruri z, aeroporturi a, orase o
where ei.id_insotitor = i.id_insotitor
and ei.id_zbor = z.id_zbor
and z.id_aeroport_plecare = a.id_aeroport
and a.id_oras = o.id_oras
and extract(year from z.data_plecare) in (2020, 2021)
and i.nume like '%a%'
and lower(o.nume) = 'frankfurt'
and z.id_zbor in (with locuri_zbor as (select id_zbor, count(id_loc) nr_loc
                                        from locuri 
                                        group by id_zbor
                                        order by id_zbor),
                check_zbor as (select r.id_zbor zbor, count(c.id_check_in) nr_check
                                from rezervari r, check_in c
                                where r.id_rezervare = c.id_rezervare
                                group by r.id_zbor
                                order by r.id_zbor)
                select a.id_zbor
                from locuri_zbor a, check_zbor b
                where a.id_zbor = b.zbor
                group by a.id_zbor, b.nr_check / a.nr_loc
                having round(b.nr_check / a.nr_loc, 4) * 100 < 40);
        
                
-- 12.2
-- Cerin??: S? se ob?in? suma greut??ii bagajelor din fiecare zbor ?i s? se determine dac? este egal? cu 25 sau 35. 
-- Zborurile s? fie ordonate cresc?tor dup? suma greut??ii bagajelor. 
-- Elemente: subcerere nesincronizat? în clauza from, ordon?ri ?i utilizarea func?iilor nvl ?i decode 
select z.id_zbor, z.suma, decode(z.suma, 25, 'suma egala cu 25', 35, 'suma egala cu 35', 'suma diferita de 25 si 35') rezultat
from (select nvl(sum(b.greutate), 0) suma, r.id_zbor
        from bagaje b, check_in c, rezervari r
        where b.id_check_in(+) = c.id_check_in
        and c.id_rezervare = r.id_rezervare
        group by r.id_zbor
        order by r.id_zbor) z
order by z.suma;


-- 12.3
-- Cerin??: S? se ob?in? avioanele ?i modelul acestora (id + nume) care au participat la primele 2 zboruri 
-- care au încasat cei mai pu?ini bani din vânzarea cu plat? de tip online a locurilor la clasa business, 
-- dar care au încasat mai mult de 100 din vânzarea acestor bilete (dac? sunt mai multe zboruri cu aceea?i sum? de bani minim?, se afi?eaz? toate). 
-- Elemente: subcerere sincronizat? în care intervin cel pu?in 3 tabele, grup?ri de date cu subcereri nesincronizate în care intervin cel pu?in 3 tabele, 
-- func?ii grup, filtrare la nivel de grupuri, func?ii pe ?iruri de caractere                 
select distinct a.id_avion, z.id_zbor, m.id_model_avion, m.nume_model
from avioane a, zboruri z, modele_avioane m
where a.id_avion = z.id_avion
and m.id_model_avion = a.id_model_avion
and (select sum(l.pret) bani
    from locuri l, rezervari r, plati p, clase c
    where z.id_zbor = l.id_zbor
    and l.id_loc = r.id_loc
    and l.id_zbor = r.id_zbor
    and r.id_rezervare = p.id_rezervare
    and c.id_clasa = l.id_clasa
    and lower(p.tip_plata) = 'online'
    and initcap(c.nume) = 'Business') in (select *
                                            from (select sum(l.pret) bani
                                                    from locuri l, rezervari r, plati p, clase c
                                                    where l.id_zbor = r.id_zbor
                                                    and l.id_loc = r.id_loc
                                                    and r.id_rezervare = p.id_rezervare
                                                    and c.id_clasa = l.id_clasa
                                                    and p.tip_plata = 'online'
                                                    and initcap(c.nume) = 'Business'
                                                    group by l.id_zbor
                                                    having sum(l.pret) > 100
                                                    order by bani)
                                            where rownum < 3);
                                    
                                            
-- 12.4
-- Cerin??: Se cere ca pentru fiecare rezervare care a fost f?cut? cu cel pu?in o lun? ?i jum?tate înainte de data de plecare a zborului s? se afle
-- dac? rezervarea a fost f?cut? de c?tre pasager (acest lucru se poate afla comparând numar_id, adic? atributul de cnp/security number), 
-- de c?tre o alt? persoan? cu aceea?i ultim? liter? a numelui ca ?i a pasagerului, de c?tre o alt? persoan? cu o alt? ultim? liter? a numelui,
-- de c?tre o agen?ie de turism sau de c?tre un reprezentant de vânz?ri. 
-- Elemente: expresie case, func?ii pe ?iruri de caractere, func?ie pe date calendaristice 
select r.id_rezervare, r.id_loc, r.id_zbor, r.id_pasager, r.id_client, round(months_between(z.data_plecare, r.data_rezervare), 2) nr_luni,
case when (exists(select pf.id_persoana 
                  from persoane_fizice pf, pasageri p
                  where pf.id_persoana = r.id_client
                  and r.id_pasager = p.id_pasager
                  and pf.id_number = p.numar_id)) then 'rezervare facuta de pasager'
     when (exists(select pf.id_persoana 
                  from persoane_fizice pf, pasageri p
                  where pf.id_persoana = r.id_client
                  and r.id_pasager = p.id_pasager
                  and pf.id_number != p.numar_id
                  and substr(p.nume, length(p.nume), 1) = substr(pf.nume, length(pf.nume), 1))) then 'rezervare facuta de alta persoana cu aceeasi ultima litera a numelui'
     when (exists(select pf.id_persoana 
                  from persoane_fizice pf, pasageri p
                  where pf.id_persoana = r.id_client
                  and r.id_pasager = p.id_pasager
                  and pf.id_number != p.numar_id
                  and substr(p.nume, -1, 1) != substr(pf.nume, -1, 1))) then 'rezervare facuta de alta persoana'
     when (exists(select a.id_agentie 
                  from agentii_turism a, pasageri p
                  where a.id_agentie = r.id_client
                  and r.id_pasager = p.id_pasager)) then 'rezervare facuta de o agentie de turism'
     when (exists(select rv.id_reprezentant 
                  from reprezentanti_vanzari rv, pasageri p
                  where rv.id_reprezentant = r.id_client
                  and r.id_pasager = p.id_pasager)) then 'rezervare facuta de un reprezentant de vanzari'
     else 'nu'
end as rezervare
from rezervari r, zboruri z
where r.id_zbor = z.id_zbor
and months_between(z.data_plecare, r.data_rezervare) <= 1.5
order by r.id_zbor, r.id_rezervare;


-- 12.5
-- Cerin??: S? se ob?in? zborurile care au num?rul de rezerv?ri pentru fiecare clas? (cele care au fost disponibile în acel zbor)
-- mai mare decât media num?rului de rezerv?ri pentru clasa respectiv?. 
-- Elemente: subcerere nesincronizat? în clauza from, grup?ri de date cu subcereri nesincronizate in care intervin cel pu?in 3 tabele, 
-- func?ii grup, filtrare la nivel de grupuri, blocuri de cerere (clauza with) 
with b as (select z.id_zbor z1, count(a.zbor) nr_aparitii
            from zboruri z, (select r.id_zbor zbor, l.id_clasa, c.nume, count(r.id_rezervare) nr
                            from rezervari r, locuri l, clase c
                            where r.id_zbor = l.id_zbor
                            and r.id_loc = l.id_loc
                            and l.id_clasa = c.id_clasa(+)
                            group by r.id_zbor, l.id_clasa, c.nume
                            having count(r.id_rezervare) >= (select count(r1.id_rezervare) / (select count(*) from zboruri) medie
                                                              from rezervari r1, locuri l1
                                                              where r1.id_loc = l1.id_loc
                                                              and r1.id_zbor = l1.id_zbor
                                                              and l.id_clasa = l1.id_clasa
                                                              group by l1.id_clasa)
                            order by r.id_zbor) a
            where z.id_zbor = a.zbor
            group by z.id_zbor
            order by z.id_zbor),
c as (select l.id_zbor z2, count(distinct(l.id_clasa)) nr_clase
        from locuri l
        group by l.id_zbor
        order by l.id_zbor)
select z.id_zbor
from zboruri z, b, c
where z.id_zbor = b.z1
and z.id_zbor = c.z2
and b.nr_aparitii = c.nr_clase
order by z.id_zbor;



-- 13: Opera?ii de actualizare ?i suprimare a datelor 

-- 13.1: Actualizare
-- Cerin??: S? se mic?oreze cu 10% pre?urile locurilor la clasa economy care nu au fost rezervate din zborurile 
-- la care au fost rezervate mai pu?in de jum?tate din locurile puse la vânzare la clasa economy.                     
commit;

update locuri
set pret = pret - 10/100 * pret
where (id_zbor, id_loc) in (select l.id_zbor, l.id_loc
                            from locuri l, clase c
                            where l.id_clasa = c.id_clasa
                            and lower(c.nume) = 'economy'
                            and not exists (select r.id_loc
                                            from rezervari r
                                            where r.id_loc = l.id_loc
                                            and r.id_zbor = l.id_zbor)
                            and l.id_zbor in (select l.id_zbor
                                                from locuri l, (select l1.id_zbor z1, count(r1.id_rezervare) nrr
                                                                from locuri l1, rezervari r1, clase c1
                                                                where c1.id_clasa = l1.id_clasa
                                                                and l1.id_loc = r1.id_loc
                                                                and l1.id_zbor = r1.id_zbor
                                                                and lower(c1.nume) = 'economy'
                                                                group by l1.id_zbor) a,
                                                                
                                                               (select l2.id_zbor z2, count(l2.id_loc) nrl
                                                                from locuri l2, clase c2
                                                                where c2.id_clasa = l2.id_clasa
                                                                and lower(c2.nume) = 'economy'
                                                                group by l2.id_zbor) b
                                                where l.id_zbor = a.z1
                                                and l.id_zbor = b.z2
                                                group by l.id_zbor, a.nrr / b.nrl
                                                having round(a.nrr / b.nrl, 2) < 0.5));

rollback;


-- 13.2: Actualizare
-- Cerin??: S? se schimbe tipul de plat? din online în transfer bancar pentru toate pl??ile f?cute pentru rezerv?ri 
-- din zborurile cu cel mai mare num?r de pl??i online.                                                                      
commit;
                                            
update plati
set tip_plata = 'transfer bancar'
where id_plata in (select p.id_plata
                    from plati p, rezervari r
                    where p.id_rezervare = r.id_rezervare
                    and lower(p.tip_plata) = 'online'
                    and r.id_zbor in (select r.id_zbor
                                    from plati p, rezervari r
                                    where p.id_rezervare = r.id_rezervare
                                    and lower(p.tip_plata) = 'online'
                                    group by r.id_zbor
                                    having count(p.id_plata) = (select max(count(p1.id_plata))
                                                                from rezervari r1, plati p1
                                                                where p1.id_rezervare = r1.id_rezervare
                                                                and lower(p1.tip_plata) = 'online'
                                                                group by r1.id_zbor)));

rollback;


-- 13.3: Suprimare
-- Cerin??: S? se ?tearg? toate ora?ele în care nu ajunge niciun zbor. 
commit;

delete
from orase o
where o.id_oras not in (select distinct o.id_oras
                        from orase o, aeroporturi a, zboruri z
                        where o.id_oras = a.id_aeroport
                        and a.id_aeroport = z.id_aeroport_sosire);
                        
rollback;



-- 14: Cereri SQL

-- 14.1: Outer-join pe minim 4 tabele
-- Cerin??: Pentru fiecare ?ar?, s? se afi?eze toate ora?ele din acea ?ar?, 
-- toate zborurile care au plecat din ea, cu ce avion ?i ce model de avion a fost folosit, inclusiv dac? nu exist?. 
select t.id_tara, t.nume tara, o.id_oras, o.nume oras, a.id_aeroport, z.id_zbor, a1.id_avion, m.id_model_avion
from tari t
left outer join orase o on t.id_tara = o.id_tara
left outer join aeroporturi a on o.id_oras = a.id_oras
left outer join zboruri z on a.id_aeroport = z.id_aeroport_plecare
left outer join avioane a1 on z.id_avion = a1.id_avion
left outer join modele_avioane m on a1.id_model_avion = m.id_model_avion
order by t.id_tara, o.id_oras;


-- 14.2: Division
-- Cerin??: S? se afi?eze id-ul ?i numele pasagerilor care au avut rezerv?ri în zboruri care au ajuns 
-- în toate aeroporturile în care au ajuns zborurile în care pasagerul cu id-ul 11 a avut rezervare. 
select distinct p1.id_pasager, p1.nume
from pasageri p1, rezervari r1
where p1.id_pasager = r1.id_pasager
and not exists ((select a.id_aeroport
                from rezervari r, zboruri z, aeroporturi a
                where r.id_pasager = r1.id_pasager
                and r.id_zbor = z.id_zbor
                and z.id_aeroport_sosire = a.id_aeroport)
            minus
                (select a.id_aeroport
                from rezervari r, zboruri z, aeroporturi a
                where r.id_pasager = 11
                and r.id_zbor = z.id_zbor
                and z.id_aeroport_sosire = a.id_aeroport))
and p1.id_pasager != 11;


-- 14.3: Analiza top-n
-- Cerin??: S? se afi?eze id-ul ?i numele ?i num?rul de ore de zbor ale primelor 3 
-- cele mai folosite modele de avioane din punctul de vedere al orelor de zbor. 
select *
from (select m.id_model_avion, m.nume_model, round(sum(z.data_sosire - z.data_plecare) * 24, 2) nr_ore
        from modele_avioane m, avioane a, zboruri z
        where m.id_model_avion = a.id_model_avion
        and a.id_avion = z.id_avion
        group by m.id_model_avion, m.nume_model
        order by round(sum(z.data_sosire - z.data_plecare) * 24, 2) desc) a
where rownum < 3;


-- 15: Optimizarea unei cereri
-- Cerin??: S? se ob?in? locurile (id_loc, id_zbor) din clasa business care au fost rezervate, 
-- au fost pl?tite online ?i au avut pre?ul mai mare sau egal cu 90. 

-- Înainte de optimizare
select l.id_loc, l.id_zbor
from locuri l, rezervari r, clase c, plati p
where c.id_clasa = l.id_clasa
and l.id_loc = r.id_loc
and l.id_zbor = r.id_zbor
and r.id_rezervare = p.id_rezervare
and lower(c.nume) = 'business'
and lower(p.tip_plata) = 'online'
and l.pret >= 90;

-- Dup? optimizare:
select lrc.id_loc, lrc.id_zbor
from (select lr.id_loc, lr.id_zbor, lr.id_rezervare
        from (select l.id_loc, l.id_zbor, l.id_clasa, r.id_rezervare
                from (select id_loc, id_zbor, id_clasa
                        from locuri
                        where pret >= 90) l,
                     (select id_loc, id_zbor, id_rezervare
                        from rezervari) r
                where l.id_loc = r.id_loc
                and l.id_zbor = r.id_zbor) lr,
            (select id_clasa
                from clase
                where lower(nume) = 'business') c
        where c.id_clasa = lr.id_clasa) lrc,
    (select id_rezervare
        from plati
        where lower(tip_plata) = 'online') p
where p.id_rezervare = lrc.id_rezervare;

