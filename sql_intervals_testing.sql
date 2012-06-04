--CREATE TABLE Temp AS SELECT name, TS, TE FROM random_02 WHERE;

CREATE TABLE employee (
name  INTEGER,
salary INTEGER,
title  CHAR(20),
deptno CHAR(3),
start INTEGER,
stop   INTEGER
);

INSERT INTO employee
VALUES(1001, 60000, 'Engineer', 'd01', 01, 06);
INSERT INTO employee
VALUES(1001, 60000, 'Engineer', 'd01', 03, 08);
INSERT INTO employee
INSERT INTO employee
VALUES(1001, 70000, 'Engineer', 'd01', 06, 10);
INSERT INTO employee
VALUES(1001, 70000, 'Sr Engineer', 'd02', 10, 14);
INSERT INTO employee
VALUES (1001, 70000, 'Tech Leader', 'd02', 14, 24);

SELECT E1.Name, E1.Salary, E1.Title, E1.Start, E1.Stop 
FROM Employee AS E1, Employee AS E2 
WHERE E1.Name = E2.Name AND E1.Salary = E2.Salary
  AND E2.Start <= E1.Start AND E1.Stop <= E2.Stop 
UNION
SELECT E1.Name, E1.Salary, E1.Title, E1.Start, E2.Stop 
FROM Employee AS E1, Employee AS E2 
WHERE E1.Name = E2.Name AND E1.Salary = E2.Salary
  AND E1.Start > E2.Start AND E2.Stop < E1.Stop AND E1.Start < E2.Stop 
UNION
SELECT E1.Name, E1.Salary, E1.Title, E2.Start, E1.Stop 
FROM Employee AS E1, Employee AS E2 
WHERE E1.Name = E2.Name AND E1.Salary = E2.Salary
  AND E2.Start > E1.Start AND E1.Stop < E2.Stop AND E2.Start < E1.Stop 
UNION
SELECT E1.Name, E1.Salary, E1.Title, E2.Start, E2.Stop 
FROM Employee AS E1, Employee AS E2 
WHERE E1.Name = E2.Name AND E1.Salary = E2.Salary
  AND E2.Start >= E1.Start AND E2.Stop <= E1.Stop;