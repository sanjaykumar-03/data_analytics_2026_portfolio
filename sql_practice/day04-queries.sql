-- Q1: Show all female passengers.
SELECT *
FROM titanic
WHERE sex = 'female';

-- Q2: Show passengers who paid a fare greater than 50.
SELECT name, fare
FROM titanic
WHERE fare > 50;

-- Q3: Show passengers younger than 18 years.
SELECT name, age
FROM titanic
WHERE age < 18;

-- Q4: Show male passengers in First Class.
SELECT name, sex, pclass
FROM titanic
WHERE sex = 'male'
  AND pclass = 1;

-- Q5: Show passengers who boarded from Southampton or Cherbourg.
SELECT name, embarked
FROM titanic
WHERE embarked IN ('S', 'C');

-- Q6: Show the top 10 passengers who paid the highest fare.
SELECT name, fare
FROM titanic
ORDER BY fare DESC
LIMIT 10;

-- Q7: Show the next 10 highest fares (pagination example).
SELECT name, fare
FROM titanic
ORDER BY fare DESC
LIMIT 10 OFFSET 10;

-- Q8: Find the average passenger age.
SELECT ROUND(AVG(age), 2) AS average_age
FROM titanic;

-- Q9: Find the total number of survivors.
SELECT SUM(survived) AS total_survivors
FROM titanic;

-- Q10: Count passengers in each passenger class.
SELECT pclass,
       COUNT(*) AS total_passengers
FROM titanic
GROUP BY pclass;

-- Q11: Find the average fare by passenger class and gender.
SELECT pclass,
       sex,
       ROUND(AVG(fare), 2) AS average_fare
FROM titanic
GROUP BY pclass, sex;

-- Q12: Show passenger classes having more than 200 passengers.
SELECT pclass,
       COUNT(*) AS total_passengers
FROM titanic
GROUP BY pclass
HAVING COUNT(*) > 200;

-- Q13: Find duplicate ticket numbers.
SELECT ticket,
       COUNT(*) AS occurrences
FROM titanic
GROUP BY ticket
HAVING COUNT(*) > 1;

-- Q14: Replace missing cabin values with 'Unknown'.
SELECT name,
       COALESCE(NULLIF(cabin, ''), 'Unknown') AS cabin
FROM titanic;

-- Q15: Show survival rate for each age group.
SELECT
    CASE
        WHEN age < 18 THEN 'Child'
        WHEN age BETWEEN 18 AND 59 THEN 'Adult'
        WHEN age >= 60 THEN 'Senior'
        ELSE 'Unknown'
    END AS age_group,
    COUNT(*) AS total_passengers,
    SUM(survived) AS total_survivors,
    ROUND((SUM(survived) * 100.0) / COUNT(*), 2) AS survival_rate
FROM titanic
GROUP BY age_group
ORDER BY survival_rate DESC;