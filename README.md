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
