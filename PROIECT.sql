--Hernest Mihai 242--

----------4----------

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
    id_fabrica number(3) references fabrica(id_fabrica) on delete cascade
);

CREATE TABLE info_useri
    (utilizator VARCHAR2(30),
     nume_bd VARCHAR2(30),
     eveniment VARCHAR2(20),
     nume_obiect VARCHAR2(30),
     data DATE);

-------------5--------------------

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
---------------

------COMPONENTE
insert into componente values(10, 'Motor Ferrari', 9999999, 10);
insert into componente values(20, 'Transmisie RB', 100000, 11);
insert into componente values(30, 'Sistem Suspensie MAMG', 400000, 12);
insert into componente values(11, 'Frane SF2000', 80000, 10);
insert into componente values(21, 'Motor RB', 8000000, 11);
----------------

------------6-----------------

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

        insert into echipa values(id_echipe.nextval, 'EX6 RACING', 10000, 0, id_min_camp); 

        dbms_output.put_line('A fost inserata echipa in campionatul cu id ' || id_min_camp); 

        select id_echipa into id_e 
        from echipa 
        where id_campionat = id_max_camp and buget = min_buget;  

        dbms_output.put_line('Echipa cu cel mai mic buget are id-ul ' || id_e);    

end ex6; 
/

----------7--------------------

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
/

---------------------8----------------------

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
/

-----------------9-------------------

create or replace procedure ex9(v_nume_tara tara.nume_tara%type) 
    is 
        id_tr tara.id_tara%type; 
        type circuite is table of circuit.id_circuit%type index by pls_integer; 
        id_c circuite; 
        type piloti is table of pilot.id_pilot%TYPE INDEX BY PLS_INTEGER; 
        lista piloti; 
        nr_spec number; 
        max_spec number := 0; 
        id_c_max circuit.id_circuit%type; 
        min1 number:= 999999; 
        minteam echipa.id_echipa%type; 
        id_pilot_min pilot.id_pilot%type; 
        id_echipa_min pilot.id_echipa%type; 
        id_echipa_max pilot.id_echipa%type; 
        titles echipa.titluri_castigate%type; 
        sal pilot.salary%type; 
        team echipa.id_echipa%type; 
        exceptie EXCEPTION; 
    begin 

    select id_tara into id_tr 
    from tara 
    where nume_tara = v_nume_tara;    

    select id_circuit bulk collect into id_c 
    from circuit 
    where id_tara = id_tr; 

    for i in 1..id_c.count loop 
        select nr_spectatori into nr_spec 
        from circuit 
        where id_circuit = id_c(i); 

        if nr_spec > max_spec then 
            max_spec := nr_spec; 
            id_c_max := id_c(i); 
        end if; 
    end loop; 

    select id_pilot 
    bulk collect into lista 
    from testeaza_la 
    where id_circuit = id_c_max; 

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
    if minteam = id_echipa_max then 
        raise exceptie; 
    end if;                     

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
            DBMS_OUTPUT.PUT_LINE('Nu exista tara cu acest nume'); 
        WHEN exceptie THEN 
            DBMS_OUTPUT.PUT_LINE('Echipa la care trebuie transferat pilotul corespunde cu echipa actuala'); 

end ex9;
/

----------10----------------
create or replace trigger ex10
    before insert or update or delete on pilot
begin
    if to_char(sysdate,'mm') >= 1 and to_char(sysdate,'mm') < 10 then
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
/

---------------11---------------
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
/
----------------12------------
create or replace trigger ex12
    after create or drop or alter on schema
begin
    insert into info_useri values(sys.login_user, sys.database_name, 
    sys.sysevent, sys.dictionary_obj_name, sysdate);
end;
/
---------------- 13 ---------------------
create or replace package pachet_proiect as
    procedure ex6;
    
    procedure ex7;
    
    function ex8(v_last_name pilot.last_name%type) return number;
    
    procedure ex9(v_nume_etapa etapa.nume_etapa%type);
end pachet_proiect;
/

------------------13---------------------

create or replace package pachet_proiect as
    procedure ex6;
    
    procedure ex7;
    
    function ex8(v_last_name pilot.last_name%type) return number;
    
    procedure ex9(v_nume_tara tara.nume_tara%type);
end pachet_proiect;
/

create or replace package body pachet_proiect as
    procedure ex6 
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

        insert into echipa values(id_echipe.nextval, 'EX6 RACING', 10000, 0, id_min_camp); 

        dbms_output.put_line('A fost inserata echipa in campionatul cu id ' || id_min_camp); 

        select id_echipa into id_e 
        from echipa 
        where id_campionat = id_max_camp and buget = min_buget;  

        dbms_output.put_line('Echipa cu cel mai mic buget are id-ul ' || id_e);    

end ex6; 
    
    procedure ex7
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

    function ex8(v_last_name pilot.last_name%type) return number 
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

    procedure ex9(v_nume_tara tara.nume_tara%type) 
    is 
        id_tr tara.id_tara%type; 
        type circuite is table of circuit.id_circuit%type index by pls_integer; 
        id_c circuite; 
        type piloti is table of pilot.id_pilot%TYPE INDEX BY PLS_INTEGER; 
        lista piloti; 
        nr_spec number; 
        max_spec number := 0; 
        id_c_max circuit.id_circuit%type; 
        min1 number:= 999999; 
        minteam echipa.id_echipa%type; 
        id_pilot_min pilot.id_pilot%type; 
        id_echipa_min pilot.id_echipa%type; 
        id_echipa_max pilot.id_echipa%type; 
        titles echipa.titluri_castigate%type; 
        sal pilot.salary%type; 
        team echipa.id_echipa%type; 
        exceptie EXCEPTION; 
    begin 

    select id_tara into id_tr 
    from tara 
    where nume_tara = v_nume_tara;    

    select id_circuit bulk collect into id_c 
    from circuit 
    where id_tara = id_tr; 

    for i in 1..id_c.count loop 
        select nr_spectatori into nr_spec 
        from circuit 
        where id_circuit = id_c(i); 

        if nr_spec > max_spec then 
            max_spec := nr_spec; 
            id_c_max := id_c(i); 
        end if; 
    end loop; 

    select id_pilot 
    bulk collect into lista 
    from testeaza_la 
    where id_circuit = id_c_max; 

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
    if minteam = id_echipa_max then 
        raise exceptie; 
    end if;                     

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
            DBMS_OUTPUT.PUT_LINE('Nu exista tara cu acest nume'); 
        WHEN exceptie THEN 
            DBMS_OUTPUT.PUT_LINE('Echipa la care trebuie transferat pilotul corespunde cu echipa actuala'); 

end ex9; 

end pachet_proiect;

begin
    ex9('Italia');
    DBMS_OUTPUT.PUT_LINE(ex8('Leclerc'));
    --pachet_proiect.ex6;
    --pachet_proiect.ex7;
    --DBMS_OUTPUT.PUT_LINE(pachet_proiect.ex8('Vettel'));
    --pachet_proiect.ex9('Italia');
end;
/

select * from pilot;
rollback;
delete from fabrica where nume_fabrica = 'New Factory';
delete from echipa where nume_echipa = 'EX6 RACING';
update pilot set salary = 20000, id_echipa = 31 where id_pilot = 33;
