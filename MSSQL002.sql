use ULUSOFT
create table HelloWorld(
	ID int IDENTITY,
	ContentText nvarchar(50)
	)

insert into HelloWorld(ContentText) values('Hello World')
select*from HelloWorld

insert into HelloWorld(ContentText) values('Merhaba Dünya')

use Northwind
select*from Products
--productname 'ch' ile başlayan ve 5 harften oluşan product'ın productname ve unitprice getiren sorgu
select
ProductName, UnitPrice
from Products 
where ProductName like 'ch___'

--productname'in ilk harfi 'A' ile 'G' arasında olan productların productname ve unitprice alfabebetik olarak getiren sorgu
select
p.ProductName, p.UnitPrice
from Products p
where p.ProductName like '[A-G]%'
order by p.ProductName

-- Matematiksel işlemlerle Alış ve Satış Fiyatı oluşturma
select
p.ProductName as "Ürün Adı", p.UnitPrice as 'Birim Fiyat', p.UnitPrice+2 as "Alış Fiyatı",p.UnitPrice+(p.UnitPrice*0.3) as 'Satış Fiyatı'
from Products p

--Bugün tarihinin ay bilgisinden 3 ay önceki değere eşit şiparişleri getiren sorgu
select
CustomerID, EmployeeID, OrderDate
from Orders
where MONTH(OrderDate) = MONTH(GETDATE())-3

--product tablosundaki unitprice toplamı
select
SUM(UnitPrice) as 'Toplam Birim Fiyat'
from Products

--max birim fiyat
select
MAX(UnitPrice)
from Products

--min birim fiyat
select
min(UnitPrice)
from Products

--Toplam ürün adetini veren sorgu
select
COUNT(ProductID) as 'Toplam ürün adeti'
from Products

--En genç Çalışanı getiren sorgu
select
MAX(e.BirthDate)
from Employees e

--Productname'i  'A' ile başlayan ya da Unitprice'ı 20 den büyük olan ürünlerin productname ve unitprice ını getiren sorgu
select
p.ProductName, p.UnitPrice
from Products p
where p.ProductName like 'A%' or p.UnitPrice>20

--productname'i a ile bitenleri getiren sorgu
select
p.ProductName, p.UnitPrice
from Products p
where p.ProductName like '%A'

select*from Customers
--City Berlin,London ve Madrid olan Customers'in Companyname, Contactname ve city bilgilerini getiren sorgu
select
CompanyName, ContactName, City
from Customers
where City ='London' or City = 'madrid' or City='BeRlIn'

--aynı sorgunun başka şekli
select
CompanyName, ContactName, City
from Customers
where City in ('Madrid','London','berlin')