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

CREATE TABLE etapa(
    id_etapa number(3) PRIMARY KEY,
    nume_etapa varchar2(50),
    data_etapa date,
    id_campionat number(3) references campionat(id_campionat) on delete cascade
);

CREATE TABLE concureaza_la(
    id_pilot number(4) NOT NULL,
    id_etapa number(3) NOT NULL,
    FOREIGN KEY (id_pilot) references pilot(id_pilot),
    FOREIGN KEY (id_etapa) references etapa(id_etapa),
    UNIQUE (id_pilot, id_etapa)
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
insert into echipa values(30, 'Scuderia Ferrari', 200000.85, 16, 1);
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

-------ETAPA
insert into etapa values(1, 'Italian GP', TO_DATE('06/09/2020', 'dd/mm/yyyy'), 1);
insert into etapa values(2, 'Hungarian GP', TO_DATE('19/06/2020', 'dd/mm/yyyy'), 1);
insert into etapa values(3, 'Belgian GP', TO_DATE('30/08/2020', 'dd/mm/yyyy'), 1);
insert into etapa values(11, 'Bahrain2 GP', TO_DATE('29/11/2020', 'dd/mm/yyyy'), 2);
insert into etapa values(41, 'Antofagasta Santiago E-Prix', TO_DATE('16/01/2021', 'dd/mm/yyyy'), 4);
------------

----CONCUREAZA_LA 
insert into concureaza_la values(5, 1);
insert into concureaza_la values(16, 1);
insert into concureaza_la values(44, 1);
insert into concureaza_la values(33, 1);
insert into concureaza_la values(5, 2);
insert into concureaza_la values(16, 2);
insert into concureaza_la values(44, 2);
insert into concureaza_la values(33, 2);
insert into concureaza_la values(13, 41);
insert into concureaza_la values(5, 3);
insert into concureaza_la values(16, 3);
insert into concureaza_la values(33, 3);
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

select * from componente;

--6--
--Pentru campionatul cu cele mai putine echipe(!=0), inserati o noua echipa cu bugetul 10000 si id 100 si stergeti echipa cu cel mai mic buget din campionatul
-- cu cele mai multe echipe. Afisati modificarile.

create or replace procedure ex6
    is
        type camp is table of campionat.id_campionat%TYPE INDEX BY PLS_INTEGER;
        lista camp;   
        min_buget echipa.buget%type;
        min_cnt number:=10;
        max_cnt number:=0;
        cnt number;
        id_min_camp campionat.id_campionat%type;
        id_max_camp campionat.id_campionat%type;
        id_e echipa.id_echipa%type;
        
    begin
        select id_campionat
        bulk collect into lista
        from campionat;
        
        for i in 1..lista.count loop
            select count(*) into cnt
            from echipa
            where id_campionat = lista(i);
            
            if cnt < min_cnt and cnt != 0 then
                min_cnt := cnt;
                id_min_camp := lista(i);
            end if;

            if cnt > max_cnt then
                max_cnt := cnt;
                id_max_camp := lista(i);
                select min(buget) into min_buget
                from echipa
                where id_campionat = lista(i);
            end if;
        end loop;
        
        insert into echipa values(100, 'EX6 RACING', 10000, 0, id_min_camp);
        dbms_output.put_line('A fost inserata echipa in campionatul cu id ' || id_min_camp);
        
        select id_echipa into id_e
        from echipa
        where id_campionat = id_max_camp and buget = min_buget;
        
        delete from echipa where id_echipa = id_e;
        dbms_output.put_line('A fost stearsa echipa cu id-ul ' || id_e);
        
end ex6;

begin
    ex6;
end;

----------------------------------------------------

--7--
create or replace procedure ex7
    is
        cursor c is 
            select id_fabrica, nume_fabrica
            from fabrica;
        
        cursor d(param number) is
            select pret_prod
            from componente
            where id_fabrica = param;
        suma number;
    begin
        for i in c loop
            DBMS_OUTPUT.PUT_LINE('-------------------------------------');
            DBMS_OUTPUT.PUT_LINE ('FABRICA: '|| i.nume_fabrica);
            suma := 0;
            for k in d(i.id_fabrica) loop
                suma := suma+k.pret_prod;
            end loop;
            DBMS_OUTPUT.PUT_LINE ('PRET TOTAL: '|| suma);
            DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        end loop;
        
end ex7;

begin
    ex7;
end;

-----------------------------------

--8--
--Pentru un pilot dat ca parametru sa se returneze numarul victoriilor al tuturor pilotilor din campionatul in care concureaza.(+exceptii)

create or replace function ex8(v_last_name pilot.last_name%type) return number
    is
        type echipe is table of echipa.id_echipa%TYPE INDEX BY PLS_INTEGER;
        lista echipe;     
        id_e pilot.id_echipa%type;
        nume campionat.nume_campionat%type;
        total number := 0;
        id_camp campionat.id_campionat%type;
        ok number;
    begin
        select id_echipa into id_e
        from pilot
        where last_name = v_last_name;
        
        select c.id_campionat into id_camp
        from echipa e join campionat c on e.id_campionat = c.id_campionat
        where e.id_echipa = id_e;
        
        select id_echipa 
        bulk collect into lista
        from echipa
        where id_campionat = id_camp;
        
        for i in (select id_echipa, victorii 
                    from pilot) loop
            ok := 0;
            for j in 1..lista.count loop
                if i.id_echipa = lista(j) then
                    ok := 1;
                end if;
                exit when ok = 1;
            end loop;
            if ok = 1 then
                total := total + i.victorii;
            end if;
        end loop; 
        
        return total;         
        
        EXCEPTION
            WHEN NO_DATA_FOUND THEN 
            DBMS_OUTPUT.PUT_LINE ('Nu exista pilot cu acest nume');
            return -1;
            
            WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE ('Exista mai multi piloti cu acest nume');
            return -2;
        
        
end;

begin
    DBMS_OUTPUT.PUT_LINE (ex8('Vettel'));
end;

select * from echipa;
delete from echipa where id_echipa = 100;

--------------------------------------------------
--Pentru un nume dat de etapa, sa se transfere pilotul cu cel mai mic salariu care a concurat la etapa, la echipa cu cele mai multe titluri castigate cu un salariu dublu,
--(bugetul echipei va fi scazut cu noul salariu), iar pentru echipa care a pierdut pilotul sa se construiasca o noua fabrica cu jumatate din banii repartizati fostului pilot
--9--
create or replace procedure ex9(v_nume_etapa etapa.nume_etapa%type)
    is
        id_et etapa.id_etapa%type;
        type piloti is table of pilot.id_pilot%TYPE INDEX BY PLS_INTEGER;
        lista piloti;
        min1 number:= 999999;
        minteam echipa.id_echipa%type;
        id_pilot_min pilot.id_pilot%type;
        id_echipa_min pilot.id_echipa%type;
        id_echipa_max pilot.id_echipa%type;
        titles echipa.titluri_castigate%type;
        sal pilot.salary%type;
        team echipa.id_echipa%type;
    begin
    
    select id_etapa into id_et
    from etapa
    where nume_etapa = v_nume_etapa;
    
    select id_pilot
    bulk collect into lista
    from concureaza_la
    where id_etapa = id_et;
    
    for i in 1..lista.count loop
        select salary, id_echipa into sal, team
        from pilot
        where id_pilot = lista(i);
        
        if sal < min1 then
            min1 := sal;
            minteam := team;
            id_pilot_min := lista(i);
        end if;
    end loop;
    
    select id_echipa, titluri_castigate into id_echipa_max, titles
    from echipa
    where titluri_castigate in (select max(titluri_castigate)
                                from echipa);
                            
    update pilot set id_echipa = id_echipa_max,
                     salary = salary * 2,
                     hire_date = SYSDATE,
                     contract = 1
                where id_pilot = id_pilot_min;
    
    select salary into sal
    from pilot 
    where id_pilot = id_pilot_min;
    
    update echipa set buget = buget - sal where id_echipa = id_echipa_max;
    
    insert into fabrica values(new_factory.nextval, 'New Factory', 'New Street', minteam);
    
    update echipa set buget = buget + sal/4 where id_echipa = minteam;
   
    EXCEPTION 
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Nu exista etapa cu acest nume');
end ex9;

begin
    ex9('Italian GP');
end;

CREATE SEQUENCE new_factory START WITH 50;

select c.id_pilot
from pilot p join concureaza_la c on p.id_pilot = c.id_pilot
where c.id_etapa = 1;
delete from echipa where id_echipa = 100;

select * from pilot;
rollback;
update pilot set id_echipa=31 where id_pilot = 33;