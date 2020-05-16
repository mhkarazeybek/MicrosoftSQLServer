use Northwind

select*from Categories
select*from Customers
select*from Employees
select*from [Order Details]
select*from Orders
select*from Products
select*from Region
select*from Shippers
select*from Suppliers

--Companyname ve Phone sütunlarını getiren sorgu
select
CompanyName, Phone
from Customers

--Tüm çalışanlarımızın işe alım tarihleri adları ve soyadlarını getiren sorgu
select
HireDate, FirstName, LastName
from Employees

select
e.HireDate, e.FirstName, e.LastName
from Employees e

--productId si 72 olan ürünün adı ve ürün id sini getiren sorgu
select
ProductID, ProductName
from Products
where ProductID=72

--ürün id si 64 olan ve stok miktarı 10 dan küçük olan ürünü getiren sorgu
select
*
from Products
where ProductID=64 and UnitsInStock<10

--ürünün adi, ürünün kategori id si siparis adeti ve sipariste ki birim fiyatını geriren sorgu
select
p.ProductName, p.CategoryID, od.Quantity, od.UnitPrice
from [Order Details] od, Products p
where p.ProductID = od.ProductID

--ortalama ürün fiyatını veren sorgu
select AVG(UnitPrice) from Products


--fiyatı ortalama fiyatın altında kalan ürünler ??
select*from Products p
where (select AVG(UnitPrice) from Products)> p.UnitPrice

--Patron Kim??
select*from Employees e
where e.ReportsTo is null

--çalışanların adını ve soyadını tek sütunda getiren ancak soyadının tamamını büyük harfle getiren sorgu
select
e.FirstName + ' ' +UPPER(e.LastName)
from Employees e

--çalışanların adı ve soyadıları ayrı sütunlarda gelsin
-- ancak adın ilk 2 harfi büyük diğerleri küçük gelsin

select
upper(SUBSTRING(e.FirstName,1,2)) +' '+ lower(SUBSTRING(e.firstname,3,len(e.firstname))), LastName
from Employees e

--müşteriler tablosunda ki adres alanında bulunan '.', '-' ile değiştiren sorgu
select
REPLACE(c.Address,'.','-')
from Customers c


--satır sayısını getirensorgu
select*from Customers
select
ROW_NUMBER() over (order by CustomerID)
from Customers

--RANK() tekrar eden satırlara aynı numaraları verir tekrar etmeyen satırlarla karşılaşıncaya kadar devam eder

select RANK() over (order by OrderID),OrderID from [Order Details]

--Dense Rank tekrar eden satırlara aynı numaraları verir
--tekrar etmeyen bir satırla karşılaşınca kaldığı ardışık değerden devam eder
select DENSE_RANK() over (order by OrderID), OrderID from [Order Details]

--hangi üründen ne kadar ihtiyacım kalmış üretime iht varmı ??
--IIF if and only if
--IIF komutu koşulun doğru olması durumunda ilk değeri
--aksi durumda is ikinci değeri döndürür
select
IIF(p.UnitsInStock-p.UnitsOnOrder<0, 'üretime ihtiyaç var', 'üretime ihtiyaç yok') as Rapor, p.UnitsInStock-p.UnitsOnOrder as Fark
from Products p

-- ORDER BY
--productlari en ucuzdan en pahalıya göre sıralayan sorgu
select
p.ProductName,p.UnitPrice
from Products p
order by UnitPrice asc --artan

--aynı sorgunun tersten sıralı getiren sorgusu
select
p.ProductName,p.UnitPrice
from Products p
order by UnitPrice desc --azalan

--en ucuz ve en pahalı ürünleri getiren sorgu
--en ucuz
select
top 1 ProductName,UnitPrice
from Products
order by UnitPrice 

--en pahalı
select
top 1 ProductName,UnitPrice
from Products
order by UnitPrice desc

--en pahalı 5 ürünü getiren sorgu
select
top 5 ProductName,UnitPrice
from Products
order by UnitPrice desc