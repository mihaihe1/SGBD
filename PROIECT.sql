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

CREATE TABLE oras(
    id_oras number(3) PRIMARY KEY,
    nume_oras varchar2(40)
);

CREATE TABLE locatie(
    id_locatie number(3) PRIMARY KEY,
    nume_locatie varchar2(40),
    strada varchar2(40),
    id_oras number(3) references oras(id_oras)
);

CREATE TABLE componente(
    id_comp number(4) PRIMARY KEY,
    nume_comp varchar2(30),
    pret_prod number(10, 3),
    id_echipa number(3) references echipa(id_echipa),
    id_locatie number(3) references locatie(id_locatie)
);

drop table pilot;
insert into campionat values (1, 'Formula 1', 'www.formula1.com', 5.99);
insert into campionat values (2, 'Formula 2', 'www.formula2.com', 2.99);
insert into echipa values(30, 'Scuderia Ferrari', 200000.85, 16, 1);
insert into echipa values(31, 'Scuderia Ferrari2', 200000.85, 16, 2);
insert into pilot values(5, 'Sebastian', 'Vettel', 'seb5@gmail.com', 100000.85, TO_DATE('2015/05/03', 'yyyy/mm/dd'),
                            5, 53, 121, 30);
insert into etapa values(1, 'Italian GP', TO_DATE('2019/09/08', 'yyyy/mm/dd'), 1);
insert into concureaza_la values(5, 1);
insert into oras values(1, 'Maranello');
insert into locatie values(10, 'Ferrari Factory', 'Via Abetone Inferiore', 1);
insert into componente values(10, 'Motor Ferrari', 9999999, 30, 10);
select * from componente;
delete from componente where id_comp = 10;
select nume_campionat
from campionat c, echipa e
where c.id_campionat = e.id_campionat and e.nume_echipa = 'Scuderia Ferrari';

select nume_campionat
from campionat c join echipa e on c.id_campionat = e.id_campionat
                join pilot p on e.id_echipa = p.id_echipa;
                