CREATE TABLE campionat(
    id_campionat number(3) PRIMARY KEY,
    nume_campionat varchar2(50),
    website varchar2(30),
    pret_abonament number(4,3)
);

CREATE TABLE echipa(
    id_echipa number(3) PRIMARY KEY,
    
);

drop table campionat;
insert into campionat values (1, 'Formula 1', 'www.formula1.com', 5.99);

select * from campionat;