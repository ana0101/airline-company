commit;

-- 6
-- Formula?i în limbaj natural o problem? pe care s? o rezolva?i folosind un subprogram stocat independent 
-- care s? utilizeze toate cele 3 tipuri de colec?ii studiate. Apela?i subprogramul.

-- Luati primele v_nr zboruri si puneti id-ul lor intr-un vector.
-- Pentru acele zboruri, fie tabelul indexat de tabele imbricate
-- care retine pentru fiecare zbor ce bagaje are.
-- Updatati greutatea bagajelor care e mai mare decat v_max si
-- puneti-o v_max. Afisati inainte si dupa actualizare.

create or replace procedure p6(v_nr in number, v_max in number) is
    type t_imbricat is table of bagaje%rowtype;
    t_bagaje t_imbricat := t_imbricat();
    type t_indexat is table of t_imbricat index by pls_integer;
    t_bagaje_zboruri t_indexat;
    type vector is varray(10) of zboruri.id_zbor%type;
    t_zboruri vector := vector();
        
begin
    for i in 1..v_nr loop
        t_zboruri.extend;
    end loop;
        
    select id_zbor
    bulk collect into t_zboruri
    from zboruri
    where rownum <= v_nr
    order by id_zbor;
        
    dbms_output.put_line('Inainte de actualizare: ');
    for i in 1..v_nr loop
        dbms_output.put_line('Id zbor: ' || t_zboruri(i));
        select b.id_bagaj, b.id_check_in, b.greutate
        bulk collect into t_bagaje
        from bagaje b, check_in c, rezervari r
        where b.id_check_in = c.id_check_in
        and c.id_rezervare = r.id_rezervare
        and r.id_zbor = t_zboruri(i);
        
        t_bagaje_zboruri(t_zboruri(i)) := t_bagaje;
        if sql%rowcount = 0 then 
            dbms_output.put_line('Nu are bagaje');
        else
            for j in t_bagaje_zboruri(t_zboruri(i)).first .. t_bagaje_zboruri(t_zboruri(i)).last loop
                dbms_output.put_line('Id bagaj: ' || t_bagaje_zboruri(t_zboruri(i))(j).id_bagaj ||
                                     ', Id check-in: ' || t_bagaje_zboruri(t_zboruri(i))(j).id_check_in ||
                                     ', Greutate: ' || t_bagaje_zboruri(t_zboruri(i))(j).greutate);
            end loop;
        end if;
        t_bagaje.delete;
    end loop;
        
    for i in 1..v_nr loop
        if t_bagaje_zboruri(t_zboruri(i)).count > 0 then
            for j in t_bagaje_zboruri(t_zboruri(i)).first .. t_bagaje_zboruri(t_zboruri(i)).last loop
                if t_bagaje_zboruri(t_zboruri(i))(j).greutate > v_max then
                    t_bagaje_zboruri(t_zboruri(i))(j).greutate := v_max;
                    update bagaje
                    set greutate = v_max
                    where id_bagaj = t_bagaje_zboruri(t_zboruri(i))(j).id_bagaj;
                end if;
            end loop;
        end if;
    end loop;
        
    dbms_output.put_line('Dupa actualizare: ');
    for i in 1..v_nr loop
        dbms_output.put_line('Id zbor: ' || t_zboruri(i));
        if t_bagaje_zboruri(t_zboruri(i)).count > 0 then
            for j in t_bagaje_zboruri(t_zboruri(i)).first .. t_bagaje_zboruri(t_zboruri(i)).last loop
                dbms_output.put_line('Id bagaj: ' || t_bagaje_zboruri(t_zboruri(i))(j).id_bagaj ||
                                     ', Id check-in: ' || t_bagaje_zboruri(t_zboruri(i))(j).id_check_in ||
                                     ', Greutate: ' || t_bagaje_zboruri(t_zboruri(i))(j).greutate);
            end loop;
        else
            dbms_output.put_line('Nu are bagaje');
        end if;
    end loop;
end p6;
/

begin
    p6(3, 12);
end;
/

commit;
rollback;




-- 7
-- Formula?i în limbaj natural o problem? pe care s? o rezolva?i folosind un subprogram stocat independent 
-- care s? utilizeze 2 tipuri diferite de cursoare studiate, unul dintre acestea fiind cursor parametrizat, 
-- dependent de cel?lalt cursor. Apela?i subprogramul.

-- Pentru pilotii care au participat la cel putin n zboruri, sa se afiseze numele si pentru fiecare zbor
-- modelul de avion.

create or replace procedure p7(v_nr_min in number) is
    -- cursor explicit
    cursor c_piloti is
        select p.id_pilot, p.nume, count(*)
        from piloti p, echipaje_piloti e
        where p.id_pilot = e.id_pilot
        group by p.id_pilot, p.nume
        having count(*) >= v_nr_min;
            
    -- ciclu cursor parametrizat dependent de c_piloti
    cursor c_zboruri(v_id_pilot piloti.id_pilot%type) is
        select z.id_zbor id_zbor, m.nume_model nume_model
        from piloti p, echipaje_piloti e, zboruri z, avioane a, modele_avioane m
        where p.id_pilot = v_id_pilot
        and p.id_pilot = e.id_pilot
        and e.id_zbor = z.id_zbor
        and z.id_avion = a.id_avion
        and a.id_model = m.id_model;
            
    v_id_pilot piloti.id_pilot%type;
    v_nume piloti.nume%type;
    v_nr_zboruri number;
            
begin
    open c_piloti;
    loop
        fetch c_piloti into v_id_pilot, v_nume, v_nr_zboruri;
        exit when c_piloti%notfound;
        dbms_output.put_line('Pilotul cu id-ul ' || v_id_pilot || ' si numele ' || v_nume || 'a participat la ' || v_nr_zboruri || ' zboruri:');
        for c in c_zboruri(v_id_pilot) loop
            dbms_output.put_line('- zborul ' || c.id_zbor || ' cu modelul de avion ' || c.nume_model);
        end loop;
        dbms_output.new_line;
    end loop;
    close c_piloti;
end p7;
/


begin
    p7(2);
end;
/



-- 8
-- Formula?i în limbaj natural o problem? pe care s? o rezolva?i folosind un subprogram stocat independent de tip func?ie
-- care s? utilizeze într-o singur? comand? SQL 3 dintre tabelele definite. Defini?i minim 2 excep?ii proprii. 
-- Apela?i subprogramul astfel încât s? eviden?ia?i toate cazurile definite ?i tratate.

-- Pentru zborul care ajunge intr-un oras dat, micsorati cu un procent p dat preturile locurilor 
-- care nu s-au vandut mai scumpe decat un pret dat si returnati numarul de preturi schimbate.

create or replace function f8(v_nume_oras orase.nume%type, v_proc number, v_pret locuri.pret%type) return number is
    v_id_zbor zboruri.id_zbor%type;
    v_nr number;
    e_procent_invalid exception;
    e_pret_invalid exception;
    e_fara_locuri exception;
    
begin
    if v_proc <= 0 or v_proc >= 100 then
        raise e_procent_invalid;
    end if;
        
    if v_pret <= 0 then
        raise e_pret_invalid;
    end if;
        
    select z.id_zbor
    into v_id_zbor
    from zboruri z, aeroporturi a, orase o
    where o.nume = v_nume_oras
    and o.id_oras = a.id_oras
    and a.id_aeroport = z.id_aeroport_sosire;
        
    begin
        v_nr := 0;
        for c in (select id_loc loc
                  from locuri l
                  where l.id_zbor = v_id_zbor
                  and l.pret >= v_pret
                  and not exists (select 1
                                  from rezervari r
                                  where r.id_zbor = l.id_zbor
                                  and r.id_loc = l.id_loc)) loop
            update locuri
            set pret = pret - v_proc/100 * pret
            where id_loc = c.loc;
                
            v_nr := v_nr + 1;
        end loop;
            
        if v_nr = 0 then
            raise e_fara_locuri;
        end if;
            
        return v_nr;
    end;
exception 
    when no_data_found then raise_application_error(-20000, 'Nu exista niciun zbor care ajunge in acest oras');
    when too_many_rows then raise_application_error(-20001, 'Exista mai multe zboruri care ajung in acest oras');
    when e_procent_invalid then raise_application_error(-20002, 'Procent invalid: ' || v_proc);
    when e_pret_invalid then raise_application_error(-20003, 'Pret invalid: ' || v_pret);
    when e_fara_locuri then raise_application_error(-20004, 'Nu exista niciun loc nerezervat cu pret mai mare sau egal decat pretul dat');
end f8;
/

begin
    dbms_output.put_line(f8('Frankfurt', 20, 80));
end;
/

dbms_output.put_line(f8('Trondheim', 20, 80));
dbms_output.put_line(f8('Bucuresti', 20, 80)); 
dbms_output.put_line(f8('Frankfurt', 120, 80)); 
dbms_output.put_line(f8('Frankfurt', 20, -80)); 
dbms_output.put_line(f8('Frankfurt', 20, 1000)); 
dbms_output.put_line(f8('Frankfurt', 20, 80)); 

commit;
rollback;



-- 9
-- Formula?i în limbaj natural o problem? pe care s? o rezolva?i folosind un subprogram stocat independent 
-- de tip procedur? care s? utilizeze într-o singur? comand? SQL 5 dintre tabelele definite. 
-- Trata?i toate excep?iile care pot ap?rea, incluzând excep?iile NO_DATA_FOUND ?i TOO_MANY_ROWS. 
-- Apela?i subprogramul astfel încât s? eviden?ia?i toate cazurile tratate.

-- Pentru un pasager dat, sa se afle cate zboruri din cele in care are rezervare pleaca dintr-o tara data
-- si locul rezervat este la o clasa data

create or replace procedure p9 (v_nume in pasageri.nume%type, v_tara in tari.nume%type, v_clasa in clase.nume%type, v_nr out number) is
     v_id_pasager pasageri.id_pasager%type;
     v_ok number;
begin
    begin
        select id_pasager
        into v_id_pasager
        from pasageri
        where lower(nume) = lower(v_nume);
    exception
        when no_data_found then raise_application_error(-20000, 'Nu exista niciun pasager cu acest nume');
        when too_many_rows then raise_application_error(-20001, 'Exista mai multi pasageri cu acest nume');
    end;
        
    begin
        select 1
        into v_ok
        from tari
        where lower(nume) = lower(v_tara);
    exception
        when no_data_found then raise_application_error(-20002, 'Nu exista nicio tara cu acest nume');
    end;
        
    begin
        select 1
        into v_ok
        from clase
        where lower(nume) = lower(v_clasa);
    exception
        when no_data_found then raise_application_error(-20003, 'Nu exista nicio clasa cu acest nume');
    end;
            
    select count(r.id_pasager)
    into v_nr
    from rezervari r, locuri l, clase c, zboruri z, aeroporturi a, orase o, tari t
    where r.id_pasager = v_id_pasager
    and lower(c.nume) = lower(v_clasa)
    and lower(t.nume) = lower(v_tara)
    and r.id_zbor = l.id_zbor
    and r.id_loc = l.id_loc
    and l.id_clasa = c.id_clasa
    and l.id_zbor = z.id_zbor
    and z.id_aeroport_plecare = a.id_aeroport
    and a.id_oras = o.id_oras
    and o.id_tara = t.id_tara
    group by r.id_pasager;
    
exception
    when no_data_found then v_nr := 0;
end p9;
/

declare
    v_nr number;
begin
    p9('Cojocaru', 'Romania', 'Economy', v_nr);
    dbms_output.put_line(v_nr || ' zboruri');
end;
/

p9('Petrescu', 'Germania', 'Economy', v_nr);
dbms_output.put_line(v_nr || ' zboruri');
p9('Cojocaru', 'Grecia', 'Economy', v_nr);
dbms_output.put_line(v_nr || ' zboruri');
p9('Cojocaru', 'Germania', 'Nume', v_nr);
dbms_output.put_line(v_nr || ' zboruri');
p9('Cojocaru', 'Germania', 'Economy', v_nr);
dbms_output.put_line(v_nr || ' zboruri');
p9('Cojocaru', 'Romania', 'Economy', v_nr);
dbms_output.put_line(v_nr || ' zboruri');



-- 10
-- Defini?i un trigger de tip LMD la nivel de comand?. Declan?a?i trigger-ul.
-- Tabelul pasageri sa nu poata fi schimbat decat de luni pana vineri in intervalul 9-18
create or replace trigger trig10
    before insert or update or delete on pasageri
begin
    if (to_char(sysdate, 'D') in (1, 7)) or (to_char(sysdate, 'HH24') not between 9 and 17) then
        raise_application_error(-20001, 'Tabelul pasageri nu poate fi schimbat decat de luni pana vineri in intervalul 9-18');
    end if;
end;
/

insert into pasageri
values(16, '2961126231255', 'Popescu', 'Sara', 'Romania', '26-nov-1996', null);

delete from  pasageri
where id_pasager = 16;



-- 11
-- Defini?i un trigger de tip LMD la nivel de linie. Declan?a?i trigger-ul.

-- Fie tabelul info_zboruri care are coloanele id_zbor si pret_total, care reprezinta suma preturilor
-- locurilor din acel zbor. Definiti un trigger care sa updateze automat tabelul info_zboruri atunci cand
-- se adauga, se modifica sau se sterge un loc.

create table info_zboruri (
    id_info number(4),
    pret_total number(10),
    constraint pk_info_zboruri primary key(id_info)
);

create or replace procedure modific_info (v_id_zbor info_zboruri.id_info%type, v_pret locuri.pret%type) as
begin
    update info_zboruri
    set pret_total = nvl(pret_total, 0) + v_pret
    where id_info = v_id_zbor;
end;
/

create or replace trigger trig11
    after delete or update or insert of pret on locuri
    for each row
begin
    if deleting then
        modific_info(:old.id_zbor, -1 * :old.pret);
    elsif updating then
        modific_info(:old.id_zbor, :new.pret - :old.pret);
    else
        modific_info(:new.id_zbor, :new.pret);
    end if;
end;
/

insert into info_zboruri
values (0, 719);
insert into info_zboruri
values (1, 1020);
insert into info_zboruri
values (2, 1820);
insert into info_zboruri
values (3, 1135);
insert into info_zboruri
values (4, 2475);

commit;

-- sterg un loc
delete from locuri
where id_zbor = 4
and id_loc = 19;

-- modific pretul unui loc
update locuri
set pret = pret + 100
where id_zbor = 4
and id_loc = 19;

-- adaug un loc
insert into locuri
values (20, 4, 200, 1);

select *
from locuri
where id_zbor = 4;

delete
from locuri
where id_zbor = 4
and id_loc = 20;

rollback;



-- 12
-- Defini?i un trigger de tip LDD. Declan?a?i trigger-ul.
-- Definiti un trigger care sa nu permita stergerea unor anumite tabele.

create table rezervari2 (
    id number(4)
);

create or replace type lista_tabele as table of varchar2(30);

create or replace trigger trig12
before drop on schema
declare
    v_tabele lista_tabele := lista_tabele('REZERVARI2', 'CHECK_IN', 'PLATI');
begin
    for i in 1..v_tabele.count loop
        if ora_dict_obj_type = 'TABLE' and ora_dict_obj_name = v_tabele(i) then
            raise_application_error(-20001, 'Tabelul ' || v_tabele(i) || ' nu poate fi sters');
        end if;
    end loop;
end;
/

drop table rezervari2;



-- 13
-- Defini?i un pachet care s? con?in? toate obiectele definite în cadrul proiectului.
create or replace package pachet13 as
    procedure p6(v_nr in number, v_max in number);
    procedure p7(v_nr_min in number);
    function f8(v_nume_oras orase.nume%type, v_proc number, v_pret locuri.pret%type) return number;
    procedure p9(v_nume in pasageri.nume%type, v_tara in tari.nume%type, v_clasa in clase.nume%type, v_nr out number);
end pachet13;
/


create or replace package body pachet13 as
    -- 6 ---------------------------------------------------------------------------------
    procedure p6(v_nr in number, v_max in number) is
        type t_imbricat is table of bagaje%rowtype;
        t_bagaje t_imbricat := t_imbricat();
        type t_indexat is table of t_imbricat index by pls_integer;
        t_bagaje_zboruri t_indexat;
        type vector is varray(10) of zboruri.id_zbor%type;
        t_zboruri vector := vector();
        
    begin
        for i in 1..v_nr loop
            t_zboruri.extend;
        end loop;
            
        select id_zbor
        bulk collect into t_zboruri
        from zboruri
        where rownum <= v_nr
        order by id_zbor;
            
        dbms_output.put_line('Inainte de actualizare: ');
        for i in 1..v_nr loop
            dbms_output.put_line('Id zbor: ' || t_zboruri(i));
            select b.id_bagaj, b.id_check_in, b.greutate
            bulk collect into t_bagaje
            from bagaje b, check_in c, rezervari r
            where b.id_check_in = c.id_check_in
            and c.id_rezervare = r.id_rezervare
            and r.id_zbor = t_zboruri(i);
            
            t_bagaje_zboruri(t_zboruri(i)) := t_bagaje;
            if sql%rowcount = 0 then 
                dbms_output.put_line('Nu are bagaje');
            else
                for j in t_bagaje_zboruri(t_zboruri(i)).first .. t_bagaje_zboruri(t_zboruri(i)).last loop
                    dbms_output.put_line('Id bagaj: ' || t_bagaje_zboruri(t_zboruri(i))(j).id_bagaj ||
                                         ', Id check-in: ' || t_bagaje_zboruri(t_zboruri(i))(j).id_check_in ||
                                         ', Greutate: ' || t_bagaje_zboruri(t_zboruri(i))(j).greutate);
                end loop;
            end if;
            t_bagaje.delete;
        end loop;
            
        for i in 1..v_nr loop
            if t_bagaje_zboruri(t_zboruri(i)).count > 0 then
                for j in t_bagaje_zboruri(t_zboruri(i)).first .. t_bagaje_zboruri(t_zboruri(i)).last loop
                    if t_bagaje_zboruri(t_zboruri(i))(j).greutate > v_max then
                        t_bagaje_zboruri(t_zboruri(i))(j).greutate := v_max;
                        update bagaje
                        set greutate = v_max
                        where id_bagaj = t_bagaje_zboruri(t_zboruri(i))(j).id_bagaj;
                    end if;
                end loop;
            end if;
        end loop;
            
        dbms_output.put_line('Dupa actualizare: ');
        for i in 1..v_nr loop
            dbms_output.put_line('Id zbor: ' || t_zboruri(i));
            if t_bagaje_zboruri(t_zboruri(i)).count > 0 then
                for j in t_bagaje_zboruri(t_zboruri(i)).first .. t_bagaje_zboruri(t_zboruri(i)).last loop
                    dbms_output.put_line('Id bagaj: ' || t_bagaje_zboruri(t_zboruri(i))(j).id_bagaj ||
                                         ', Id check-in: ' || t_bagaje_zboruri(t_zboruri(i))(j).id_check_in ||
                                         ', Greutate: ' || t_bagaje_zboruri(t_zboruri(i))(j).greutate);
                end loop;
            else
                dbms_output.put_line('Nu are bagaje');
            end if;
        end loop;
    end p6;
    
    
    -- 7 ---------------------------------------------------------------------------------
    procedure p7(v_nr_min in number) is
        -- cursor explicit
        cursor c_piloti is
            select p.id_pilot, p.nume, count(*)
            from piloti p, echipaje_piloti e
            where p.id_pilot = e.id_pilot
            group by p.id_pilot, p.nume
            having count(*) >= v_nr_min;
            
        -- ciclu cursor parametrizat dependent de c_piloti
        cursor c_zboruri(v_id_pilot piloti.id_pilot%type) is
            select z.id_zbor id_zbor,  m.nume_model nume_model
            from piloti p, echipaje_piloti e, zboruri z, avioane a, modele_avioane m
            where p.id_pilot = v_id_pilot
            and p.id_pilot = e.id_pilot
            and e.id_zbor = z.id_zbor
            and z.id_avion = a.id_avion
            and a.id_model = m.id_model;
            
        v_id_pilot piloti.id_pilot%type;
        v_nume piloti.nume%type;
        v_nr_zboruri number;
            
    begin
        open c_piloti;
        loop
            fetch c_piloti into v_id_pilot, v_nume, v_nr_zboruri;
            exit when c_piloti%notfound;
            dbms_output.put_line('Pilotul cu id-ul ' || v_id_pilot || ' si numele ' || v_nume || 'a participat la ' || v_nr_zboruri || ' zboruri:');
            for c in c_zboruri(v_id_pilot) loop
                dbms_output.put_line('- zborul ' || c.id_zbor || ' cu modelul de avion ' || c.nume_model);
            end loop;
            dbms_output.new_line;
        end loop;
        close c_piloti;
    end p7;
    
    
    -- 8 ---------------------------------------------------------------------------------
    function f8(v_nume_oras orase.nume%type, v_proc number, v_pret locuri.pret%type) return number is
        v_id_zbor zboruri.id_zbor%type;
        v_nr number;
        e_procent_invalid exception;
        e_pret_invalid exception;
        e_fara_locuri exception;
        
    begin
        if v_proc <= 0 or v_proc >= 100 then
            raise e_procent_invalid;
        end if;
            
        if v_pret <= 0 then
            raise e_pret_invalid;
        end if;
            
        select z.id_zbor
        into v_id_zbor
        from zboruri z, aeroporturi a, orase o
        where o.nume = v_nume_oras
        and o.id_oras = a.id_oras
        and a.id_aeroport = z.id_aeroport_sosire;
            
        begin
            v_nr := 0;
            for c in (select id_loc loc
                      from locuri l
                      where l.id_zbor = v_id_zbor
                      and l.pret >= v_pret
                      and not exists (select 1
                                      from rezervari r
                                      where r.id_zbor = l.id_zbor
                                      and r.id_loc = l.id_loc)) loop
                update locuri
                set pret = pret - v_proc/100 * pret
                where id_loc = c.loc;
                    
                v_nr := v_nr + 1;
            end loop;
                
            if v_nr = 0 then
                raise e_fara_locuri;
            end if;
                
            return v_nr;
        end;
    exception 
        when no_data_found then raise_application_error(-20000, 'Nu exista niciun zbor care ajunge in acest oras');
        when too_many_rows then raise_application_error(-20001, 'Exista mai multe zboruri care ajung in acest oras');
        when e_procent_invalid then raise_application_error(-20002, 'Procent invalid: ' || v_proc);
        when e_pret_invalid then raise_application_error(-20003, 'Pret invalid: ' || v_pret);
        when e_fara_locuri then raise_application_error(-20004, 'Nu exista niciun loc nerezervat cu pret mai mare sau egal decat pretul dat');
    end f8;
    
    
    -- 9 ---------------------------------------------------------------------------------
    procedure p9
        (v_nume in pasageri.nume%type, v_tara in tari.nume%type, v_clasa in clase.nume%type, v_nr out number) is
        v_id_pasager pasageri.id_pasager%type;
        v_ok number;
    begin
        begin
            select id_pasager
            into v_id_pasager
            from pasageri
            where lower(nume) = lower(v_nume);
        exception
            when no_data_found then raise_application_error(-20000, 'Nu exista niciun pasager cu acest nume');
            when too_many_rows then raise_application_error(-20001, 'Exista mai multi pasageri cu acest nume');
        end;
        
        begin
            select 1
            into v_ok
            from tari
            where lower(nume) = lower(v_tara);
        exception
            when no_data_found then raise_application_error(-20002, 'Nu exista nicio tara cu acest nume');
        end;
        
        begin
            select 1
            into v_ok
            from clase
            where lower(nume) = lower(v_clasa);
        exception
            when no_data_found then raise_application_error(-20003, 'Nu exista nicio clasa cu acest nume');
        end;
            
        select count(r.id_pasager)
        into v_nr
        from rezervari r, locuri l, clase c, zboruri z, aeroporturi a, orase o, tari t
        where r.id_pasager = v_id_pasager
        and lower(c.nume) = lower(v_clasa)
        and lower(t.nume) = lower(v_tara)
        and r.id_zbor = l.id_zbor
        and r.id_loc = l.id_loc
        and l.id_clasa = c.id_clasa
        and l.id_zbor = z.id_zbor
        and z.id_aeroport_plecare = a.id_aeroport
        and a.id_oras = o.id_oras
        and o.id_tara = t.id_tara
        group by r.id_pasager;
    
    exception
        when no_data_found then v_nr := 0;
    end p9;
    
end pachet13;
/


-- apelare
declare
    v_nr number;
begin
    pachet13.p9('Cojocaru', 'Romania', 'Economy', v_nr);
    dbms_output.put_line(v_nr || ' zboruri');
end;
/

commit;
rollback;

-- pachet13.p6(3, 12);
-- pachet13.p7(2);
-- dbms_output.put_line(pachet13.f8('Frankfurt', 20, 80)); 



-- 14
-- Defini?i un pachet care s? includ? tipuri de date complexe ?i obiecte necesare unui flux de ac?iuni integrate, 
-- specifice bazei de date definite (minim 2 tipuri de date, minim 2 func?ii, minim 2 proceduri).

-- Un pachet pentru adaugarea unui zbor. Parametri: data plecare, data sosire, id avion, id aeroport plecare,
-- id aeroport sosire. Id-ul generat automat de o secventa. Sa se insereze automat informatii in tabela locuri
-- (cate locuri are modelul de avion) cu pretul media preturilor locurilor din cel mai recent zbor si clasa cu id-ul 1.
-- Sa se insereze automat in echipaje piloti un numar dat de piloti pt acest zbor (cei care au participat la cele mai putine zboruri)

-- cursor pt echipaje piloti
-- tablou imbricat de record-uri pt locuri
-- record pt zbor
-- vector pt id loc
-- functie pt inserare in zboruri
-- procedura pt inserare in locuri
-- procedura pt inserare in echipaje piloti
-- functie pt aflare nr locuri
-- functie pt aflare pret
-- functie pt aflarea celui mai recent zbor

create or replace package pachet14 as
    type zbor_record is record (
        data_plecare zboruri.data_plecare%type,
        data_sosire zboruri.data_sosire%type,
        id_avion zboruri.id_avion%type,
        id_aeroport_plecare zboruri.id_aeroport_plecare%type,
        id_aeroport_sosire zboruri.id_aeroport_sosire%type
    );
    
    cursor c_piloti(v_nr number) return piloti%rowtype;
    
    type tablou_imbricat is table of echipaje_piloti%rowtype;
    t_echipaj_piloti tablou_imbricat := tablou_imbricat();

    function f_inserare_zbor(v_zbor in zbor_record) return zboruri.id_zbor%type;
    function f_ultimul_zbor return zboruri.id_zbor%type;
    function f_pret(v_id_zbor zboruri.id_zbor%type) return locuri.pret%type;
    function f_nr_locuri(v_id_avion zboruri.id_avion%type) return modele_avioane.nr_locuri%type;
    procedure p_inserare_locuri(v_id_zbor in zboruri.id_zbor%type, v_pret in locuri.pret%type, 
                                v_id_clasa in locuri.id_clasa%type, v_nr_locuri in modele_avioane.nr_locuri%type);
    procedure p_t_echipaj_piloti(v_id_zbor in zboruri.id_zbor%type, v_id_pilot in piloti.id_pilot%type, 
                                 v_t_echipaj_piloti in out tablou_imbricat);
    procedure p_inserare_echipaj_piloti(v_t_echipaj_piloti in tablou_imbricat);
end pachet14;
/


create or replace package body pachet14 as

    cursor c_piloti(v_nr number) return piloti%rowtype is
        select *
        from piloti
        where id_pilot in (select *
                           from (select id_pilot
                                 from echipaje_piloti
                                 group by id_pilot
                                 order by count(*), nume)
                            where rownum <= v_nr);


    function f_inserare_zbor(v_zbor in zbor_record) return zboruri.id_zbor%type is
        v_id_zbor zboruri.id_zbor%type;
    begin
        v_id_zbor := secv_zboruri.nextval;
        insert into zboruri
        values (v_id_zbor, v_zbor.data_plecare, v_zbor.data_sosire, v_zbor.id_avion, v_zbor.id_aeroport_plecare, v_zbor.id_aeroport_sosire);
        return v_id_zbor;
    end f_inserare_zbor;
    
    
    function f_ultimul_zbor return zboruri.id_zbor%type is
        v_id_zbor zboruri.id_zbor%type;
    begin
        select id_zbor
        into v_id_zbor
        from zboruri
        where data_plecare = (select max(data_plecare)
                              from zboruri);
        return v_id_zbor;
    end f_ultimul_zbor;
    
    
    function f_pret(v_id_zbor zboruri.id_zbor%type) return locuri.pret%type is
        v_pret locuri.pret%type;
    begin
        select avg(pret)
        into v_pret
        from locuri
        where id_zbor = v_id_zbor;
        return v_pret;
    end f_pret;
    
    
    function f_nr_locuri(v_id_avion zboruri.id_avion%type) return modele_avioane.nr_locuri%type is
        v_nr modele_avioane.nr_locuri%type;
    begin
        select m.nr_locuri
        into v_nr
        from modele_avioane m, avioane a
        where m.id_model = a.id_model
        and a.id_avion = v_id_avion;
        return v_nr;
    end f_nr_locuri;
    
    
    procedure p_inserare_locuri(v_id_zbor in zboruri.id_zbor%type, v_pret in locuri.pret%type, 
                                v_id_clasa in locuri.id_clasa%type, v_nr_locuri in modele_avioane.nr_locuri%type) is
    begin
        for i in 0..v_nr_locuri-1 loop
            insert into locuri
            values(i, v_id_zbor, v_pret, v_id_clasa);
        end loop;
    end p_inserare_locuri;
    
    
    procedure p_t_echipaj_piloti(v_id_zbor in zboruri.id_zbor%type, v_id_pilot in piloti.id_pilot%type, v_t_echipaj_piloti in out tablou_imbricat) is
        v_echipaj echipaje_piloti%rowtype;
    begin
        v_echipaj.id_zbor := v_id_zbor;
        v_echipaj.id_pilot := v_id_pilot;
        v_t_echipaj_piloti.extend;
        v_t_echipaj_piloti(v_t_echipaj_piloti.count) := v_echipaj;
    end p_t_echipaj_piloti;
    
    
    procedure p_inserare_echipaj_piloti(v_t_echipaj_piloti in tablou_imbricat) is
    begin
        for i in 1..v_t_echipaj_piloti.count loop
            insert into echipaje_piloti
            values(v_t_echipaj_piloti(i).id_zbor, v_t_echipaj_piloti(i).id_pilot);
        end loop;
    end p_inserare_echipaj_piloti;
    
end pachet14;
/


declare
    v_zbor pachet14.zbor_record;
    v_id_zbor zboruri.id_zbor%type;
    v_id_ult_zbor zboruri.id_zbor%type;
    v_pret locuri.pret%type;
    v_nr_locuri modele_avioane.nr_locuri%type;
    v_echipaj_piloti pachet14.tablou_imbricat;
    
begin
    v_zbor.data_plecare := to_date('2023-feb-03 12:30', 'yyyy-mon-dd hh24:mi');
    v_zbor.data_sosire := to_date('2023-feb-03 14:30', 'yyyy-mon-dd hh24:mi');
    v_zbor.id_avion := 2;
    v_zbor.id_aeroport_plecare := 1;
    v_zbor.id_aeroport_sosire := 3;
    
    v_id_ult_zbor := pachet14.f_ultimul_zbor;
    v_pret := pachet14.f_pret(v_id_ult_zbor);
    v_nr_locuri := pachet14.f_nr_locuri(v_zbor.id_avion);
    
    v_id_zbor := pachet14.f_inserare_zbor(v_zbor);
    
    pachet14.p_inserare_locuri(v_id_zbor, v_pret, 1, v_nr_locuri);
    
    v_echipaj_piloti := pachet14.tablou_imbricat();
    for v_cursor in pachet14.c_piloti(2) loop
        pachet14.p_t_echipaj_piloti(v_id_zbor, v_cursor.id_pilot, v_echipaj_piloti);
    end loop;
    
    pachet14.p_inserare_echipaj_piloti(v_echipaj_piloti);
end;
/

commit;
rollback;

select * from zboruri;
select * from locuri where id_zbor = 10;
select * from avioane;
select * from modele_avioane;
select * from echipaje_piloti;

delete from zboruri
where id_zbor = 9;

delete from locuri
where id_zbor = 9;
    
