# Adatbazis és Big Data technologiák

- telepítési tmutató: http://analog.nik.uni-obuda.hu/Labor-VPC/12cR2/Oracle_12c_utmutato.pdf
  - VM player innen: https://www.vmware.com/products/workstation-player/workstation-player-evaluation.html
- telepítendő [Oracle Database 12c](https://www.oracle.com/database/12c-database/): http://analog.nik.uni-obuda.hu/Labor-VPC/12cR2/Oracle_12c.7z

**Régi jegyzetek egyben:**
- elémélet: https://github.com/gabboraron/adatb-ea, https://people.inf.elte.hu/kiss/12ab2osz/Adatbazisok_2.pdf
  - régi adatb2 diasor: https://people.inf.elte.hu/molnarba/Adatb%e1zis2/ 
  - youtube előadás sorozat: https://www.youtube.com/playlist?reload=9&list=PLj4u_BOoK8OAFO0NZ3CkNRPOIe0gA98Ip
- relációs algebra összefoglaló: https://github.com/gabboraron/adatb_gyakorlas_zh1
  - elmélet: [Lekérdezés](https://github.com/gabboraron/zarovizsga/blob/master/29%20-%20Adatbazisok%20-%20lekerdezes%20es%20idoszerusites%20(Bognar%20Balint%2C%202011).pdf), [Adatmodellezés](https://github.com/gabboraron/zarovizsga/blob/master/28%20-%20Adatbazisok%20-%20adatmodellezes%20(Bognar%20Balint%2C%202011).pdf)
- SQL lekérdezések és táblaműveletek:
  - alapok: https://github.com/gabboraron/adatb_gy2
  - descartes szorzat és lekérdezéések egybeágyazásának kivédése : https://github.com/gabboraron/adatb_gy3
  - group by | sysdate | round | group by | Relációs algebra összefoglaló | Kiterjesztett relációs algebra kezdet https://github.com/gabboraron/adatb_gy4
  - natural join | group by | having | order by | kiterjesztett relációs algebra https://github.com/gabboraron/adatb_gy5
  - create table | tábla létrehozás | idegen kulcs | nézettábla | sorok törlése | sor beszúrás |sor módosítás  https://github.com/gabboraron/adatb_gy6
  - PLSQL alapok  https://github.com/gabboraron/adatb_gy7
  - ACCEPT | KURZOROK | név nélküli blokk | függvény | procedure | módosítás | módosítás kurzorral https://github.com/gabboraron/adatb_gy8
  - módosítás | módosítás kurzorral | törlés | növelés https://github.com/gabboraron/adatb_gy9
- Tutorialspoint SQL Tutorial: https://www.tutorialspoint.com/sql/index.htm

# EA1
Schema: hr/hr

`Entity`
> unique real world thing
> - Logical
> - Objects
> - `Entity instance`: one specific member of an entity type

`Data Model Elements`
> `Attribute`
> - piece of information that describes an Entity
> - multiple atributes: `Product{Name,price,instock}`
> 
> `Relationship`: how entities depend on or connect to each other
> 
> `Entity key`: 
> - A property or a set of properties of an entity that are used to determine identity
> - The properties that make up an entity key are chosen at design time.
> - The values of entity key properties must uniquely identify an entity instance
> - The key value should not be modified

![ER diagram](https://beginnersbook.com/wp-content/uploads/2015/04/E-R-Diagram.png) ![relationship types](https://www.calebcurry.com/wp-content/uploads/2018/08/options2.png)

## Conceptual data model
- Identifies entities and the highest level relation between entities
- No attributes specified

## Logical data model
- Describes HOW the system will be implemented, regardless of the DBMS
- Includes all entities and relationships among them.
- All attributes for each entity are specified.
- The primary key for each entity is specified.
- Foreign keys (keys identifying the relationship between different entities) are specified.
- Normalization occurs at this level.

## Physical data model
- Describes HOW the system will be implemented using a specific DBMS
- Specifies the tables and the columns.
- Foreign keys are used to identify relationships between tables.
- Denormalization may occur based on user requirements.
- Physical considerations may cause the physical data model to be quite different from the logical data model.

## Transforming ER model into relational model 
- In relational database design, a many-to-many relationship is not allowed. 
- Need to break apart the many-to-many relationship into two one-to-many relationships.
- Using a third table, commonly called a “join table
- Each record in the “join table” would have the foreign key fields of the two tables it is joining together. 
- Join table has at least two columns, holding Primary keys from the tables it joins.
- Can have additional columns, holding properties of the relationship

## Database normalization
> - Normalization the process of organizing data in a database that includes creating tables and establishing relationships between the tables 
> - Process is used to help eliminate redundant data
- Normalization forms:
  - 1NF		Eliminate Repeating Groups
  - 2NF		Eliminate Redundant Data
  - 3NF		Eliminate Columns Not Dependent on Key
  - BCNF		Only key dependency exists

### First Normal Form  (1NF) 
http://www.gitta.info/LogicModelin/en/html/DataConsiten_Norm1NF.html
> This rule defines that all the attributes in a relation must have atomic domains. The values in an atomic domain are indivisible units:
> - Eliminate repeating groups in individual tables
> - Create separate table for each set of related data
> - Identify each set of related data with primary key
>
> Do not use multiple fields in a single table to store similar data
> 
> **Primary key**
> 
> A primary key is a candidate key that is most appropriate to be the main reference key for the table. 
> - It is used to help establish relationships with other tables.
> - Always choose a single simple key over a composite key if possible

![1st normal form](http://www.gitta.info/LogicModelin/en/image/1NF.gif)

### Second Normal Form  (2NF) 
http://www.gitta.info/LogicModelin/en/html/DataConsiten_Norm2NF.html
> For a table to be in 2NF, there are two requirements:
> - The database is in first normal form 
> - All nonkey attributes in the table must be functionally dependent on the entire primary key
> 
> *Note: Remember that we are dealing with non-key attributes*

![2nd nf](http://www.gitta.info/LogicModelin/en/image/2NF.gif)

#### 2NF - Decomposition
https://www.slideshare.net/raiuniversity/bsc-cs-iidbmsuivnormalization
> 1. If a data item is fully functionally dependent on only a part of the primary key, move that data item and that part of the primary key to a new table.
> 2. If other data items are functionally dependent on the same part of the key, place them in the new table also
> 3. Make the partial primary key copied from the original table the primary key for the new table. Place all items that appear in the repeating group in a new table

If there is a table with columns `A,B,C,D ` with `Primary Key (A,B)` & `D` is dependant on `A` (alone) then to be `2NF`, you should reduce (split) tables as:
- Table with columns `A,D` with  `Primary Key (A)`
- Table with columns `A,B,C` with  `Primary Key (A,B)`

![2nf decomp](https://image.slidesharecdn.com/bsccs-ii-dbms-u-iv-normalization-150317025645-conversion-gate01/95/bsc-cs-iidbmsuivnormalization-15-638.jpg?cb=1426561931)

### Third normal form (3NF)
http://www.gitta.info/LogicModelin/en/html/DataConsiten_Norm3NF.html
> For a table to be in 3NF, there are two requirements
> - The table should be in 2NF
> - There can be no interdependencies among non-key attributes
> 
> In the Book Schema Third Normal Form is violated since a non-key field is dependent on another non-key field and is transitively dependent on the primary key. 

![3nf](http://www.gitta.info/LogicModelin/en/image/3NF.gif)

#### 3NF - Decomposition
> 1. Move all interdependent non-key items to a new entity.
> 2. Identify a primary key for the new entity.
> 3. Place the primary key for the new entity as a foreign key on the original entity. 

If there is a table with columns `A,B,C` with `Primary Key (A)` and `C` is dependant on `B (B -> C)` then to be 3NF, the tables become:
- Table with columns `B,C` with `Primary Key (B)`
- Table with fields `A,B` with `Primary Key (A)`, and `Foreign Key (B)` 

![3nf decomp](https://image.slidesharecdn.com/bsccs-ii-dbms-u-iv-normalization-150317025645-conversion-gate01/95/bsc-cs-iidbmsuivnormalization-18-638.jpg?cb=1426561931)









# EA2
**alap SQL parancsok:** https://www.c-sharpcorner.com/blogs/types-of-sql-statements-with-example#:~:text=SQL%20statements%20are%20categorized%20into,TCL%20(TRANSACTION%20CONTROL%20LANGUAGE)

![adatbázis szerkezet](https://anuragpandeydba.files.wordpress.com/2017/12/logical_structure.png?w=636)

![table space and data files](https://i.stack.imgur.com/zf8RK.png) ![oracle database server architecture overview](https://cdn.thegeekdiary.com/wp-content/uploads/2019/05/Oracle-Database-Server-Architecture-memory-structures-768x468.png)
- when the server starts the oracle mount the database and all of the database is available.
- each database have its control file. Without the control file it can't open the attached database.
- **PGA** program global area
- **SGA** system global area
![oracle database storage architecture](https://2.bp.blogspot.com/-PnJbbedG8jU/WJb5GsdelFI/AAAAAAAAWGQ/Zo03svC71V4bW8sRz2_mFMI635yp7Af2QCLcB/w1200-h630-p-k-no-nu/Oracle-Architecture-11g-In-Detailed.jpg)

![interacting with oracle database memory](https://image3.slideserve.com/6392087/interacting-with-an-oracle-database-memory-processes-and-storage-l.jpg)

## HR tábla

> job id
```SQL
select distinct job_id from employees
```

> department name
```SQL
select department_name from departments where exists
(select department_id from departments);
```

[**Hierarchical querry**](https://docs.oracle.com/cd/B19306_01/server.102/b14200/queries003.htm)
> connect the parrent row with it's child row
```SQL
select last_name, employee_id, manager_id
from employees
start with employee_id = 100
connect by PRIOR EMPLOYEE_ID= MANAGER_ID
order SIBLINGS by last_name;
```
> kimenet: last_name, employee id, manager_id oszlopok
```SQL
select last_name "employee", 
connect_by_root last_name "manager",
sys_connect_by_path(last_name, '/') "path"
from employees
start with employee_id = 100
connect by PRIOR EMPLOYEE_ID= MANAGER_ID;
```
> kimenet: employee, maanger, path


> **hurkokkal csak óvatosan, könnyen előidézhetőek!**
```SQL
with T as 
(
select 'john' employee, 'jack' manager from dual
union
select 'jack' employee, 'john' manager from dual
)
select employee, manager
from T
CONNECT by prior employee = manager;
```

**DB transactions** [stackowerflow](https://stackoverflow.com/questions/974596/what-is-a-database-transaction)

> **WITH Clause : Subquery Factoring in Oracle**
>
> https://oracle-base.com/articles/misc/with-clause
> 
> set near each employee how many people are in their department
```SQL
with dept_count as 
(select department_id, COUNT(*) as dept_c
from employees
group by DEPARTMENT_ID)
select last_name, dept_c
from EMPLOYEES e, dept_count dc
where e.department_id = dc.department_id;
```

# EA3
> **B fa**
> 
> https://regi.tankonyvtar.hu/hu/tartalom/tamop425/0046_algoritmusok/ch06s07.html
> 
> ![B-fák](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3MIgYySEs1tCl9Uq1rU4qXZG0h5q1SSELwg&usqp=CAU)
> 
> ![indexelt b-fa](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYuSvHqM-y83JM2D2UcLmHwVgZYzN500WHYA&usqp=CAU)
> 
> ![sql processing](https://docs.oracle.com/database/121/TGSQL/img/GUID-476CEA3E-17B5-454F-AD82-CF3FC19D81B1-default.gif)
> 
> ![cost based optimization](https://docs.oracle.com/database/121/TGSQL/img/GUID-D0B38295-1289-42A5-94CC-4F1857D00835-default.png)
> 
> **syntax check**: typo error
> **semantic check**: wheter the meaning is bad, when a column not eexist or something same
> **shared pool check**: determine if it can skip resource-intensive part
> 
> ![sql parsing sharerd pool check  - cont](https://docs.oracle.com/database/121/TGSQL/img/GUID-B288E97D-C133-479F-B3DE-97576412FCFB-default.gif)
> 
> **execution plan**
> - each step returns row set
> -
>  
> ![row source tree](https://docs.oracle.com/database/121/TGSQL/img/GUID-CFA4215E-0CDC-4355-9722-FCF16C6CEAB7-default.gif)

```SQL
explain plan for 
select last_name, salary from employees where salay > 4000;

select * from table(dbms_xplan.display);
```

> sor kiejölése után `F10`-el futtatjuk a `explain plan`-t
```SQL
explain plan for 
select last_name, salary from employees where employee_id > 190;

select * from table(dbms_xplan.display);
```

```SQL
explain plan for 
select * from employees where employee_id > 190;

select * from table(dbms_xplan.display);
```

> number of rows:
```SQL
select count (*)
```

# EA 4
execution plan:
- operation
- object name/name
- cardinality/rows
- cost
- reading out the ordering  of the operations from the plan: we have to start in the root, which is the `SELECT` operation, then we go from the inside out from right to left 

## `JOIN`
combines output from exactly two row sources, such as tables or views
### nested loop
> two nested `for` loops
> 
> - the database joins small subset of data, or the database joins large sets of data with optimizer mode set to `first_rows`

### hash join
- relativeli large amount of data is joined
- the join is an [equi join](https://www.w3resource.com/sql/joins/perform-an-equi-join.php)

![hash join](https://courses.cs.washington.edu/courses/csep544/14wi/video/archive/html5/csep544_14wi_5/slide47.jpg)

cost = building hash table + reading hash table

### sort/merge join
- the join condition between two tables is not an equijoin, that is uses an inequality condition such as < = > or >=
- in contrast to sort merges, hash joins require an equality condition
- because of sorts reqquired by other operations, the optimizer finds it cheeper to use a sort merge


## 
````SQL

select * from employees;
select * from table(dbms_xplan,display);
explain plan for
select first_name, last_name, job_id
from EMPLOYEES where JOB_ID='AD_VP';

select column_name, histogram
from user_tab_col_statistics
where table_name='EMPLOYEES'

select endpoint_number, endpoint_valuse
from user_
````


