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

> **Data blocks** are the smallest unit of I/O in the database. One data block corresponds to a specific number of bytes of physical space on the disk. The size of the data block can be set at the time of database creation. 
> 
> The default size of 8 KB is adequate for most databases.
> - If your database supports a data warehouse application that has large tables and indexes, a larger block size may be beneficial. 
> - If your database supports a transactional application in which reads and writes are random, specifying a smaller block size may be beneficial. 

![segments,extents and blocks](http://4.bp.blogspot.com/_4aO57QMQCR0/STN82pBQRjI/AAAAAAAAAD0/gQHsnZ5_XOA/w1200-h630-p-k-no-nu/segment_extent_block.JPG)

> - An extent consists of contiguous data blocks, which means that each extent can exist only in one data file.
> - Database objects such as tables and indexes are stored as segments in tablespaces. Each segment contains one or more extents.
> - A database is divided into logical storage units called tablespaces, which group related logical structures or data files together. 
> - One or more data files are explicitly created for each tablespace to physically store the data of all segments in a tablespace. A tablespace’s data file can be physically stored on any supported storage technology. 

![table space and data files](https://i.stack.imgur.com/zf8RK.png) ![oracle database server architecture overview](https://cdn.thegeekdiary.com/wp-content/uploads/2019/05/Oracle-Database-Server-Architecture-memory-structures-768x468.png)

> A database is divided into tablespaces (logical storage units used to group related logical structures). One or more data files are explicitly created for each tablespace to physically store the data of all logical structures in a tablespace. 
> 
> Tablespace 1, composed of two data files. A segment of 128 KB size, composed of two extents is spanning the two data files. The first extent of size 64 KB is in the first data file and the second extent, also of size 64 KB is in the second data file. Both extents are formed from contiguous 8 KB Oracle blocks. 
> 
> *Note: You can also create bigfile tablespaces, which have only one file that is often very large. The file may be any size up to the maximum that the row ID architecture permits. Traditional smallfile tablespaces (default) may contain multiple data files, but the files cannot be as large.*
> 
> `SYSTEM` and `SYSAUX` tablespaces are mandatory tablespaces that are created at the time of database creation. They must be onine.
> - the `SSTEM` tablespacce is used for core functionality (for example, data dictionary tables)
> - the axiliary `SYSAUX` tablespace is used for additional database components.
> - the `SYSTEM` and `SYSAUX` tablespaces should not be used for application data.
> 
> Each Oracle database must contain a `SYSTEM` tablespace and a `SYSAUX` tablespace. They are automatically created when the database is created. A tablespace can be online (accessible) or offline (not accessible). 
> 
> The SYSTEM tablespace is always online when the database is open. It stores tables that support the core functionality of the database, such as the data dictionary tables. 
> 
> The SYSAUX tablespace is an auxiliary tablespace to the SYSTEM tablespace. 
> 
> *Note: The SYSAUX tablespace may be taken offline to perform tablespace recovery, whereas this is not possible for the SYSTEM tablespace*

- when the server starts the oracle mount the database and all of the database is available.
- each database have its control file. Without the control file it can't open the attached database.
- **PGA** program global area
- **SGA** system global area
![oracle database storage architecture](https://2.bp.blogspot.com/-PnJbbedG8jU/WJb5GsdelFI/AAAAAAAAWGQ/Zo03svC71V4bW8sRz2_mFMI635yp7Af2QCLcB/w1200-h630-p-k-no-nu/Oracle-Architecture-11g-In-Detailed.jpg)

> There are three major structures in Oracle Database server architecture: memory structures, process structures, and storage structures. A basic Oracle database system consists of an Oracle database and a database instance. 
> 
> The instance consists of memory structures and background processes associated with that instance. Every time an instance is started, a shared memory area called the System Global Area (SGA) is allocated and the background processes are started. 
> 
> After starting a database instance, the Oracle software associates the instance with a specific database. This is called mounting the database. The database is then ready to be opened, which makes it accessible to authorized users. 
 
![database storage architecture](https://cdn.thegeekdiary.com/wp-content/uploads/2019/05/Oracle-Database-Storage-Architecture.png)

> The files that comprise an Oracle database are as follows: 
> - **Control files:** Each database has one unique control file that contains data about the database itself. The control file is critical to the database. Without the control file, the database cannot be opened. 
> - **Data files:** Contain the user or application data of the database, as well as metadata and the data dictionary 
> - **Online redo log files:** Allow for instance recovery of the database. If the database server crashes and does not lose any data files, the instance can recover the database with the information in these files. 

**System Global Area (SGA):** is shared by all server and background processes. Examples: cached data blocks and shared SQL areas. 

**Program Global Areas (PGA):** A PGA is nonshared memory created by Oracle Database when a server or background process is started. Access to the PGA is exclusive to the server or to the background process. Each server process and background process has its own PGA. 

> **Process architecture**
> 
> - **User process:** is the application or tool that connects to the oracle database.
> - **database process:**
>   - server process: connects to the oracle instanceadn is started when a user estabilishes a session
>   - background process: are started when an oracle instance is started
> - **daemon/application process:** network listeners and grid infrastructure daemons
 
When a user runs an application program or an Oracle tool such as `SQL*Plus`, the term user process is used to refer to the user’s application. The user process may or may not be on the database server machine. 

Oracle Database also creates a server process to execute the commands issued by the user process.

In addition, the Oracle server also has a set of background processes for an instance that interact with each other and with the operating system to manage the memory structures, asynchronously perform I/O to write data to disk, and perform other required tasks.

![interacting with oracle database memory](https://image3.slideserve.com/6392087/interacting-with-an-oracle-database-memory-processes-and-storage-l.jpg)

### Oracle database configuration
> 
> 1. An instance has started on a node where Oracle Database is installed (host or database server). 
> 2. A user starts an application spawning a user process. The application attempts to establish a connection to the server. (local, client/server, or a three-tier connection from a middle tier.) 
> 3. The server runs a listener that has the appropriate Oracle Net Services handler. The listener detects the connection request from the application and creates a dedicated server process on behalf of the user process. 
> 4. The user runs a DML-type SQL statement and commits the transaction. 
> 5. The server process receives the statement and checks the shared pool (an SGA component) that contains an identical SQL statement. If a shared SQL area is found, the server process checks the user’s access privileges to the requested data, and the existing shared SQL area is used to process the statement. If a shared SQL area is not found, a new shared SQL area is allocated for the statement so that it can be parsed and processed. 

### DB transactions
> - A transaction is a program unit whose execution may or may not change the contents of a database. 
> - The transaction is executed as a single unit 
> - If the database operations do not update the database but only retrieve data, this type of transaction is called a read-only transaction. 
> - A successful transaction can change the database from one CONSISTENT STATE to another 
DBMS transactions must be atomic, consistent, isolated and durable
>
> *Let’s take an example of a simple transaction: Suppose a bank employee transfers 500 HUF from A's account to B's account. This very simple and small transaction involves several low-level tasks*
> 
> ***A’s Account***
> ```` SQL
> Open_Account(A) 
> Old_Balance = A.balance 
> New_Balance = Old_Balance - 500 
> A.balance = New_Balance 
> Close_Account(A) 
> ````
>
> ***B’s Account***
> ``` SQL
> Open_Account(B)
> Old_Balance = B.balance
> New_Balance = Old_Balance + 500
> B.balance = New_Balance 
> Close_Account(B) 
> ```
> 
> A transaction in a database system must maintain Atomicity, Consistency, Isolation, and Durability − commonly known as ACID properties − in order to ensure accuracy, completeness, and data integrity.

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


