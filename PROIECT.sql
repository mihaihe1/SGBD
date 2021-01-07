CREATE TABLE campionat(
    id_campionat number(3) PRIMARY KEY,
    nume_campionat varchar2(50),
    website varchar2(30),
    pret_abonament number(4,3)
);

CREATE TABLE echipa(
    id_echipa number(3) PRIMARY KEY,
    nume_echipa varchar2(50),
    buget number(10,3),
    titluri_castigate number(3),
    id_campionat number(3) REFERENCES campionat(id_campionat) on delete cascade
);

CREATE TABLE pilot(
    id_pilot number(4) PRIMARY KEY,
    first_name varchar2(20),
    last_name varchar2(20),
    email varchar2(40),
    salary number(10,3),
    hire_date date,
    contract number(2),
    victorii number(4),
    podiumuri number(4),
    id_echipa number(3) REFERENCES echipa(id_echipa) on delete cascade
);
drop table tara;
CREATE TABLE circuit(
    id_circuit number(3) PRIMARY KEY,
    nume_circuit varchar2(50),
    nr_spectatori number(6),
    id_tara number(3) references tara(id_tara) on delete cascade
);

create table tara(
    id_tara number(3) primary key,
    nume_tara varchar2(50)
);

CREATE TABLE testeaza_la(
    id_pilot number(4) NOT NULL,
    id_circuit number(3) NOT NULL,
    FOREIGN KEY (id_pilot) references pilot(id_pilot),
    FOREIGN KEY (id_circuit) references circuit(id_circuit),
    UNIQUE (id_pilot, id_circuit)
);

CREATE TABLE fabrica(
    id_fabrica number(3) PRIMARY KEY,
    nume_fabrica varchar2(40),
    adresa varchar2(40),
    id_echipa number(3) references echipa(id_echipa) on delete cascade
);

CREATE TABLE componente(
    id_comp number(4) PRIMARY KEY,
    nume_comp varchar2(30),
    pret_prod number(10, 3),
    id_fabrica number(3) references fabrica(id_fabrica)
);

drop table componente;
----CAMPIONAT
insert into campionat values (1, 'Formula 1', 'www.formula1.com', 9.99);
insert into campionat values (2, 'Formula 2', 'www.formula2.com', 2.99);
insert into campionat values (3, 'Formula 3', 'www.formula3.com', 1.99);
insert into campionat values (4, 'Formula E', 'www.formulae.com', 4.99);
insert into campionat values (5, '24 Hours of Le Mans', 'www.lemans.com', 5.99);
-----------

-----ECHIPA
insert into echipa values(30, 'Scuderia Ferrari', 60000, 16, 1);
insert into echipa values(31, 'Red Bull Racing', 150000, 4, 1);
insert into echipa values(32, 'Mercedes AMG Petronas', 190000, 7, 1);
insert into echipa values(40, 'Prema Racing', 50000, 1, 2);
insert into echipa values(60, 'Techeetah', 70000, 2, 4);
insert into echipa values(41, 'Uni-Virtuosi Racing', 40000, 0, 2);
insert into echipa values(33, 'Test', 100000, 1, 1);
-------------

------PILOT
insert into pilot values(5, 'Sebastian', 'Vettel', 'seb5@gmail.com', 100000.85, TO_DATE('2015/05/03', 'yyyy/mm/dd'),
                            5, 53, 121, 30);
insert into pilot values(16, 'Charles', 'Leclerc', 'leclerc1@sf.com', 20000, TO_DATE('11/09/2018', 'dd/mm/yyyy'), 
                            3, 2, 12, 30);
insert into pilot values(44, 'Lewis', 'Hamilton', 'hamilton@yahoo.com', 50000, TO_DATE('07/10/2013', 'dd/mm/yyyy'),
                            1, 95, 165, 32);
insert into pilot values(33, 'Max', 'Verstappen', 'max@gmail.com', 25000, TO_DATE('04/09/2016', 'dd/mm/yyyy'),
                            3, 10, 42, 31);
insert into pilot values(13, 'Antonio', 'Da Costa', 'anto@yahoo.com', 10000, TO_DATE('11/08/2018', 'dd/mm/yyyy'),
                            2, 1, 4, 60);
------------

-------CIRCUIT
insert into circuit values(1, 'Autodromo Monza', 10000,10);
insert into circuit values(2, 'Hungaroring', 8000,11);
insert into circuit values(3, 'Spa-Francorchamps', 15000,12);
insert into circuit values(4, 'Park Zandvoort', 5000,13);
insert into circuit values(5, 'Mugello', 2000,10);
------------

--------TARA
insert into tara values(10, 'Italia');
insert into tara values(11, 'Ungaria');
insert into tara values(12, 'Belgia');
insert into tara values(13, 'Olanda');
insert into tara values(14, 'Turcia');
------------

----TESTEAZA_LA 
insert into testeaza_la values(5, 1);
insert into testeaza_la values(16, 1);
insert into testeaza_la values(44, 1);
insert into testeaza_la values(33, 1);
insert into testeaza_la values(5, 2);
insert into testeaza_la values(16, 2);
insert into testeaza_la values(44, 2);
insert into testeaza_la values(33, 2);
insert into testeaza_la values(13, 4);
insert into testeaza_la values(5, 3);
insert into testeaza_la values(16, 3);
insert into testeaza_la values(33, 3);
-------------

--------FABRICA
insert into fabrica values(10, 'Ferrari Factory', 'Via Abetone Inferiore', 30);
insert into fabrica values(11, 'Red Bull Racing Factory', 'Bradbourne Dr MK7 8BJ', 31);
insert into fabrica values(12, 'Mercedes AMG Petronas Factory', 'Operations Centre NN13 7BD', 32);
insert into fabrica values(13, 'Prema Racing Factory', 'Via Alcide de Gasperi', 40);
insert into fabrica values(14, 'Techeetah Factory', 'Jiajin Expy', 60);
select * from componente;
---------------

------COMPONENTE
insert into componente values(10, 'Motor Ferrari', 9999999, 10);
insert into componente values(20, 'Transmisie RB', 100000, 11);
insert into componente values(30, 'Sistem Suspensie MAMG', 400000, 12);
insert into componente values(11, 'Frane SF2000', 80000, 10);
insert into componente values(21, 'Motor RB', 8000000, 11);
----------------

update campionat set pret_abonament = 9.99 where id_campionat = 1;
delete from locatie where id_locatie = 11;
select nume_campionat
from campionat c, echipa e
where c.id_campionat = e.id_campionat and e.nume_echipa = 'Scuderia Ferrari';

select nume_campionat
from campionat c join echipa e on c.id_campionat = e.id_campionat
                join pilot p on e.id_echipa = p.id_echipa;

select * from fabrica;

select count(*), id_echipa
from pilot
group by id_echipa;

create table info_user
    (utilizator VARCHAR2(30),
     nume_bd VARCHAR2(30),
     eveniment VARCHAR2(20),
     nume_obiect VARCHAR2(30),
     data DATE);



create or replace trigger ex12
    after create or drop or alter on schema
begin
    insert into info_user values(sys.login_user, sys.database_name,
    sys.sysevent, sys.dictionary_obj_name, sysdate);
end;

select 
to_char(to_date('01-JAN-12','dd-mon-yy'),'mm') from dual;

create or replace trigger ex10
    before insert or update or delete on pilot
begin
    if to_char(sysdate,'mm') > 3 and to_char(sysdate,'mm') < 10 then
        if inserting then
            raise_application_error(-20000, 'Nu se pot insera piloti noi in timpul sezonului');
        end if;
        
        if updating then
            raise_application_error(-20001, 'Nu se pot actualiza informatii despre piloti in timpul sezonului');
        end if;
        
        if deleting then
            raise_application_error(-20002, 'Nu se pot sterge piloti in timpul sezonului');
        end if;
    end if;
end;

create or replace trigger ex11
    before insert or update on echipa
    for each row
declare
    bug echipa.buget%type;
    nc campionat.nume_campionat%type;
begin
    bug := :NEW.buget;
    
    select nume_campionat into nc
    from campionat 
    where id_campionat = :NEW.id_campionat;
    
    if nc = 'Formula 1' then
        if bug < 50000 or bug > 300000 then
            raise_application_error(-20003, 'Bugetul echipei nu se incadreaza in limitele impuse de Formula 1');
        end if;
    elsif nc = 'Formula 2' then
        if bug < 10000 or bug > 50000 then
            raise_application_error(-20004, 'Bugetul echipei nu se incadreaza in limitele impuse de Formula 2');
        end if;
    end if;
    
end;

select 
to_char(sysdate,'mm') from dual;
 
insert into pilot values(6, 'Sebastian', 'Vettel', 'seb5@gmail.com', 100000.85, TO_DATE('2015/05/03', 'yyyy/mm/dd'),
                            5, 53, 121, 30);rollback;
                            drop trigger ex4;
 
CREATE SEQUENCE new_factory START WITH 50;

select c.id_pilot
from pilot p join concureaza_la c on p.id_pilot = c.id_pilot
where c.id_etapa = 1;
delete from echipa where id_echipa = 100;

select * from echipa;
rollback;
update pilot set id_echipa=31 where id_pilot = 33;
select id_echipa, titluri_castigate
from echipa
where titluri_castigate in (select max(titluri_castigate)
                            from echipa
                            );