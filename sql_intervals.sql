CREATE TABLE Temp AS SELECT salary, TS, TE FROM random_02 WHERE name=0;

SELECT DISTINCT F.salary, F.TS, L.TE 
FROM Temp AS F, Temp AS L 
WHERE F.salary = L.salary AND F.TS < L.TE 
AND NOT EXISTS(
SELECT * 
  FROM Temp AS M 
  WHERE M.salary = F.salary AND F.TS < M.TS AND M.TS < L.TE 
  AND NOT EXISTS (
    SELECT * FROM Temp AS T1 
    WHERE T1.salary = F.salary AND T1.TS < M.TS AND M.TS <= T1.TE
  )
) 
AND NOT EXISTS(
  SELECT * FROM Temp AS T2 
  WHERE T2.salary = F.salary
  AND ((T2.TS < F.TS AND F.TS <= T2.TE) OR (T2.TS <= L.TE and L.TE < T2.TE)));