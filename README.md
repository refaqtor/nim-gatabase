# Gatabase

![screenshot](https://raw.githubusercontent.com/juancarlospaco/nim-gatabase/master/gatabase.png "Compile-Time ORM for Nim")

![screenshot](https://raw.githubusercontent.com/juancarlospaco/nim-gatabase/master/temp.jpg "Compile-Time ORM for Nim")


# Use

- Gatabase is designed as 1 simplified [Strong Static Typed](https://en.wikipedia.org/wiki/Type_system#Static_type_checking) [Compile-Time](https://wikipedia.org/wiki/Compile_time) [SQL](https://wikipedia.org/wiki/SQL) [DSL](https://wikipedia.org/wiki/Domain-specific_language) [Sugar](https://en.wikipedia.org/wiki/Syntactic_sugar). Nim mimics SQL. ~1000 LoC.
- Gatabase syntax is almost the same as SQL syntax, [no new ORM to learn ever again](https://pgexercises.com/questions/basic/selectall.html), any [SQL WYSIWYG is your GUI](https://pgmodeler.io/screenshots).
- You can literally [copy&paste a SQL query from StackOverflow](https://stackoverflow.com/questions/tagged/postgresql?tab=Frequent) to Gatabase and with few tiny syntax tweaks is running.
- SQL is Minified when build for Release, Pretty-Printed when build for Debug. It can be assigned to `let` and `const`.


### Support

- All SQL standard syntax is supported.
- ✅ `--` Human readable comments, multi-line comments produce multi-line SQL comments, requires [Stropping](https://en.wikipedia.org/wiki/Stropping_(syntax)#Modern_use).
- ✅ `COMMENT`, Postgres-only.
- ✅ `UNION`, `UNION ALL`.
- ✅ `INTERSECT`, `INTERSECT ALL`.
- ✅ `EXCEPT`, `EXCEPT ALL`, requires [Stropping](https://en.wikipedia.org/wiki/Stropping_(syntax)#Modern_use).
- ✅ `CASE` with multiple `WHEN` and 1 `ELSE` with correct indentation, requires [Stropping](https://en.wikipedia.org/wiki/Stropping_(syntax)#Modern_use).
- ✅ `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, `FULL JOIN`.
- ✅ `OFFSET`.
- ✅ `LIMIT`.
- ✅ `FROM`, requires [Stropping](https://en.wikipedia.org/wiki/Stropping_(syntax)#Modern_use).
- ✅ `WHERE`, `WHERE NOT`, `WHERE EXISTS`, `WHERE NOT EXISTS`.
- ✅ `ORDER BY`.
- ✅ `SELECT`, `SELECT *`, `SELECT DISTINCT`.
- ✅ `SELECT TOP`, `SELECT MIN`, `SELECT MAX`, `SELECT AVG`, `SELECT SUM`, `SELECT COUNT`.
- ✅ `DELETE FROM`.
- ✅ `LIKE`, `NOT LIKE`.
- ✅ `BETWEEN`, `NOT BETWEEN`.
- ✅ `HAVING`.
- ✅ `INSERT INTO`.
- ✅ `IS NULL`, `IS NOT NULL`.
- ✅ `UPDATE`.
- ✅ `SET`, requires [Stropping](https://en.wikipedia.org/wiki/Stropping_(syntax)#Modern_use).

Intentionally not supported:
- Deep nested SubQueries are not supported, because KISS.
- `TRUNCATE`, because is the same as `DELETE FROM` without a `WHERE`.
- `CREATE TABLE` and `DROP TABLE`, is left to the user.


# Install

- [`nimble install gatabase`](https://nimble.directory/pkg/gatabase "nimble install gatabase 👑 https://nimble.directory/pkg/gatabase")


### Comments

```sql
-- SQL Comments are supported, but stripped when build for Release. This is SQL.
```
 ⬆️ SQL ⬆️ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ⬇️ Nim ⬇️
```nim
`--` "SQL Comments are supported, but stripped when build for Release. This is Nim."
```


### SELECT & FROM

```sql
SELECT *
FROM sometable
```
 ⬆️ SQL ⬆️ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ⬇️ Nim ⬇️
```nim
select '*'
`from` "sometable"
```

---

```sql
SELECT somecolumn
FROM sometable
```
 ⬆️ SQL ⬆️ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ⬇️ Nim ⬇️
```nim
select "somecolumn"
`from` "sometable"
```

---

```sql
SELECT DISTINCT somecolumn
```
 ⬆️ SQL ⬆️ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ⬇️ Nim ⬇️
```nim
selectdistinct "somecolumn"
```


### MIN & MAX

```sql
SELECT MIN(somecolumn)
```
 ⬆️ SQL ⬆️ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ⬇️ Nim ⬇️
```nim
selectmin "somecolumn"
```

---

```sql
SELECT MAX(somecolumn)
```
 ⬆️ SQL ⬆️ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ⬇️ Nim ⬇️
```nim
selectmax "somecolumn"
```


### COUNT & AVG & SUM

```sql
SELECT COUNT(somecolumn)
```
 ⬆️ SQL ⬆️ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ⬇️ Nim ⬇️
```nim
selectcount "somecolumn"
```

---

```sql
SELECT AVG(somecolumn)
```
 ⬆️ SQL ⬆️ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ⬇️ Nim ⬇️
```nim
selectavg "somecolumn"
```

---

```sql
SELECT SUM(somecolumn)
```
 ⬆️ SQL ⬆️ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ⬇️ Nim ⬇️
```nim
selectsum "somecolumn"
```


### TOP

```sql
SELECT TOP 5 *
```
 ⬆️ SQL ⬆️ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ⬇️ Nim ⬇️
```nim
selecttop "5"
```


### WHERE

```sql
SELECT somecolumn
FROM sometable
WHERE power > 9000
```
 ⬆️ SQL ⬆️ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ⬇️ Nim ⬇️
```nim
select "somecolumn"
`from` "sometable"
where "power > 9000"
```


### LIMIT & OFFSET

```sql
OFFSET 9
LIMIT 42
```
 ⬆️ SQL ⬆️ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ⬇️ Nim ⬇️
```nim
offset 9
limit 42
```


### INSERT

```sql
INSERT INTO person
VALUES (42, 'Nikola Tesla', true, 'nikola.tesla@nim-lang.org', 9.6)
```
 ⬆️ SQL ⬆️ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ⬇️ Nim ⬇️
```nim
insertinto "person"
values (42, "Nikola Tesla", true, "nikola.tesla@nim-lang.org", 9.6)
```


### DELETE

```sql
DELETE debts
```
 ⬆️ SQL ⬆️ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ⬇️ Nim ⬇️
```nim
delete "debts"
```


### ORDER BY

```sql
ORDER BY ASC
```
 ⬆️ SQL ⬆️ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ⬇️ Nim ⬇️
```nim
orderby "asc"
```

---

```sql
ORDER BY DESC
```
 ⬆️ SQL ⬆️ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ⬇️ Nim ⬇️
```nim
orderby "desc"
```


### UPDATE

```sql
UPDATE tablename
SET key0 = value0, key1 = value1
```
 ⬆️ SQL ⬆️ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ⬇️ Nim ⬇️
```nim
update "tablename"
`set` {"key0": "value0", "key1": "value1"}
```


### CASE

```sql
CASE
  WHEN foo > 10 THEN 9
  WHEN bar < 42 THEN 5
  ELSE 0
END
```
 ⬆️ SQL ⬆️ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ⬇️ Nim ⬇️
```nim
`case` {"foo > 10": "9", "bar < 42": "5", "default": "0"}
```


### COMMENT

```sql
COMMENT ON TABLE myTable IS 'This is an SQL COMMENT on a TABLE'
```
 ⬆️ SQL ⬆️ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ⬇️ Nim ⬇️
```nim
commentontable {"myTable": "This is an SQL COMMENT on a TABLE"}
```

---

```sql
COMMENT ON COLUMN myColumn IS 'This is an SQL COMMENT on a COLUMN'
```
 ⬆️ SQL ⬆️ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ⬇️ Nim ⬇️
```nim
commentontable {"myColumn": "This is an SQL COMMENT on a COLUMN"}
```

---

```sql
COMMENT ON DATABASE myDatabase IS 'This is an SQL COMMENT on a DATABASE'
```
 ⬆️ SQL ⬆️ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ⬇️ Nim ⬇️
```nim
commentondatabase {"myDatabase": "This is an SQL COMMENT on a DATABASE"}
```


### GROUP BY

```sql
GROUP BY country
```
 ⬆️ SQL ⬆️ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ⬇️ Nim ⬇️
```nim
groupby "country"
```


### JOIN

```sql
FULL JOIN tablename
```
 ⬆️ SQL ⬆️ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ⬇️ Nim ⬇️
```nim
fulljoin "tablename"
```

---

```sql
INNER JOIN tablename
```
 ⬆️ SQL ⬆️ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ⬇️ Nim ⬇️
```nim
innerjoin "tablename"
```

---

```sql
LEFT JOIN tablename
```
 ⬆️ SQL ⬆️ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ⬇️ Nim ⬇️
```nim
leftjoin "tablename"
```

---

```sql
RIGHT JOIN tablename
```
 ⬆️ SQL ⬆️ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ⬇️ Nim ⬇️
```nim
rightjoin "tablename"
```


### HAVING

```sql
HAVING beer > 5
```
 ⬆️ SQL ⬆️ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ⬇️ Nim ⬇️
```nim
having "beer > 5"
```


### UNION

```sql
UNION ALL
```
 ⬆️ SQL ⬆️ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ⬇️ Nim ⬇️
```nim
union true
```

---

```sql
UNION
```
 ⬆️ SQL ⬆️ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ⬇️ Nim ⬇️
```nim
union false
```


### INTERSECT

```sql
INTERSECT ALL
```
 ⬆️ SQL ⬆️ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ⬇️ Nim ⬇️
```nim
intersect true
```

---

```sql
INTERSECT
```
 ⬆️ SQL ⬆️ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ⬇️ Nim ⬇️
```nim
intersect false
```


### EXCEPT

```sql
EXCEPT ALL
```
 ⬆️ SQL ⬆️ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ⬇️ Nim ⬇️
```nim
`except` true
```

---

```sql
EXCEPT
```
 ⬆️ SQL ⬆️ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ⬇️ Nim ⬇️
```nim
`except` false
```


### IS NULL

```sql
IS NULL
```
 ⬆️ SQL ⬆️ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ⬇️ Nim ⬇️
```nim
isnull true
```

---

```sql
IS NOT NULL
```
 ⬆️ SQL ⬆️ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ⬇️ Nim ⬇️
```nim
isnull false
```


### Wildcards

- Nim `'*'` ➡️ SQL `*`.
- Nim `'?'` ➡️ SQL `?`.
- No other `char` is needed.


# Anti-Obfuscation

Gatabase wont like Obfuscation, its code is easy to read and similar to Pretty-Printed SQL. [`nimpretty` friendly](https://nim-lang.github.io/Nim/tools.html). Very [KISS](https://en.wikipedia.org/wiki/KISS_principle).

**Compiles Ok:**
```nim
let variable = query Sql:
  select  '*'
  `from`  "clients"
  groupby "country"
  orderby "desc"
```

**Fails to Compile:**

- `let variable = query Sql: select('*') from("clients") groupby("country") orderby("desc")`
- `let variable = query Sql: '*'.select() "clients".from() "country".groupby() "desc".orderby()`
- `let variable = query Sql: select '*' from "clients" groupby "country" orderby "desc"`
- `let variable = query Sql:select'*' from"clients" groupby"country" orderby"desc"`

*This helps on big projects where each developer tries to use a different code style.*


# Your data, your way

Nim has `template` is like a literal copy&paste of code in-place with no performance cost,
that allows you to create your own custom ORM function callbacks on-the-fly,
like the ones used on scripting languages.

```nim
template getMemes(): string =
  result = query getValue:
    select "url"
    `from` "memes"
    limit 1
```

Then you do `getMemes()` when you need it❕. The API that fits your ideas.

From this `MyClass.meta.Session.query(Memes).all().filter().first()` to this `getMemes()`.


# For Python Devs

Remember on Python2 you had like `print "value"`?, on Nim you can do the same for any function,
then we made functions to mimic basic standard SQL, like `select "value"` and it worked,
its Type-Safe and valid Nim code, you have an ORM that gives you the freedom and power,
this allows to support interesting features, like `CASE`, `UNION`, `COMMENT`, etc.

When you get used to `template` it requires a lot less code to do the same than SQLAlchemy.


```python
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
from sqlalchemy import create_engine, MetaData, Table
from sqlalchemy import Column, Integer, String, Boolean, Float

engine = create_engine("sqlite:///:memory:", echo=False)
engine.execute("""
  create table if not exists person(
    id      integer     primary key,
    name    varchar(9)  not null unique,
    active  bool        not null default true,
    rank    float       not null default 0.0
  ); """
)


meta = MetaData()
persons = Table(
  "person", meta,
  Column("id", Integer, primary_key = True),
  Column("name", String, nullable = False, unique = True),
  Column("active", Boolean, nullable = False, default = True),
  Column("rank", Float, nullable = False, default = 0.0),
)


conn = engine.connect()


ins = persons.insert()
ins = persons.insert().values(id = 42, name = "Pepe", active = True, rank = 9.6)
result = conn.execute(ins)


persons_query = persons.select()
result = conn.execute(persons_query)
row = result.fetchone()

print(row)

```
 ⬆️ CPython 3 + SQLAlchemy ⬆️ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ⬇️ Nim 1.0 + Gatabase ⬇️
```nim
import db_sqlite, gatabase

let db = open(":memory:", "", "", "")
db.exec(sql"""
  create table if not exists person(
    id      integer     primary key,
    name    varchar(9)  not null unique,
    active  bool        not null default true,
    rank    float       not null default 0.0
  ); """)


query Exec:
  insertinto "person"
  values (42, "Pepe", true, 9.6)


let row = query GetRow:
  select '*'
  `from` "person"

echo row
```


# Smart SQL Syntax Checking

It will perform a SQL Syntax checking at compile-time. Examples here Fail **intentionally**:

```nim
discard query Sql:
  where "failure"
```

Fails to compile as expected, with a friendly error:
```
gatabase.nim(48, 16) WHERE without SELECT nor INSERT nor UPDATE nor DELETE.
```


```nim
discard query Sql:
  delete "users"
```

Compiles but prints a friendly warning:
```
gatabase.nim(207, 57) Warning: DELETE FROM without WHERE
```


# Output

ORM Output is choosed from `GatabaseOutput` [`enum` type](https://nim-lang.github.io/Nim/manual.html#types-enumeration-types), MetaProgramming generates different output code. Examples:

- `query Func:` generates 1 [anonymous inlined function](https://nim-lang.github.io/Nim/manual.html#procedures-anonymous-procs) `( func (): SqlQuery = ... )`.
- `query Prepared:` generates 1 Postgres Stored Procedure of [`SqlPrepared` type](https://nim-lang.github.io/Nim/db_postgres.html#parameter-substitution).
- `query TryExec:` generates code for 1 [`tryExec()` function](https://nim-lang.github.io/Nim/db_postgres.html#tryExec%2CDbConn%2CSqlQuery%2Cvarargs%5Bstring%2C%5D), etc etc etc.
- Compile using `-d:dev` for Debugging of the generated SQL.

See `nim doc gatabase.nim`, `runnableExamples`, [examples folder](https://github.com/juancarlospaco/nim-gatabase/tree/master/examples), [tests folder](https://github.com/juancarlospaco/nim-gatabase/tree/master/tests), [Std Lib db_postgres](https://nim-lang.github.io/Nim/db_postgres.html) for more documentation.


### Tests

```console
$ nimble test

[Suite] Gatabase ORM Tests
  [OK] let   INSERT INTO
  [OK] let   SELECT ... FROM ... WHERE
  [OK] let   SELECT ... (comment) ... FROM ... COMMENT
  [OK] let   SELECT ... FROM ... LIMIT ... OFFSET
  [OK] let   INSERT INTO
  [OK] let   UNION ALL ... ORBER BY ... IS NOT NULL
  [OK] let   SELECT DISTINCT ... FROM ... WHERE
  [OK] const INSERT INTO
  [OK] const SELECT ... FROM ... WHERE
  [OK] const SELECT ... (comment) ... FROM ... COMMENT
  [OK] const SELECT ... FROM ... LIMIT ... OFFSET
  [OK] const INSERT INTO
  [OK] const UNION ALL ... ORBER BY ... IS NOT NULL
  [OK] const INTERSECT ALL
  [OK] const EXCEPT ALL
  [OK] const SELECT DISTINCT ... FROM ... WHERE
  [OK] var   CASE
  [OK] var   SELECT MAX .. WHERE EXISTS ... OFFSET ... LIMIT ... ORDER BY
  [OK] var   DELETE FROM WHERE
```

- Tests use a real database SQLite on RAM `":memory:"` with a `"person"` table. +20 Tests.


# Requisites

- **None.** _(You need a working Postgres server up & running to use it, but not to install it)_


# FAQ

<details>

- This is not an ORM ?.

[Wikipedia defines ORM](https://en.wikipedia.org/wiki/Object-relational_mapping) as:

> Object-relational mapping in computer science is a programming technique for converting
> data between incompatible type systems using object-oriented programming languages.

Feel free to contribute to Wikipedia.

- Supports SQLite ?.

Yes.

- Supports MySQL ?.

No.

- Will support MySQL someday ?.

No.

- Supports Mongo ?.

No.

- Will support Mongo someday ?.

No.

- How is Parameter substitution done ?.

It does NOT make Parameter substitution internally, its delegated to standard library.

- This works with Synchronous code ?.

Yes.

- This works with Asynchronous code ?.

Yes.

- SQLite mode dont support some stuff ?.

We try to keep as similar as possible, but SQLite is very limited.

</details>


[  ⬆️  ⬆️  ⬆️  ⬆️  ](#Gatabase "Go to top")
