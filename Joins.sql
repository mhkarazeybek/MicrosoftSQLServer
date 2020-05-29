--JOINS
use Northwind

--hangi kategori hangi producta ait isimleri ile beraber listeleyiniz.

select
c.CategoryName,p.ProductName
from Products p
inner join Categories c on c.CategoryID = p.CategoryID

--hangi productları hangi supplier getiriyor..
select
s.CompanyName, p.ProductName
from Products p
inner join Suppliers s on s.SupplierID = p.SupplierID

--hangi kategorideki hangi productları hangi supplier getiriyor?

select
p.ProductName, c.CategoryName, s.CompanyName
from Products p
inner join Suppliers s on s.SupplierID=p.SupplierID
inner join Categories c on p.CategoryID =c.CategoryID

--OrderID, ProductName, CategoryName, CategoryDescription, urunden stokta ne kadar var
--hangi şirket bunlar ile ilgileniyor (daha önce sipariş vermiş)
--o şirketin telefon numarası

select
o.OrderID, p.ProductName, c.CategoryName, c.Description, p.UnitsInStock,cus.CompanyName,cus.Phone
from [Order Details] ord
inner join Orders o on o.OrderID = ord.OrderID
inner join Products p on p.ProductID = ord.ProductID
inner join Categories c on c.CategoryID=p.CategoryID
inner join Customers cus on cus.CustomerID = o.CustomerID

--1997 yılında satış yaptığım müşteriler
select
cus.CompanyName,o.OrderDate
from Customers cus
inner join Orders o on o.CustomerID=cus.CustomerID
where YEAR(OrderDate) ='1997'


--müşteri bazlı satış raporu
--(hangi firmaya ne kadarlık satış yaptım)

select
c.CompanyName, (ord.Quantity*ord.UnitPrice*(1-ord.Discount))
from [Order Details] ord
inner join Orders o on o.OrderID=ord.OrderID
inner join Customers c on c.CustomerID=o.CustomerID

--hangi firmaya toplam ne kadarlık satış yaptım

select
c.CompanyName, sum(ord.Quantity*ord.UnitPrice*(1-ord.Discount))
from [Order Details] ord
inner join Orders o on o.OrderID=ord.OrderID
inner join Customers c on c.CustomerID=o.CustomerID
group by c.CompanyName

--Left Right Joins

create database ULUSOFT

create table Companies
(
CompanyId int,
CompanyName nvarchar(50)
)

create table Employee
(
EmployeeId int,
NameSurname nvarchar(50),
)

create table Comp_Emp
(
CompEmpId int,
EmployeeId int,
CompanyId int,
)

select*from Employee

--company tablosuna veri girişi yapıyoruz
insert into Companies values (1,'Microsoft')
insert into Companies values (2, 'Apple')
insert into Companies values (3, 'Samsung')
insert into Companies values (4, 'Edel Krone')

select*from Companies

--Employees tablosuna veri girişi yapıyoruz
insert into Employee values (1, 'Abdullah Köreoğlu')
insert into Employee values (2, 'Mustafa Açık')
insert into Employee values (3, 'Muhammed Hüseyin Karazeybek')
insert into Employee values (4, 'Ayşe Fatma')

select*from Employee

--danışman olan firmalara veri girişi

--2 nolu şirketinin danışmanı 1 nolu çalışan
insert into Comp_Emp values (1,1,2)

--2nolu şirketin danışmanı 3 nolu personel
insert into Comp_Emp values (2,3,2)

--1nolu şirketin danışmanı 4 nolu personel
insert into Comp_Emp values (3,4,1)

--4nolu şirketin danışmanı 4nolu personel
insert into Comp_Emp values (4,4,4)


--hangi danışman hangi şirkete gidiyor
select
c.CompanyName,e.NameSurname
from Employee e
inner join Comp_Emp ce on ce.EmployeeId=e.EmployeeId
inner join Companies c on c.CompanyId=ce.CompanyId

--danışmanı olmayan şirketler hangileridir?
select*from Companies c
left join Comp_Emp ce on c.CompanyId = ce.CompanyId
where ce.CompanyId is null

--aynı sorguyu right join ile
select*from Comp_Emp ce
right join Companies c on c.CompanyId = ce.CompanyId
where ce.CompanyId is null

--şirketi olmayan danışmanlar
select*from Employee e
left join Comp_Emp ce on ce.EmployeeId = e.EmployeeId
where ce.EmployeeId is null

--right join
select*from Comp_Emp ce
right join Employee e on e.EmployeeId=ce.EmployeeId
where ce.EmployeeId is null

use Northwind
--hiç satış yağmadığım müşteriler ve bunların telefon numaraları

select
*
from Customers c
left join Orders o on o.CustomerID = c.CustomerID
where o.CustomerID is null

--aynı sorgu right join ile

select
*
from Orders o
right join Customers c on c.CustomerID= o.CustomerID
where o.CustomerID is null


--kim kimin amiri bulunuz
select
e.FirstName+' '+e.LastName as Calisan, emp.FirstName+' ' +emp.LastName as Amir
from Employees e
left join Employees emp on e.ReportsTo=emp.EmployeeID

--bugün doğum günü olan çalışanlar kimler??
select*from Employees e 
where MONTH(e.BirthDate)=MONTH(GETDATE()) and Day(e.BirthDate)=day(GETDATE())

--zamanında teslim edemediğim siparişler
select
o.OrderID, o.ShippedDate,o.RequiredDate, DAY(o.ShippedDate-o.RequiredDate)
from Orders o
where o.ShippedDate>o.RequiredDate

--ayni sorguyu datediff ile yazınız
select
o.OrderID, DATEDIFF(day,o.RequiredDate,o.ShippedDate)
from Orders o
where o.ShippedDate>o.RequiredDate