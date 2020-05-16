--Database oluşturma
create database OtoGaleri

use OtoGaleri

--Tablo Oluşturma
create table Araclar(
	ID int identity,
	Brand nvarchar(75),
	Model nvarchar(50),
	Price money,
	Color nchar(20),
	[Benzin/Km] float,
	_Year int,
	Km int,
)

--Tabloya veri ekleme
insert into Araclar(Brand, Model, Price,Color,[Benzin/Km],_Year, Km) values ('Mercedes', 'X 350d', 450000,'Metalik',0.7, 2018, 150000)
insert into Araclar(Brand, Model, Price,Color,[Benzin/Km],_Year, Km) values ('Fiat', 'Doblo', 55000,'Gri',0.3, 2012, 250000)
insert into Araclar(Brand, Model, Price,Color,[Benzin/Km],_Year, Km) values ('BMW', 'M5', 50000,'Mavi',1.2, 2018, 0)
insert into Araclar(Brand, Model, Price,Color,[Benzin/Km],_Year, Km) values ('TOGG', 'SUV', 1000000,'Kırmızı',0.7, 2023, 0) 
insert into Araclar(Brand, Model, Price,Color,[Benzin/Km],_Year, Km) values ('Honda', 'Civic', 90000,'Beyaz',0.5, 2015, 175000)
insert into Araclar(Brand, Model, Price,Color,[Benzin/Km],_Year, Km) values ('Mini Cooper', 'S', 60000,'Siyah',1.3, 2018, 0)
insert into Araclar(Brand, Model, Price,Color,[Benzin/Km],_Year, Km) values ('TOGG', '4x4', 1200000,'Mavi',0.8, 2023, 0) 

--GROUP BY
--Model Yıllarına göre ortalama benzin tüketimi
select
a._Year, AVG(a.[Benzin/Km]) as 'Ortalama Benzin tüketimi'
from Araclar a
group by a._Year

--benzin tüketimine göre o benzin tüketimine ait kaç adet araç var??
select
a.[Benzin/Km], COUNT(*)
from Araclar a
group by a.[Benzin/Km]

-- 2018 yılından sonra üretilmiş bir model için ortalama benzin tüketimi??
-- parametre olarak where sart satırına arabanın markası yazılacak

select
a._Year, Avg(a.[Benzin/Km])
from Araclar a
where a.Brand = 'TOGG'
group by a._Year
having a._Year > 2018

--Batch Process

use Northwind

declare @sayi1 int set @sayi1 = 5
print @sayi1

select *from Products
where CategoryID = @sayi1

--if (kosul)
--{

--}

--if (kosul)
--begin
--end

declare @KategoriAdi nvarchar(50)
set @KategoriAdi = 'Beverages'
--print @KategoriAdi

if exists(select*from Categories where CategoryName = @KategoriAdi)
begin
print 'kategori Mevcuttur'
end
else
begin
print 'Kategori mevcut değildir'
end

--Switch Case

select 
ProductName, Discontinued = Case when Discontinued = 0 then 'üretim devam ediyor' 
								 when Discontinued = 1 then 'üretim yok'
								 end
from Products


--while(kosul)
--{
--}

--while(kosul)
--begin
--end

select NEWID()

declare @TableGuid table (deger uniqueidentifier)
declare @sayac int
set @sayac = 1
while (@sayac<=20)
begin
insert into @TableGuid (deger) values (NEWID())
set @sayac +=1
end

select*from @TableGuid



-- Functions

-- veriler doğrudan çalışmazlar (insert ve update yapılamaz)
-- geriye değer döndürürler bu değerler table  ya da scalar değer olabilir.
-- functionlar birer database objecleridir. create ilr yaratılabilir.
-- drop ile silinir, alter ile güncellenir. Ancak güncelleme işlemi yapıldıktan sonra geriye alma durumu yoktur.
-- select bağımlı çalışırlar...

create function fncGetProductById (@ProID int)
returns table --methodun dönüş tipi
as
return select*from Products where ProductID = @ProID

select*from fncGetProductById(5)

-- hangi kategori içinde ki hangi productları hangi supplier getiriyor??
-- fonksiyon parametre olarak CatID girilsin...

alter function fncGetProductAndSuppByCatId(@CatId int)
returns table
as
return select
p.ProductName, c.CategoryName, s.CompanyName
from Products p
inner join Categories c on c.CategoryID = p.CategoryID
inner join Suppliers s on s.SupplierID = p.SupplierID
where p.CategoryID = @CatId

select*from fncGetProductAndSuppByCatId(5)

-- scalar value function
alter function fncKDVHesapla(@price money)
returns money
as
begin 
return (@price *0.08)
end

select
od.OrderID, od.UnitPrice, dbo.fncKDVHesapla(od.UnitPrice) as KDV,
dbo.fncKDVHesapla(od.UnitPrice)+(od.UnitPrice) as GenelToplam
from [Order Details] od