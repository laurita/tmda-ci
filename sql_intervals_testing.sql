--CREATE TABLE Temp AS SELECT name, TS, TE FROM random_02 WHERE;

CREATE TABLE empl_hist (
empno  INTEGER,
name INTEGER,
title  CHAR(20),
deptno CHAR(3),
tstart INTEGER,
tend   INTEGER
);

INSERT INTO empl_hist
VALUES(1001, 60000, 'Engineer', 'd01', 01, 06);
INSERT INTO empl_hist
VALUES(1001, 70000, 'Engineer', 'd01', 06, 10);
INSERT INTO empl_hist
VALUES(1001, 70000, 'Sr Engineer', 'd02', 10, 14);
INSERT INTO empl_hist
VALUES (1001, 70000, 'Tech Leader', 'd02', 14, 24);

CREATE TABLE temp AS
SELECT empno AS name, Tstart AS TS, Tend AS TE
FROM empl_hist
WHERE Empno = 1001;

SELECT DISTINCT F.name, F.TS, L.TE 
FROM Temp AS F, Temp AS L 
WHERE F.name = L.name AND F.TS < L.TE 
AND NOT EXISTS(
  SELECT * 
  FROM Temp AS M 
  WHERE M.name = F.name AND F.TS < M.TS AND M.TS < L.TE 
  AND NOT EXISTS (
    SELECT * FROM Temp AS T1 
    WHERE T1.name = F.name AND T1.TS < M.TS AND M.TS <= T1.TE
  )
) 
AND NOT EXISTS(
  SELECT * FROM Temp AS T2 
  WHERE T2.name = F.name
  AND ((T2.TS < F.TS AND F.TS <= T2.TE) OR (T2.TS <= L.TE and L.TE < T2.TE)));