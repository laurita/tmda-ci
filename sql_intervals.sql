CREATE TABLE Temp AS SELECT salary, TS, TE FROM random_02 WHERE name=0;

SELECT E1.Name, Salary, Title, E1.Start, E1.Stop 
FROM Employee1 AS E1, Employee2 AS E2 WHERE E1.Name = E2.Name
AND E2.Start <= E1.Start AND E1.Stop <= E2.Stop UNION
SELECT E1.Name, Salary, Title, E1.Start, E2.Stop FROM Employee1 AS E1, Employee2 AS E2 WHERE E1.Name = E2.Name
AND E1.Start > E2.Start AND E2.Stop < E1.Stop AND E1.Start < E2.Stop UNION
SELECT E1.Name, Salary, Title, E2.Start, E1.Stop FROM Employee1 AS E1, Employee2 AS E2 WHERE E1.Name = E2.Name
AND E2.Start > E1.Start AND E1.Stop < E2.Stop AND E2.Start < E1.Stop UNION
SELECT E1.Name, Salary, Title, E2.Start, E2.Stop FROM Employee1 AS E1, Employee2 AS E2 WHERE E1.Name = E2.Name
AND E2.Start >= E1.Start AND E2.Stop <= E1.Stop