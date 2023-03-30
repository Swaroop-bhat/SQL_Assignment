create database swaroop;

use swaroop;

create table dept
(deptno int primary key,
dname varchar(20),
location varchar(20));

desc dept;
insert into dept values(10,'Accounts','Bangalore');
insert into dept values(20,'IT','Delhi');
insert into dept values(30,'Production','Chennai');
insert into dept values(40,'Sales','Hyd');
insert into dept values(50,'Admn','London');
select *from dept;

create table emp
(empno int primary key,
ename varchar(20),
sal int,
hire_date date,
commission int default NULL,
deptno int references dept(deptno),
mgr int default NULL references emp(empno));
drop table emp;
desc emp;


create table emp
(empno int primary key,
ename varchar(20),
sal int,
hire_date date,
commission int default NULL,
deptno int references dept(deptno),
mgr int default NULL references emp(empno));

insert into emp values(1001,'Sachin',19000,'1980-01-01',2100,20,1003);
insert into emp values(1002,'Kapil',15000,'1970-01-01',2300,10,1003);
insert into emp values(1003,'Stefen',12000,'1990-01-01',500,20,1007);
insert into emp(empno,ename,sal,hire_date,deptno,mgr) values(1004,'Williams',9000,'2001-01-01',30,1007);
insert into emp(empno,ename,sal,hire_date,deptno,mgr) values(1005,'John',5000,'2005-01-01',30,1006);
insert into emp values(1006,'Dravid',19000,'1985-01-01',2400,10,1007);
insert into emp(empno,ename,sal,hire_date,commission) values(1007,'Martin',21000,'2000-01-01',1040);
select *from emp;
use swaroop;
1)Select employee details  of dept number 10 or 30
-->select * from emp where deptno=10 or deptno=30;

2)Write a query to fetch all the dept details with more than 1 Employee.
-->select *from from dept where deptno in(select deptno from emp group by deptno having count(*)>1);


3)Write a query to fetch employee details whose name starts with the letter “S”
-->select *from emp where ename like 'S%';


4)Select Emp Details Whose experience is more than 2 years
-->SELECT *
   FROM emp 
   WHERE DATEDIFF(CURDATE(), emp.hire_date) > 730;


5)Write a SELECT statement to replace the char “a” with “#” in Employee Name ( Ex:  Sachin as S#chin)
-->select replace(ename,'a','#') from emp;

     
6)Write a query to fetch employee name and his/her manager name. 
-->SELECT e.ename as employee , m.ename as manager 
   FROM emp e
   JOIN emp m ON e.mgr = m.empno;


7)Fetch Dept Name , Total Salry of the Dept
-->select dept.dname,sum(sal) from emp,dept where emp.deptno=dept.deptno group by dname;


8)Write a query to fetch ALL the  employee details along with department name, department location, irrespective of employee existance in the department.
-->SELECT emp.*, dname, location
    FROM emp 
    LEFT JOIN dept  ON emp.deptno = dept.deptno;

9)Write an update statement to increase the employee salary by 10 %
-->update emp set emp.sal=sal+(sal*10)/100;

10)Write a statement to delete employees belong to Chennai location.
-->delete from dept where dept.location='Chennai';

11)Get Employee Name and gross salary (sal + comission) .
-->select ename ,sum(sal+ifnull(commission,0)) as gross_salary from emp group by ename;

12)Increase the data length of the column Ename of Emp table from  100 to 250 using ALTER statement
-->alter table emp modify ename varchar(250);


13)Write query to get current datetime
--> select now();


14)Write a statement to create STUDENT table, with related 5 columns
-->create table students
(usn int primary key,
sname varchar(20),
age int,
address varchar(20),
sem int);


15)Write a query to fetch number of employees in who is getting salary more than 10000
-->select *from emp where sal>10000;


16)Write a query to fetch minimum salary, maximum salary and average salary from emp table.
-->select min(sal),max(sal),avg(sal) from emp;


17)Write a query to fetch number of employees in each location
-->SELECT location, COUNT(emp.empno) AS employees
   FROM dept 
   left join emp  ON dept.deptno = emp.deptno
    GROUP BY dept.location;


18)Write a query to display emplyee names in descending order
-->select ename from emp order by ename desc;

    
19)Write a statement to create a new table(EMP_BKP) from the existing EMP table 
-->create table emp_bkp as select *from emp; 
   desc emp_bkp;


20)Write a query to fetch first 3 characters from employee name appended with salary.
-->select substring(ename,1,3),sal from emp;


21) Get the details of the employees whose name starts with S
-->select * from emp where ename like'S%';


22) Get the details of the employees who works in Bangalore location
-->select *from emp inner join dept on dept.deptno=emp.deptno where dept.location='Bangalore';


23) Write the query to get the employee details whose name started within  any letter between  A and K
-->select *from emp where ename between 'A' and 'K';


24) Write a query in SQL to display the employees whose manager name is Stefen 
--> select e.ename from emp e 
    inner join emp m on e.mgr=m.empno
     where m.ename='Stefen';


25) Write a query in SQL to list the name of the managers who is having maximum number of employees working under him
-->select (select ename from emp  where empno=e.mgr) as manager_name from emp e group by mgr having count(*)=(select max(emp_count)from (select count(*) as emp_count from emp group by mgr) counts);

26) Write a query to display the employee details, department details and the manager details of the employee who has second highest salary
-->select * from emp where sal in(SELECT MAX(sal) FROM emp WHERE sal < (SELECT MAX(sal) FROM emp));


27) Write a query to list all details of all the managers
-->SELECT e.* FROM emp e WHERE e.empno IN (SELECT DISTINCT mgr FROM emp WHERE mgr IS NOT NULL);


28) Write a query to list the details and total experience of all the managers
-->select m.ename , m.hire_date,SUM(DATEDIFF(CURDATE(), e.hire_date)/365) as total_experience
   from emp m
   join emp e on m.empno = e.mgr
   group by m.empno;


29) Write a query to list the employees who is manager and  takes commission less than 1000 and works in Delhi
-->SELECT emp.ename
   FROM emp
   JOIN dept ON dept.deptno= emp.deptno
    WHERE dept.location = 'Delhi'
   AND emp.commission < 1000;


30) Write a query to display the details of employees who are senior to Martin 
-->SELECT *
   FROM emp
   WHERE hire_date < (
    SELECT hire_date
    FROM emp
    WHERE ename = 'Martin'
   );