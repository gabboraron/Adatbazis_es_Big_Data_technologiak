# Adatbazis és Big Data technologiák

> **! EZ CSAK A SAJÁT JEGYZETEM AZ ÓRÁKRÓL, SEMMILYEN ZÁRT INFORMÁCIÓT NEM TARTALMAZ !**

- telepítési útmutató: http://analog.nik.uni-obuda.hu/Labor-VPC/12cR2/Oracle_12c_utmutato.pdf
  - VM player innen: https://www.vmware.com/products/workstation-player/workstation-player-evaluation.html
- telepítendő [Oracle Database 12c](https://www.oracle.com/database/12c-database/): http://analog.nik.uni-obuda.hu/Labor-VPC/12cR2/Oracle_12c.7z

## Régi adatbázis jegyzetek egyben:
- elmélet: https://github.com/gabboraron/adatb-ea, https://people.inf.elte.hu/kiss/12ab2osz/Adatbazisok_2.pdf
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
## Data Dictionary
- In the case of Oracle Database, metadata is stored in the data dictionary
- Data dictionary: Central, read-only reference tables and views
- structure:
  - Base tables: database information; only the database can read and write
  - User-Accessible Views: Information displayed to users
  - All base tables and user-accessible views are in the SYS schema
- *example*: 
  - user_tables:
    - data from our own tables
    - which table space you are in, statistics, etc.
  - user_constraints:
    - data of our own constraints
    - name of the constraint, type to which field it applies, etc

## Index structure
- Extra structure in DB to speed up searches
- You can index multiple fields in a table
- An index can be built on multiple fields (composite index)
- Unique and non-unique index
- Main types:
  - B-tree index
  - Bitmap index
- CREATE INDEX SQL statement
- PK, unique constraint: automatic creation 

> **B tree**
> 
> https://regi.tankonyvtar.hu/hu/tartalom/tamop425/0046_algoritmusok/ch06s07.html
> 
> ![B-fák](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3MIgYySEs1tCl9Uq1rU4qXZG0h5q1SSELwg&usqp=CAU)
> 
> ![indexelt b-fa](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYuSvHqM-y83JM2D2UcLmHwVgZYzN500WHYA&usqp=CAU)

## SQL Processing
> SQL processing is the parsing, optimization, row source generation, and execution of a SQL statement.

 1. for example a user execute a statement so oracle gets a query
 2. syntax check       (is there any typo )
 3. semantic check    (tables and their columns should exist)
 4. shared pool check (was this query executed earlier)     
    - To this end, the database uses a hashing algorithm to generate a hash value for every SQL statement
    - hash value is sqlid (deterministic so same statement has the same hash  value/sqlid)
	  - *soft parse:* skip some interim steps like optimization, uses existing execution plan (sqlid should exist)
	  - *hard parse* within a timeframe generates multiple plans, compares them; each plan has a cost; cost computation takes account into factors such as I/O, CPU, network cost, memory usage and so on

![sql processing](https://docs.oracle.com/database/121/TGSQL/img/GUID-476CEA3E-17B5-454F-AD82-CF3FC19D81B1-default.gif)

## SQL Optimizer concepts, terms
> Query optimization is the overall process of choosing the most efficient means of executing a SQL statement.
> 
> SQL is a nonprocedural language, so the optimizer is free to merge, reorganize, and process in any order.
> 
> An execution plan describes a recommended method of execution for a SQL statement.
> 
> Each step either retrieves rows of data physically from the database or prepares them for the user issuing the statement.

The optimizer goal is to generate the most cost effective execution plan (final plan).How can Oracle do that?

Based on the existing table statistics histograms within a time frame
 1. Ganerates multiple plans
 2. Compares them
 3. Select the most cost effective plan as final plan

> **Cost:** In a given environment, the numerical value representing the estimated resource demand for the operation. The optimizer generates possible execution plans for an input SQL statement, uses statistics to estimate their costs, compares their costs, and then chooses the plan with the lowest cost.
> 
> ![cost based optimization](https://docs.oracle.com/database/121/TGSQL/img/GUID-D0B38295-1289-42A5-94CC-4F1857D00835-default.png)

## SQL parsing pool check
> **syntax check**: typo error
> **semantic check**: wheter the meaning is bad, when a column not eexist or something same
> **shared pool check**: determine if it can skip resource-intensive part
> 
> ![sql parsing sharerd pool check  - cont](https://docs.oracle.com/database/121/TGSQL/img/GUID-B288E97D-C133-479F-B3DE-97576412FCFB-default.gif)
> 
> **execution plan**
> - each step returns row set
> - row source can be a table, view, or result of a join or grouping operation
> - The row source generator is software that receives the optimal execution plan from the optimizer and produces an iterative execution plan. The iterative plan is a binary program that, when executed by the SQL engine, produces the result set. 
>  
> ![row source tree](https://docs.oracle.com/database/121/TGSQL/img/GUID-CFA4215E-0CDC-4355-9722-FCF16C6CEAB7-default.gif)
>
> An execution plan is a set of steps that the optimizer performs when executing a SQL statement and performing an operation.

### Access path
RowID: shows where the record is physically located (file, block)
- unique identifier for the record
Read a single record based on RowID
- very fast

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
# EA 5 - ZH
# EA 6 - Apache Cassandra, SQL in NoSql world
- https://afteracademy.com/blog/what-is-the-difference-between-dbms-and-rdbms
-[techterms.com/definition/rdbms](https://techterms.com/definition/rdbms#:~:text=Stands%20for%20%22Relational%20Database%20Management,format%2C%20using%20rows%20and%20columns.)

![sql to nosql](https://media-exp1.licdn.com/dms/image/C5112AQEKZTwVN0S-qA/article-cover_image-shrink_600_2000/0/1581239649079?e=1622073600&v=beta&t=RGw9mJKeghFAOH4p0peHh696dMfJllen7rsDiGzufYQ)

| pro        | con           | 
| ------------- |:-------------:|
| proven      | designed for single machines, hard to scale |
| reliable      | rigid schema |
| general purpose | locking issues|
| well known | expensive, the free options are for small projects |

Around 2006-2007 Amazon and google anounced their bigdata platforms:

![diamond vs bigtable](https://image.slidesharecdn.com/presentation-150407072702-conversion-gate01/95/dynamo-and-bigtable-review-and-comparison-15-638.jpg?cb=1428391898) ![who uses dimond and bigtable](https://img.stackshare.io/stackup/455614/amazon-dynamodb-vs-google-cloud-bigtable.png)

## what is NOSQL
- we do have SQL
- not only SQL
- graph databases are all about relations

![nosql usage](https://www.thorntech.com/wp-content/uploads/2019/01/SQLvsNoSQL.jpg)

**Main drivers:**
- flexible schema
- scalability

## Cassandra
code example: https://github.com/gabboraron/cassandra-workshop
- key-value store: the value can be any object or anything
- document store: hierarchical JSON structure
- column store: value is a map directory

> - Master-less architecture
> - Multi-DC support, active anywhere
> - Eventual consistency
> - Tunable consistency
> - Durability & Performance

![What is a Graph Database and Why Should You Care?](https://miro.medium.com/max/875/1*8Za0wYRVykspOTL2nSohng.png) ![A Comprehensive Analysis - NoSQL vs RDBMS](https://media-exp1.licdn.com/dms/image/C4E12AQHHQZ08-kG44w/article-inline_image-shrink_1000_1488/0/1520482861155?e=1622073600&v=beta&t=qfJ5taHLw62m2UZ2v_3XpxQRZz8rl7tzwv3goqd4MDM)
*more: https://www.linkedin.com/pulse/comprehensive-analysis-nosql-vs-rdbms-rassul-fazelat*

### Column store
![example](https://media-exp1.licdn.com/dms/image/C4E12AQHssul0rIFjcw/article-inline_image-shrink_1000_1488/0/1520201057315?e=1622073600&v=beta&t=GCA2mobhI6vNjMKb_LZTKovJxk8bPbVc3XFBURog03A)

- we start a column name in a row
- we can store huge number of rows, in cassandra 2 000 000
- map of maps 

### CQL
> Cassandra's SQL interface
> 
> https://cassandra.apache.org/doc/latest/cql/

demo code: https://github.com/gabboraron/cassandra-workshop/blob/main/demo/1-insert-update.md

**setting up the enviroment:**
- online
  1. register on https://labs.play-with-docker.com/ with that you have a 4 hour session
  2. `git clone https://github.com/gabboraron/cassandra-workshop.git`
  3. `cd cassandra-workshop`
  4. done
- offline
  1. install an onether VM or the [docker](https://www.docker.com/get-started)
  2. password for VM: OEnik123
  3. `git clone https://github.com/gabboraron/cassandra-workshop.git`
  4. `cd cassandra-workshop`
  5. done

**files/folders:**
- `cluster/`
  - `cluster/docker-compose.yml`: describes 2 nodes  
    ```Shell
    node1:
    image: cassandra:3.11
    ports:
      - "9042:9042"
      - "9160:9160"
    environment:
      CASSANDRA_CLUSTER_NAME: demo
      CASSANDRA_SEEDS: node1,node2
    volumes:
      - ./nobel:/nobel
    restart: unless-stopped
    
    node2:
    image: cassandra:3.11
    environment:
      CASSANDRA_CLUSTER_NAME: demo
      CASSANDRA_SEEDS: node1,node2
    restart: unless-stopped
    ```
  - `cluster/01-start.sh` start cluster
  - `cluster/99-stop.sh` stop cluster
  - `cluster/node1-shell.sh` open a session inside the docker container

**After start:** 
- `nodetool status` where you can see *status*: `Up` - `U`and a *state*: `normal` - `N`
- `cqlsh` - CQLshell, which gives an SQL like command line

#### Creating a Keyspace:
```
CREATE KEYSPACE demo
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};
USE demo;
```
#### Create table:
```SQL
CREATE TABLE user
(
  id int,
  name text,
  PRIMARY KEY (id)
);
```
Here the primary key is mandatory.

#### Upload table with records:
```CQL
INSERT INTO user (id, name)
VALUES ( 1, 'Ada Lovelace');
```

**Without autowarning, the cassanda rewrites the row, eith the same key!**
```CQL
INSERT INTO user (id, name)
VALUES ( 1, 'Charles Babbage');
```
We can check what is in database like in SQL:`SELECT * FROM user;`

**Also we don't get error if we *update* an non existing row, but the row become inserted:**
```CQL
UPDATE user
SET name = 'Linus Torvalds'
WHERE id = 2;
```
> Only specified columns are written, not the whole row.

#### CQL data types
https://docs.datastax.com/en/cql-oss/3.x/cql/cql_reference/cql_data_types_c.html
- Primitive types
  - int, tinyint, smallint, bigint
  - decimal, float, double
  - text (varchar), ascii
  - timestamp, date, time
  - uuid, timeuuid
  - blob
  - inet
- Collection types
  - list<T>
  - set<T>
  - map<TKey, Tvalue>

> Each collection element is mapped to a distinct cell in the underlying data structure.
>
> Frozen types are mapped to a single cell (serialized)

- User defined types
  ```CQL
  CREATE TYPE article
  (
    id int,
    name text,
    price decimal
  );
  
  CREATE TABLE invoice 
  (
    id int PRIMARY KEY,
    buyer text,
    items list<frozen<article>>
  );
  ```
more example: https://github.com/gabboraron/cassandra-workshop/blob/main/demo/2-data-types.md

##### User defined types
```CQL
CREATE TYPE article
(
  id int, 
  name text, 
  price decimal
);

CREATE TABLE invoice 
(
  id int PRIMARY KEY, 
  buyer text, 
  items list<frozen<article>>
);

INSERT INTO invoice (id, buyer, items) 
VALUES (1, 'Joe', [
  {id: 1, name: 'Book', price: 11.99}, 
  {id: 2, name: 'Computer', price: 3333}
]);

SELECT * FROM invoice;

UPDATE invoice 
SET items = items + [{id: 3, name: 'Cable', price: 1.00}] 
WHERE id = 1;

DELETE items[1] FROM invoice WHERE id = 1;
```

#### Architecture
> How can we create scalable databases?
> 
> NOSQL databases use horizontal partitioning, which let to dvidie talbes in different parts horizontally.
> 
> ![scale up vs scale out](https://miro.medium.com/max/750/0*AgVS92bhDliNs-dc.png)
 
*scale out example:*
```
original database: 

city		country		region
Lisbon		Portugal	Europe
London		UK		Europe
Seattle		US		N. America
L.A.		US		N. America
```
dvide by region, 1st table:
```
city		country		region
Lisbon		Portugal	Europe
London		UK		Europe
```

dvide by region, 2nd table:
```
city		country		region
Seattle		US		N. America
L.A.		US		N. America
```

#### Partitioning
> The `key` value is converted into `hash value` based on hash value the data is divided between nodes.
> 
> ![hash based database](https://www.scnsoft.com/blog-pictures/business-intelligence/cassandra-performance-2.png)
> 
> ##### virtual nodes
> https://www.datastax.com/blog/virtual-nodes-cassandra-12
> 
> ![virtual node](https://www.datastax.com/sites/default/files/inline-images/VNodes1.png)

#### Replication
> if we have more nodes than more nodes can solve our querry
> 
> - **resilience:** the more nodes we have the more likey some fail
> - **throughput:** mre replicas can serve more requests
> - **replication factor:** nr of nodes that store the data, 3 is a typical value in production
> - **replication strategy:** 
>   - simpleStrategy
>   - Network topology strategy 
>   
>   ![https://image.slidesharecdn.com/replicationandconsistencyincassandra-161004031236/95/replication-and-consistency-in-cassandra-what-does-it-all-mean-christopher-bradford-datastax-c-summit-2016-21-638.jpg?cb=1475600022](https://image.slidesharecdn.com/replicationandconsistencyincassandra-161004031236/95/replication-and-consistency-in-cassandra-what-does-it-all-mean-christopher-bradford-datastax-c-summit-2016-21-638.jpg?cb=1475600022)![https://image.slidesharecdn.com/replicationandconsistencyincassandra-161004031236/95/replication-and-consistency-in-cassandra-what-does-it-all-mean-christopher-bradford-datastax-c-summit-2016-17-638.jpg?cb=1475600022](https://image.slidesharecdn.com/replicationandconsistencyincassandra-161004031236/95/replication-and-consistency-in-cassandra-what-does-it-all-mean-christopher-bradford-datastax-c-summit-2016-17-638.jpg?cb=1475600022)
>   
> Network topology is better for data centers, where cassandra can optimize for rack's and computers.
> 
> Cassandra doesn't have master and slave replica, nodes are identical! Any replica can solve any querry, so this is an advantage for accelerate queries.
> 
> #### Multi datacenter replication
> This is also used for geographically distributed datacenters.
> 
> ![https://image.slidesharecdn.com/searchingcassandrakn-150805184146-lva1-app6891/95/solr-cassandra-searching-cassandra-with-datastax-enterprise-12-638.jpg?cb=1438800199](https://image.slidesharecdn.com/searchingcassandrakn-150805184146-lva1-app6891/95/solr-cassandra-searching-cassandra-with-datastax-enterprise-12-638.jpg?cb=1438800199)
>
> This is a master-master replication! 
>
> ##### Hinted Handoff  
> If a one of a nodes which have to store the data is not available then the system stores the data while the node is not active again.
> 
> ![https://image.slidesharecdn.com/insidecassandra-130925142231-phpapp01/95/a-deep-dive-into-understanding-apache-cassandra-10-638.jpg?cb=1380119062](https://image.slidesharecdn.com/insidecassandra-130925142231-phpapp01/95/a-deep-dive-into-understanding-apache-cassandra-10-638.jpg?cb=1380119062)

##### replication implications
If the client goes to a node where the data is not replicated yet then this means incosistent read (we talk about milliseconds).

![pick two](https://www.researchgate.net/profile/Mahmud-Shertil/publication/324922396/figure/fig5/AS:622261539188744@1525370120519/The-CAP-Theorem-Many-of-the-NOSQL-databases-have-loosened-up-the-requirements-on.png)![database types based on pick two](https://i.imgur.com/x1Qyurg.png)

**Consistency is overrated!** Most of the times we don’t need full consistency… ... but sometimes we do.

increasing consistnecy level makes we sure about consistency:

![increasing consistnecy level makes we sure about consistency](https://image.slidesharecdn.com/insidecassandra-130925142231-phpapp01/95/a-deep-dive-into-understanding-apache-cassandra-9-638.jpg?cb=1380119062)

> #### Examples
> https://github.com/gabboraron/cassandra-workshop/blob/main/demo/3-architecture.md
>
> **Setup Data**
> * Table of Nobel Laureates, partitioned by year
> * Cassandra Cluster with 3 nodes
> * Replication factor of 2
>
```bash
# Add a third node
docker-compose scale node2=2

# Open shell on node1
./node1-shell.sh bash

# Start CQL shell
cqlsh
```

```sql
-- create keyspace
CREATE KEYSPACE nobel
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 2}; 
-- specified replication strategyand replication factor, here all of the data is stored on 2 different computers.


-- create table
CREATE TABLE nobel.laureates
(
  laureateid int,
  firstname text,
  surname text,
  borncountrycode text,
  borncity text,
  year int,
  category text,
  PRIMARY KEY (year, laureateid)
);

-- ingest data from CSV file
COPY nobel.laureates (year, category, laureateid, firstname, surname, borncountrycode, borncity)
FROM '/nobel/laureates.csv';

-- test data
SELECT * FROM nobel.laureates WHERE year = 2010;
```

#### Partitioning and Replication

```bash
# Exit CQL shell (Ctrl+D)

# check cluster status (3 nodes, 3 IP addresses)
nodetool status

# check which node(s) hold the partition
nodetool getendpoints nobel laureates 2010
nodetool getendpoints nobel laureates 2012
nodetool getendpoints nobel laureates 2013

# what happens for a missing partition? Nothing... we get back the two nodes
nodetool getendpoints nobel laureates 3000
```

#### Consistency

```bash
# Exit node1 shell (Ctrl+D)

# Kill one of the nodes
docker stop cluster_node2_1

# Open node1 shell
./node1-shell.sh

# Check cluster status
nodetool status

# Open CQL shell
cqlsh
```

```sql
-- Is my cluster operational?
SELECT * FROM nobel.laureates WHERE year = 2010; 
SELECT * FROM nobel.laureates WHERE year = 2012;
SELECT * FROM nobel.laureates;
```

#### Tunable Consistency

```sql
-- Let's use higher consistency
CONSISTENCY QUORUM;

-- Is my cluster operational?
SELECT * FROM nobel.laureates WHERE year = 2010;
SELECT * FROM nobel.laureates WHERE year = 2012;
SELECT * FROM nobel.laureates WHERE year = 2013;
```

#### Terminate cluster

```bash
# Exit CQL shell (Ctrl+D)
# Exit node1 shell (Ctrl+D)

# Terminate cluster
./99-stop.sh
```

![write path in cassandra](https://static.packt-cdn.com/products/9781789131499/graphics/d8cba1d6-07f7-404e-a4e3-d73233474f3e.png) ![read path in cassandra](https://uberdev.files.wordpress.com/2015/11/c8bd49ae-edd4-48c0-8935-6877acfe90ac-1.png)

### Deep dive in CQL
**Primary key**
- is mandatory
- is unique
- determines partitioning 

```CQL
CREATE TABLE movies
(
  id int,
  name text,
  runtime int,
  year int,
  PRIMARY KEY (id)
);
```
### PRIMARY KEY = PARTTION KEY + CLUSTERING KEY
>
> ![primary key](https://24b4dt1v60e526bo2p349l4c-wpengine.netdna-ssl.com/wp-content/uploads/2019/08/Cassandra-Partitions-Partition-and-Clustering-Key.png)
>
> **clustering key:** determines the sorting of columns in that row.
> 
> **partition key:** resposinsibel for partitioning the data in different rows.
>
```CQL
CREATE TABLE movies (
  id int,
  name text,
  runtime int,
  year int,
  PRIMARY KEY (year, name)
);
```

### Static column
```CQL
CREATE TABLE movies (
  id int,
  name text,
  runtime int,
  year int,
  oscar_winner text static,
  PRIMARY KEY (year, name)
);
```
> Columns where the data is the same, can be stored only once. 
>
> ![static columns](https://raw.githubusercontent.com/ippontech/blog-usa/master/images/2015/04/cassandra_one_to_many_logical_view.png)

> #### Example
> https://github.com/gabboraron/cassandra-workshop/blob/main/demo/4-primary-key.md
> ##### Primary Key
> 
> * PRIMARY KEY is just a notation for PARTITION KEY & CLUSTERING KEY
> * PARTITION KEY is mandatory
> * CLUSTERING KEY is optional
> 
> ###### Nobel dataset
> 
```bash
# Create new cluster
./01-start.sh

# Open node1 shell
./node1-shell.sh

# Open CQL shell (might need to wait a minute)
cqlsh
```
> 
> * CSV file: [`cluster/nobel/laureates.csv`](https://github.com/gabboraron/cassandra-workshop/blob/main/cluster/nobel/laureates.csv)
> * Create a table that is partitioned by `borncountrycode`
>
```sql
-- create table
CREATE TABLE nobel.laureates
(
  laureateid int,
  firstname text,
  surname text,
  borncountrycode text,
  borncity text,
  year int,
  category text,
  PRIMARY KEY (borncountrycode, laureateid)
);

COPY nobel.laureates (year, category, laureateid, firstname, surname, borncountrycode, borncity)
FROM '/nobel/laureates.csv';
```
>
> * Note that we need to add `laureateid` for uniqueness
> * Partition key: `borncountrycode`
> * Clustering key: `laureateid`
>
>
> ###### Query nobel dataset
>
```sql
USE nobel;

-- efficient, we query by partition key 
SELECT * FROM laureates WHERE borncountrycode = 'HU';
```
>
> ###### Static column
>
> Stored once by partition key
>
```sql
-- add new static column
ALTER TABLE laureates ADD borncountry text static;

-- check table
SELECT * FROM laureates WHERE borncountrycode = 'HU';

-- update column (needs to write a single cell)
UPDATE laureates SET borncountry='Hungary' WHERE borncountrycode='HU';

-- check table
SELECT * FROM laureates WHERE borncountrycode = 'HU';

-- add new record without specifying borncountry
INSERT INTO laureates (borncountrycode , laureateid, category, surname, year) 
VALUES ('HU', 1001, 'Cassandra', 'Óbuda University', 2020);

-- check table
SELECT * FROM laureates WHERE borncountrycode = 'HU';

-- add new record
INSERT INTO laureates (borncountrycode , borncountry, laureateid, category, surname, year) 
VALUES ('HU', 'Magyarország', 1002, 'Cassandra', 'Óbuda University', 2021);
```
>
> -----------------------------
> 
> #### Filtering example
> https://github.com/gabboraron/cassandra-workshop/blob/main/demo/5-filtering-ordering.md
> 
> ##### Filtering
>
```sql
USE nobel;

SELECT * FROM laureates LIMIT 10;

SELECT * FROM laureates WHERE borncountrycode = 'HU';

SELECT * FROM laureates WHERE borncountrycode IN ('HU', 'AT');
```
>
```sql
SELECT * FROM laureates WHERE year = 2010;

-- not recommended (does not scale)
SELECT * FROM laureates WHERE year = 2010
ALLOW FILTERING;

CREATE INDEX ON laureates (year);

SELECT * FROM laureates WHERE year = 2010;
```
> we can create indexes and we can use it queries,
> ###### Ordering
>
```sql
USE nobel;

SELECT * FROM laureates WHERE borncountrycode = 'HU';
-- notice that records are sorted by laureateid (clustering key)

SELECT * FROM laureates WHERE borncountrycode IN ('HU','AT');
-- notice that records are sorted by laureateid only within the partition key

-- we can reverse the ordering
SELECT * FROM laureates WHERE borncountrycode = 'HU'
ORDER BY laureateid DESC;

-- Let's sort by year
SELECT * FROM laureates WHERE borncountrycode = 'HU'
ORDER BY year;

-- We can only order by clustering key

CREATE TABLE laureates_by_category (
  year int,
  laureateid int,
  borncity text,
  borncountrycode text,
  category text,
  firstname text,
  surname text,
  PRIMARY KEY (category, year, laureateid))
WITH CLUSTERING ORDER BY (year DESC);

COPY laureates_by_category (year, category, laureateid, firstname, surname, borncountrycode, borncity)
FROM '/nobel/laureates.csv';

SELECT * FROM laureates_by_category WHERE category = 'physics'; --who get nobel prize in physics
SELECT * FROM laureates_by_category WHERE category = 'physics' LIMIT 5;
SELECT * FROM laureates_by_category WHERE category = 'physics' ORDER BY year LIMIT 5;
```

#### filtering by key:
  ```CQL
  CREATE TABLE table1 (
  	pk int,
	ck1 int,
	ck2 text,
	PRIMARY KEY (pk, ck1, ck2)
  );
  ```
  
- partition key
  ```CQL
  -- When filtering by partition key
  -- values must be specified exactly
  -- (inequality operators are not supported)
  SELECT * FROM table1 WHERE pk = 2;
  -- IN operator is also supported
  --  CAUTION: it can overload the cluster!
  SELECT * FROM table1 WHERE pk IN (1, 3, 5);
  ```
- by partition key and clustering key
  ```CQL
  -- Inequality operators for clustering columns
  SELECT * FROM table1 WHERE pk = v1
  AND ck1 >= v2;
  
  -- ERROR! ck1 is not restricted 
  SELECT * FROM table1 WHERE pk = v1
  AND ck2 = v2;
  
  -- ERROR! Must restrict ck1 by equality
  SELECT * FROM table1 WHERE pk = v1
  AND ck1 >= v2 AND ck2 <= v3;
  
  -- Slicing. can combine clustering columns
  SELECT * FROM table1 WHERE pk = v1
  AND (ck1, ck2) >= (v1, v2);
  ```

#### secondary indexes
```CQL
CREATE TABLE track (
	track_id int,
	title text,
	album text,
	artist text,
	PRIMARY KEY(album, track_id)
);

-- ERROR! 
-- Cannot filter on non-key, non-indexed fields

SELECT * FROM track WHERE artist = 'U2';
CREATE INDEX ON track(artist);

-- OK. filter by secondary index

SELECT * FROM track WHERE artist = 'U2’;
```

**Cons:**
- Secondary indexes are much slower than keys
- Indexes are maintained on each node, thus queries are affecting the whole cluster

**Pro:**
- Performance could be enough. Measure.
- Fast, if previously filtered by partition key:

```CQL
SELECT * FROM track 
WHERE album = 'Joshua Tree'
AND artist = 'U2';
```

#### ordering
> - Records within a partition are **ALWAYS sorted by clustering key (ASC by default)**
> - `ORDER BY` is only valid on clustering keys and can only change direction
>   - `WITH CLUSTERING ORDER BY` – can *change the default ordering* to **DESC**
 
```CQL
-- Can change the default clustering order (ASC)
CREATE TABLE transaction (
	accountnr text, 
  	transactiondate timestamp,
	recipient text, 
  	amount decimal,
	PRIMARY KEY (accountnr, transactiondate)
) 
WITH CLUSTERING ORDER BY 
(transactiondate DESC);
```

Good practice for mesurement data, because we know which was first.

```CQL
-- Records are sorted in DESC order
SELECT * FROM transaction WHERE accountnr = '001';

-- Records are sorted in ASC order
-- (slower if the clustering order doesn't match)
SELECT * FROM transaction WHERE accountnr = '001'
ORDER BY transactiondate;

-- Records are sorted in DESC order
SELECT * FROM transaction WHERE accountnr = '001'ORDER BY transactiondate DESC;
```


#### Deleeions
> After deleting data will be replaced by an tombstone, to avoid the replacement from an another replica. When all node recieved this then will be deleted.
>
Time to live feature, is to use the data and after a specified time will be deleted.
```
-- Delete a row
DELETE FROM table1 WHERE pk = value;

-- Time to live feature (seconds)
-- Row is deleted on expiry
INSERT INTO table1 (pk, f1)
VALUES (v1, v2)
USING TTL 60;
```

### Limitations of CQL
> **NO JOINS** Expensive, don’t scale
>
> **Limited WHERE** (as seen before): By keys & secondary index
>
> **Limited ORDER BY** (as seen before): By clustering key, can change direction
>
> **Limited GROUP BY** and aggregates (since 2.2): 
> - Aggregates: COUNT, SUM, MIN, MAX, AVG
> - Only by fields of the primary key (in order)
>
> **Limited SELECT DISTINCT**: For partition keys and static columns, used to retrieve static part of the table.

### Couter tables
> there is no single point to track which was the last id, the cassandra solution for this is Counter table. Counter is a field type, value is used to generate new values.

Only contain primary keys and counter.
```CQL
-- Only key and counter columns are allowed 
CREATE TABLE employee_counter (
	employeeid bigint,
	year int,
	vacation_days counter,
	badges counter,
	PRIMARY KEY (employeeid, year)
);
```

Whith the table above it will track synchronisation between nodes. We can only incrase or decrase the value, but we can't set it!
```CQL
-- Update counter is the only operation allowed
UPDATE employee_counter
SET badges = badges + 1
WHERE employeeid = 1 AND year = 2016;

-- ERROR: Cannot set, just increment/decrement
UPDATE employee_counter
SET badges = 17
WHERE employeeid = 1 AND year = 2016;
```
example: https://github.com/gabboraron/cassandra-workshop/blob/main/demo/6-advanced.sql

### Transcrtions
> In Cassandra we don't have transactioins at all, what we have are `Batches`. 
> 
> The operations are not isolated! So other usesr can see the record until it is not rolled back!
> 
> Execution order is not deterministic!

Here we have a begin and an apply batch.
```CQL
BEGIN BATCH
INSERT INTO track_by_artist ...
INSERT INTO track_by_album  ...
APPLY BATCH;
```

#### Lightweight transactions
> 
```CQL
-- Verify by primary key
INSERT INTO users (username, name, passwordhash)
VALUES ('ada', 'Ada Lovelace', '20a46ee0')
IF NOT EXISTS;

-- Verify by any field
UPDATE users
SET passwordhash = '20a5f580'
WHERE username = 'ada'
IF passwordhash = ‘FFa46ee0';
```

### Materialized view
> between the table and the view. It behieves like a view, but it is actually stored phisically. It is efficient to use sync data between tables.

```CQL
CREATE MATERIALIZED VIEW laureates_by_category AS
	SELECT * FROM nobel_laureates
	-- primary key fields must be non-null
	WHERE category IS NOT NULL 
    	AND laureateid IS NOT NULL
PRIMARY KEY (category, year, laureateid)
WITH CLUSTERING ORDER BY 
(year DESC, laureateid ASC);
```

```CQL
-- create table what we needs

USE nobel;

-- drop previously created tables;
DROP TABLE laureates;
DROP TABLE laureates_by_category;

CREATE TABLE laureates_by_year
(
  year int,
  category text,
  laureateid int,
  firstname text,
  surname text,
  borncountrycode text,
  borncity text,
  PRIMARY KEY (year, laureateid)
);

-- create a second table
COPY laureates_by_year (year, category, laureateid, firstname, surname, borncountrycode, borncity)
FROM '/nobel/laureates.csv';
-----------------------------------------------

CREATE MATERIALIZED VIEW laureates_by_category AS
  SELECT * FROM laureates_by_year
  -- primary key fields must be non-null
  WHERE category IS NOT NULL AND laureateid IS NOT NULL
PRIMARY KEY (category, year, laureateid)
WITH CLUSTERING ORDER BY (year DESC, laureateid ASC);

--------------------------------------------------
-- test it:
INSERT INTO laureates_by_year
(year, laureateid, category, firstname)
VALUES (2021, 9999, 'Cassandra', 'Óbuda University');

--see the changes: 
SELECT * FROM laureates_by_year WHERE year = 2021;

SELECT * FROM laureates_by_category
WHERE category = 'Cassandra';
```

### JSON support
```CQL
USE demo;

CREATE TABLE contacts (
    id bigint PRIMARY KEY,
    name text,			
    phones map<text, text> 	
);

--insert JSON data into table:

INSERT INTO contacts JSON
'{
  "id": 2,
  "name": "epam",
  "phones":
  {
    "Budapest": "+36 1 3277400",
    "Szeged": "+36 62 550656"
  }
}';
```
Then we will get actual representation, not a string!

### Take away:
> - CQL is built on top of internal data structure
> - Primary Key = Partition Key + Clustering Key
> - Upsert: Inserts and Updates are equivalent
> - Writes without read
> - Collections are stored by element
> - Think performance:
>   - Filter by key (and secondary index)
>   - Limited Aggregations
> - Lightweight Transactions

### Modeling rules
> Without a good understanding how data will be used it's impossible to create a good database.

- DESIGN BY QUERY
  - Enumerate all possible queries; and design the tables to support them.
- SECONDARY INDEXES
  > for performance is bad, but for usage is great
  - Facilitate search by non-key columns.
  - WARNING: they are much slower than lookups by key. Measure performance if needed.
  - Secondary indexes can be FAST when data is already filtered by partition key.
- De-NORMALIZE TABLES
  - Embed 1-to-1 relationships as extra fields or used defined types.
  - Embed 1-to-n relationships as collections or clustering keys.
- DUPLICATE TABLES
  > don't afraid from duplacating tables!
  - Create more tables with the same content, but different partition key, and update both.
  - Consider using index tables to preserve space (only store the primary key of the main table)
  - Use Materialized Views.

#### `1-TO-MANY` relationships
> easy to store in cassandra
> 
> imgaine we want to store invoices, invoice has:
> - header: information about seller and buyer
> - detail: the `n` part of relation, many things ca be there

clustering by static fields:
```CQL
CREATE TABLE invoice (
	-- header fields
	invoice_id bigint,
	issuer text static,
	address text static,
	total_price decimal static,
	
	-- detail fields
	article_id int,
	article_name text, 
	price decimal,
  
	-- primary key
	PRIMARY KEY (invoice_id, article_id) --partitin key will be the ID, so we choose the article ID
);
```

header:
```CQL
-- retrieve header information only
SELECT DISTINCT
issuer, address, total_price --list only the static columns
FROM invoice
WHERE invoice_id = 1111;
```

detail:
```CQL
-- retrieve whole invoice
SELECT * FROM invoice
WHERE invoice_id = 1111;
```

#### DESIGN BY QUERY
> still can create a conceptual data:

![example realtionship](https://media.geeksforgeeks.org/wp-content/uploads/20191003155956/ER_diag.jpg)

- Design a conceptual model for your domain
- Go through your queries and design a table for each
- Consider reusing a table for a different query only if you can do it efficiently

#### data duplication
![gossiping](https://blog.yugabyte.com/wp-content/uploads/2018/10/cassandra-arch-1024x717.png)

> We have an original table byalbums, and an other by artist, and we have to maintaint the relation between two.

**Original table**
```CQL
CREATE TABLE track_by_album (
	track_id int,
	title text, -- other fields
	album text,
	artist text,
	PRIMARY KEY(album, track_id)
);
```

**Duplicate table**
```CQL
CREATE TABLE track_by_artist (
	track_id int,
	title text, -- other fields
	album text,
	artist text,
	PRIMARY KEY(artist, track_id)
);
```

**index table**
```CQL
CREATE TABLE album_by_artist (
	album text,
	artist text,
	PRIMARY KEY(artist, album)
);
-- first select albums by artist
-- then select tracks from original table by album
```

**Materialized View**
```CQL
CREATE MATERIALIZED VIEW track_by_artist AS
	SELECT * FROM track_by_album
	WHERE artist IS NOT NULL
  	AND track_id IS NOT NULL
PRIMARY KEY (artist, album, track_id);
```

#### lab exercise
files: https://github.com/gabboraron/cassandra-workshop/tree/main/labwork


# SQL notes - short version
## SQL basics
### Process order of `SELECT` statement
1. `from`
2. `where`
3. `group by` - *produce a single result value*
4. `having` - *to limit the results to groups that meet the criteria*
5. `select`
6. `order by`
7. `limit`

### data types
- `NUMBER(X,Y)` - `X`-number of digits; `Y`-{0-integer; other_number-number of possible decimal digits} ex: `NUMBER(6,0)`
- `VARCHAR2(X BYTE)` - `X` length of the string; ex: `VARCHAR2(20 BYTE)`
- `DATE`


## HR table
> Connect to `HR` table: double click on `HR` 
> 
> *Database scheme is almost the same as database user, and contains database objects.*
> 
> - `nullable` column shows if the object can be `null` or not
> - `"Model"`menupoint  shows the entity relationship diagram of table
> - sonstraints: *not null*, *Unique*, *Chech*
> - grantor: HR gives privilage on Employee table to user OE, so OE now can make a querry about employee.
> 
> views: *a stored querry, you can write, store and give a name to querry*
> - 

- Select everything from table "Employees": `select * from EMPLOYEES;`
- get maximum and minimum value of column: `select MAX(salary), MIN(salary) from employees;`
- group, order categories: 
  ```SQL
  select COUNT(employee_id), department_id
  from employees
  GROUP BY department_id
  ORDER BY department_id;
  ```
- ordering with groups:
  ```
  select COUNT(employee_id), department_id
  from employees
  GROUP BY department_id;
  ```
- filters groups:
  ```SQL
  select COUNT(employee_id), department_id
  from employees
  GROUP BY department_id
  HAVING COUNT(employee_id) > 1
  ORDER BY department_id;
  ```  
- [JOIN operations](https://dataschool.com/how-to-teach-people-sql/sql-join-types-explained-visually/):
  ![join operations](https://dataschool.com/assets/images/how-to-teach-people-sql/sqlJoins/sqlJoins_7.png)
  - INNER JOIN: *Specifies a join between two tables with an explicit join clause.*
    ![inner join](https://dataschool.com/assets/images/how-to-teach-people-sql/sqlJoins/sqlJoins_3.png)
    ```SQL
    SELECT columns
    FROM table1 
    INNER JOIN table2
    ON table1.column = table2.column;
    ```
  - OUTER JOIN:  
    ![outer join](https://dataschool.com/assets/images/how-to-teach-people-sql/sqlJoins/sqlJoins_2.png)
    ```SQL
    SELECT columns
    FROM table1
    FULL [OUTER] JOIN table2
    ON table1.column = table2.column;
    ```
    - LEFT OUTER JOIN: *Specifies a join between two tables with an explicit join clause, preserving unmatched rows from the first table.*
      ```SQL
      SELECT columns
      FROM table1
      LEFT [OUTER] JOIN table2
      ON table1.column = table2.column;
      ```
    - RIGHT OUTER JOIN: *Specifies a join between two tables with an explicit join clause, preserving unmatched rows from the second table.*
      ```SQL
      SELECT columns
      FROM table1
      RIGHT [OUTER] JOIN table2
      ON table1.column = table2.column;
      ```
  - CROSS JOIN: *Specifies a join that produces the Cartesian product of two tables. It has no explicit join clause.*
    ![union join](https://dataschool.com/assets/images/how-to-teach-people-sql/sqlJoins/sqlJoins_5.png)![cross join](https://dataschool.com/assets/images/how-to-teach-people-sql/sqlJoins/sqlJoins_6.png)
    ```SQL
    SELECT table1.column, table2.column
    FROM table1
    CROSS JOIN table2;
    ```
  - NATURAL JOIN: *Specifies an inner or outer join between two tables. It has no explicit join clause. Instead, one is created implicitly using the common columns from the two tables.*   
- Select departments where the number of the employees are greater or equal then 10: `SELECT  department_id, COUNT(*) FROM employees GROUP BY department_id HAVING COUNT(*)>=10;`
- minimum salary from each departemnt_id where the lowest salary is equal with the minimum of all salaries: `SELECT e.department_id, last_name, minsalary FROM employees e, (SELECT department_id, MIN(salary) minsalary FROM employees GROUP BY department_id) min WHERE e.salary=min. minsalary AND e.department_id=min.department_id;`
- using subquery: `SELECT last_name, salary, department_id,  (SELECT AVG(salary) FROM employees WHERE department_id=e.department_id) avgsalary FROM employees e;` or `SELECT job_title FROM employees NATURAL JOIN jobs WHERE salary=(SELECT MIN(salary) FROM employees);`
- Display the sum of all salary values in the EMPLOYEE table: `select SUM(salary) from employees;`
- Compute the average salary value across all non-null salary values: `select AVG(salary) from employees;`
- Substitute a non-null value for any null values: 
  ```SQL
  select AVG(salary) avg_salary from employees;
  select AVG(NVL(salary, 0)) avg_salary from employees;
  select AVG(COMMISSION_PCT) from employees;
  select AVG(NVL(COMMISSION_PCT, 0)) from employees
  ```
- Obtain a count of all employees by using `COUNT(*)`: 
- Obtain a count of all employees by applying COUNT to the primary key column: `select COUNT(employee_id) from employees;`
- Apply COUNT to a column that contains null values: `select COUNT(manager_id) from employees;`
- counting distinct values: `select COUNT(DISTINCT manager_id) num_distinct_managers from employees;`
- Nested aggregate functions:
  ```SQL
  SELECT MIN(SUM(salary)) min_department_salary_sum
  from employees
  where department_id is not null
  GROUP by department_id;
  ```
- Check the difference at `department_id=20`: 
  ```SQL
  select DEPARTMENT_ID, min(salary), max(salary) from employees
  group by DEPARTMENT_ID
  having max(salary)<6000;

  select DEPARTMENT_ID, min(salary), max(salary) from employees
  where salary<6000
  group by DEPARTMENT_ID;
  ```
- Join of multiple tables:
  ```SQL
  SELECT d.department_name, j.job_title, MIN(salary), AVG(salary), MAX(salary)
  FROM employees e
  INNER JOIN departments d
    ON e.department_id = d.department_id
  INNER JOIN job_history jh
    ON e.employee_id = jh.employee_id
  INNER JOIN jobs j
    ON j.job_id = jh.job_id
  GROUP BY d.department_name, j.job_title
  ORDER BY 1, 2
  ```
  


