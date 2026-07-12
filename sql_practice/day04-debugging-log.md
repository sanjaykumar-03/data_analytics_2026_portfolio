# Day 4 Debugging Log

## Bug 1

**Broken Query**

```sql
SELECT pclass, sex, AVG(fare)
FROM titanic
GROUP BY pclass;
```



** Issue:**

`sex` is in the SELECT list but is neither aggregated nor included in the GROUP BY clause.

**Correct Query**

```sql
SELECT pclass,
       sex,
       AVG(fare) AS avg_fare
FROM titanic
GROUP BY pclass, sex;
```

**Category:**
Missing column in GROUP BY

---

## Bug 2

**Broken Query**

```sql
SELECT pclass,
       COUNT(*) AS total
FROM titanic
WHERE COUNT(*) > 200
GROUP BY pclass;
```


** Issue:**

Aggregate functions like `COUNT()` cannot be used in the `WHERE` clause because `WHERE` executes before `GROUP BY`.

**Correct Query**

```sql
SELECT pclass,
       COUNT(*) AS total
FROM titanic
GROUP BY pclass
HAVING COUNT(*) > 200;
```

**Category:**
WHERE vs HAVING

---

## Bug 3

**Broken Query**

```sql
SELECT name
       fare
FROM titanic;
```


**Issue:**

Missing comma between `name` and `fare`.

**Correct Query**

```sql
SELECT name,
       fare
FROM titanic;
```

**Category:**
Syntax error (missing comma)

---

## Bug 4

**Broken Query**

```sql
SELECT embarked,
       SUM(survived) AS survivors
FROM titanic
GROUP BY embarkd;
```



**Issue:**

Column name is misspelled (`embarkd` instead of `embarked`).

**Correct Query**

```sql
SELECT embarked,
       SUM(survived) AS survivors
FROM titanic
GROUP BY embarked;
```

**Category:**
Misspelled column name

---

## Bug 5

**Broken Query**

```sql
SELECT name,
       COALESCE(age, 'Unknown') AS age
FROM titanic;
```


**Issue:**

`age` is numeric, but `'Unknown'` is a string. Use a numeric replacement or convert the result to text if that's your goal.

**Correct Query**

```sql
SELECT name,
       COALESCE(age, 18) AS age
FROM titanic;
```

**Category:**
Data type mismatch