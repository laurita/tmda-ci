drop table E;

create table E (n char(5), c integer, d char(5), p char(3),
                h integer, s integer, f integer, t integer);

insert into E values ('Jan', 140, 'DB', 'P1', 1800, 1200, 200301, 200406);
insert into E values ('Jan', 163, 'DB', 'P1', 600,  1200, 200410, 200412);
insert into E values ('Ann', 141, 'DB', 'P2', 1200, 1500, 200301, 200308);
insert into E values ('Ann', 150, 'DB', 'P1', 1500, 1500, 200309, 200406);
insert into E values ('Ann', 157, 'DB', 'P1', 900,  1500, 200407, 200412);
insert into E values ('Sue', 142, 'DB', 'P2', 240,  800,  200301, 200312);
insert into E values ('Tom', 143, 'AI', 'P2', 1500, 2000, 200301, 200306);
insert into E values ('Tom', 153, 'AI', 'P1', 1200, 2000, 200401, 200406);

select a.d, a.f, min(b.t)
from (select r1.d, f from (select d from e) as r1, (select d, f from e) as r2 where r1.d <> r2.d
      union
      select r1.d, f from (select d from e) as r1, (select d, t+1 as f from e) as r2 where r1.d <> r2.d
     ) as a,
     (select r1.d, t from (select d from e) as r1, (select d, t from e) as r2 where r1.d <> r2.d
      union
      select r1.d, t from (select d from e) as r1, (select d, f-1 as t from e) as r2 where r1.d <> r2.d
     ) as b
where a.d = b.d
and a.f < b.t
and exists (select * from e where e.d <> a.d and e.f <= a.f and a.f <= e.t)
group by a.d, a.f;

select a.name, a.TS, min(b.TE)
from (select r1.name, TS from (select name from random_2000) as r1, (select name, TS from random_2000) as r2 where r1.name <> r2.name
      union
      select r1.name, TS from (select name from random_2000) as r1, (select name, TE+1 as TS from random_2000) as r2 where r1.name <> r2.name
     ) as a,
     (select r1.name, TE from (select name from random_2000) as r1, (select name, TE from random_2000) as r2 where r1.name <> r2.name
      union
      select r1.name, TE from (select name from random_2000) as r1, (select name, TS-1 as TE from random_2000) as r2 where r1.name <> r2.name
     ) as b
where a.name = b.name
and a.TS < b.TE
and exists (select * from random_2000 where random_2000.name <> a.name and random_2000.TS <= a.TS and a.TS <= random_2000.TS)
group by a.name, a.TS;