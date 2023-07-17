USE master

GO

IF  EXISTS (
	SELECT name 
		FROM sys.databases 
		WHERE name = N'KN301_ARTSYBASHEV'
)
ALTER DATABASE [KN301_ARTSYBASHEV] set single_user with rollback immediate
GO

IF  EXISTS (
	SELECT name 
		FROM sys.databases 
		WHERE name = N'KN301_ARTSYBASHEV'
)
DROP DATABASE [KN301_ARTSYBASHEV]
GO

CREATE DATABASE [KN301_ARTSYBASHEV]
GO

USE [KN301_ARTSYBASHEV]
GO

IF EXISTS(
  SELECT *
    FROM sys.schemas
   WHERE name = N'ARTSYBASHEV'
) 
 DROP SCHEMA ARTSYBASHEV
GO

CREATE SCHEMA ARTSYBASHEV
GO

CREATE TABLE [KN301_ARTSYBASHEV].ARTSYBASHEV.shop
(
	IdShop TINYINT NOT NULL,
	ShName VARCHAR(15) NULL,
	Street VARCHAR(20) NULL,
	House VARCHAR(10) NULL,
	CONSTRAINT PK_IdShop PRIMARY KEY (IdShop)
)
GO

CREATE TABLE [KN301_ARTSYBASHEV].ARTSYBASHEV.productgroup
(
	IdGroup TINYINT NOT NULL,
	GrName VARCHAR(50) NULL,
	CONSTRAINT PK_IdGroup PRIMARY KEY (IdGroup)
)
GO

CREATE TABLE [KN301_ARTSYBASHEV].ARTSYBASHEV.product
(
	IdProduct TINYINT NOT NULL,
	IdGroup TINYINT NOT NULL,
	PrName VARCHAR(50) NULL,
	UnitsMeas VARCHAR(10) NULL,
	CONSTRAINT PK_IdProduct PRIMARY KEY (IdProduct),
	FOREIGN KEY (IdGroup) REFERENCES [KN301_ARTSYBASHEV].ARTSYBASHEV.productgroup (IdGroup)
)
GO

CREATE TABLE [KN301_ARTSYBASHEV].ARTSYBASHEV.warehouse
(
	IdShop TINYINT NOT NULL,
	IdProduct TINYINT NOT NULL,
	PrCent DECIMAL(8,2) NOT NULL,
	PrCount TINYINT NOT NULL,
	Date_ DATE NOT NULL,
	Prizn VARCHAR(1) NOT NULL,
	FOREIGN KEY (IdShop) REFERENCES [KN301_ARTSYBASHEV].ARTSYBASHEV.shop (IdShop),
	FOREIGN KEY (IdProduct) REFERENCES [KN301_ARTSYBASHEV].ARTSYBASHEV.product (IdProduct)
)
GO

INSERT INTO [KN301_ARTSYBASHEV].ARTSYBASHEV.shop
VALUES
(1, N'ПЯТЁРОЧКА', N'8 МАРТА', N'196'),
(2, N'КИРОВСКИЙ', N'ЩОРСА', N'66'),
(3, N'ВЕРНЫЙ', N'АКАДЕМИЧЕСКАЯ', N'20'),
(4, N'ПЕРЕКРЁСТОК', N'СОЮЗНАЯ', N'44')
GO

INSERT INTO [KN301_ARTSYBASHEV].ARTSYBASHEV.productgroup
VALUES
(1, N'МОЛОЧКА'),
(2, N'ХЛЕБ'),
(3, N'ОВОЩИ'),
(4, N'ФРУКТЫ')
GO

INSERT INTO [KN301_ARTSYBASHEV].ARTSYBASHEV.product
VALUES
(1, 1, N'Молоко "Снежинское 5%"', N'л'),
(2, 1, N'Кефир "Московсвий"', N'л'),
(3, 1, N'Творог "Рефтинский 4%"', N'кг'),
(4, 2, N'Хлеб "Чусовской"', N'кг'),
(5, 3, N'Огурец "Краснодарский"', N'кг'),
(6, 3, N'Лук репчатый', N'кг'),
(7, 3, N'Перец красный', N'кг'),
(8, 4, N'Банан', N'кг'),
(9, 4, N'Виноград', N'кг')
GO

-- IdShop IdProduct PrCent PrCount
INSERT INTO [KN301_ARTSYBASHEV].ARTSYBASHEV.warehouse
VALUES
(1, 1, 60.15, 40, '2022-09-28', N'+'),
(1, 1, 62.15, 20, '2022-09-26', N'-'),
(2, 1, 62.25, 25, '2022-09-27', N'+'),
(2, 1, 68.25, 11, '2022-09-30', N'-'),
(3, 1, 53.00, 25, '2022-10-02', N'+'),

(1, 2, 70.80, 45, '2022-09-26', N'+'),
(2, 2, 71.30, 60, '2022-09-30', N'+'),
(2, 2, 75.00, 34, '2022-10-01', N'-'),
(2, 2, 74.00, 16, '2022-10-02', N'-'),
(4, 2, 53.50, 23, '2022-09-28', N'+'),

(1, 3, 95.48, 45, '2022-10-03', N'+'),
(1, 3, 100.00, 35, '2022-10-03', N'-'),
(2, 3, 90.11, 51, '2022-10-05', N'+'),
(2, 3, 92.00, 23, '2022-10-05', N'-'),
(2, 3, 92.00, 13, '2022-10-06', N'-'),
(3, 3, 100.54, 65, '2022-10-02', N'+'),
(4, 3, 85.84, 65, '2022-10-01', N'+'),
(4, 3, 85.84, 5, '2022-10-01', N'-'),
(4, 3, 85.84, 25, '2022-10-02', N'-'),

(2, 4, 29.00, 33, '2022-09-30', N'+'),
(2, 4, 30.00, 32, '2022-10-01', N'-'),
(2, 4, 29.00, 34, '2022-10-01', N'+'),
(3, 4, 25.00, 54, '2022-10-02', N'+'),
(3, 4, 27.00, 24, '2022-10-02', N'-'),
(3, 4, 27.30, 14, '2022-10-03', N'-'),

(1, 5, 40.00, 19, '2022-09-26', N'+'),
(4, 5, 43.75, 63, '2022-09-27', N'+'),
(4, 5, 46.00, 53, '2022-10-03', N'-'),
(4, 5, 44.00, 42, '2022-10-03', N'+'),
(4, 5, 47.00, 21, '2022-10-04', N'-'),

(2, 6, 70.30, 29, '2022-09-28', N'+'),
(3, 6, 69.12, 44, '2022-09-27', N'+'),
(3, 6, 69.12, 36, '2022-09-29', N'-'),
(4, 6, 63.92, 32, '2022-10-04', N'+'),
(4, 6, 65.20, 32, '2022-10-05', N'-'),
(4, 6, 63.92, 50, '2022-10-07', N'+'),

(1, 7, 40.53, 4, '2022-09-29', N'+'),
(2, 7, 48.84, 44, '2022-10-03', N'+'),
(2, 7, 50.00, 32, '2022-10-04', N'-'),
(3, 7, 46.13, 47, '2022-10-04', N'+'),
(3, 7, 49.00, 40, '2022-10-05', N'-'),

(1, 8, 62.00, 29, '2022-10-03', N'+'),
(1, 8, 65.00, 19, '2022-10-03', N'-'),
(1, 8, 65.00, 8, '2022-10-04', N'-'),
(3, 8, 61.00, 30, '2022-10-04', N'+'),
(3, 8, 63.99, 20, '2022-10-04', N'-'),
(4, 8, 59.00, 30, '2022-10-01', N'+'),
(4, 8, 62.86, 20, '2022-10-01', N'-'),
(4, 8, 62.86, 6, '2022-10-04', N'-'),

(1, 9, 119.49, 76, '2022-09-28', N'+'),
(1, 9, 130.00, 53, '2022-09-29', N'-'),
(1, 9, 130.00, 23, '2022-09-30', N'-'),
(2, 9, 101.34, 88, '2022-09-29', N'+'),
(2, 9, 115.20, 49, '2022-09-30', N'-'),
(3, 9, 89.45, 85, '2022-10-03', N'+'),
(3, 9, 93.60, 83, '2022-10-04', N'-')
GO

CREATE FUNCTION ARTSYBASHEV.func
(@date DATE, @idProduct TINYINT, @idShop TINYINT, @prizn VARCHAR(1))
RETURNS INT
AS
BEGIN
	RETURN ISNULL(
			(
				SELECT SUM(PrCount)
				FROM ARTSYBASHEV.warehouse AS w
				WHERE
					w.IdProduct = @idProduct
					AND w.IdShop = @idShop
					AND w.Date_ < @date
					AND w.Prizn = @prizn
			),
			0)
END
GO

DECLARE @DATEvar AS DATE = '2022-10-05'
SELECT
	PrName AS 'Наименование товара',
	IdShop AS 'ID магазина',
	ARTSYBASHEV.func(@DATEvar, w.IdProduct, w.IdShop, N'+') AS 'Всего поступило',
	ARTSYBASHEV.func(@DATEvar, w.IdProduct, w.IdShop, N'-') AS 'Всего продано',
	ARTSYBASHEV.func(@DATEvar, w.IdProduct, w.IdShop, N'+') 
	- ARTSYBASHEV.func(@DATEvar, w.IdProduct, w.IdShop, N'-') AS 'Осталось'
FROM
	ARTSYBASHEV.warehouse AS w
	JOIN ARTSYBASHEV.product AS p ON w.IdProduct = p.IdProduct
GROUP BY w.IdProduct, PrName, IdShop
GO

------------------------------------------------------------------------------

-- Наименьшая, наибольшая и средняя стоимости каждого товара во всех магазинах
DECLARE @IDPRODUCTvar AS TINYINT = 8
SELECT
	@IDPRODUCTvar AS 'ID товара',
	PrName AS 'Имя товара',
	CAST(MIN(PrCent) AS DECIMAL(8,2)) AS 'Наименьшая стоимость',
	CAST(MAX(PrCent) AS DECIMAL(8,2)) AS 'Наибольшая стоимость',
	CAST(AVG(PrCent) AS DECIMAL(8,2)) AS 'Средняя стоимость'
FROM 
	[KN301_ARTSYBASHEV].ARTSYBASHEV.product AS p
	INNER JOIN [KN301_ARTSYBASHEV].ARTSYBASHEV.warehouse AS w
	ON p.IdProduct = w.IdProduct
WHERE w.Prizn = N'-'
GROUP BY PrName
GO

-- Информация о всех ПОСТУПИВШИХ товарах с id = @IDPRODUCTvar
DECLARE @IDPRODUCTvar AS TINYINT = 8
SELECT 
	FORMAT(Date_,'d MMMM yyyy','ru-RU') AS 'Дата поступления',
	@IDPRODUCTvar AS 'ID товара',
	PrName AS 'Название товара',
	GrName AS 'Группа товаров',
	ShName AS 'Название магазина',
	PrCent AS 'Стоимость',
	PrCount AS 'Количество'
FROM
	[KN301_ARTSYBASHEV].ARTSYBASHEV.product AS p
	INNER JOIN [KN301_ARTSYBASHEV].ARTSYBASHEV.productgroup AS pg
	ON p.IdGroup = pg.IdGroup
	INNER JOIN [KN301_ARTSYBASHEV].ARTSYBASHEV.warehouse AS w
	ON p.IdProduct = w.IdProduct
	INNER JOIN [KN301_ARTSYBASHEV].ARTSYBASHEV.shop AS s
	ON w.IdShop = s.IdShop 
WHERE 
	p.IdProduct = @IDPRODUCTvar
	AND	w.Prizn = N'+'
GROUP BY Date_, PrName, GrName, ShName, PrCent, PrCount
GO

-- Информация о количестве продаж (со всех магазинов) товара с id = @IDPRODUCTvar
DECLARE @IDPRODUCTvar AS TINYINT = 8
SELECT 
	SUM(PrCount) AS 'Продано со всех магазинов',
	@IDPRODUCTvar  AS 'ID товара',
	PrName AS 'Название товара'
FROM 
	[KN301_ARTSYBASHEV].ARTSYBASHEV.product AS p
	INNER JOIN [KN301_ARTSYBASHEV].ARTSYBASHEV.productgroup AS pg
	ON p.IdGroup = pg.IdGroup
	INNER JOIN [KN301_ARTSYBASHEV].ARTSYBASHEV.warehouse AS w
	ON p.IdProduct = w.IdProduct
	INNER JOIN [KN301_ARTSYBASHEV].ARTSYBASHEV.shop AS s
	ON w.IdShop = s.IdShop
WHERE
	p.IdProduct = @IDPRODUCTvar
	AND	w.Prizn = N'-'
GROUP BY PrName
GO

/*
Информация о о количестве продаж и выручке за них товара с id = @IDPRODUCTvar
из магазина c id = @IDSHOPvar
*/
DECLARE @IDPRODUCTvar AS TINYINT = 8
DECLARE @IDSHOPvar AS TINYINT = 4
SELECT
	@IDPRODUCTvar AS 'ID товара',
	s.IdShop AS 'ID магазина',
	ShName AS 'Название магазина',
	PrCount AS 'Продано с конкретного магазина',
	(PrCount * PrCent) AS 'Сумма продаж за день',
	FORMAT(Date_,'d MMMM yyyy','ru-RU') AS 'Дата продажи'
FROM 
	[KN301_ARTSYBASHEV].ARTSYBASHEV.product AS p
	INNER JOIN [KN301_ARTSYBASHEV].ARTSYBASHEV.productgroup AS pg
	ON p.IdGroup = pg.IdGroup
	INNER JOIN [KN301_ARTSYBASHEV].ARTSYBASHEV.warehouse AS w
	ON p.IdProduct = w.IdProduct
	INNER JOIN [KN301_ARTSYBASHEV].ARTSYBASHEV.shop AS s
	ON w.IdShop = s.IdShop
WHERE
	p.IdProduct = @IDPRODUCTvar
	AND s.IdShop = @IDSHOPvar
	AND w.Prizn = N'-'
GROUP BY Date_, PrCount, PrCent, ShName, s.IdShop
GO

-- Информация о поступлении товара с id = @IDPRODUCTvar в дату @DATEvar
DECLARE @DATEvar AS DATE = '2022-10-01'
DECLARE @IDPRODUCTvar AS TINYINT = 8
SELECT 
	SUM(w.PrCount) AS 'Поступило в определенную дату',
	@IDPRODUCTvar AS 'ID товара',
	PrName AS 'Название товара',
	FORMAT(Date_,'d MMMM yyyy','ru-RU') AS 'Дата'
FROM 
	[KN301_ARTSYBASHEV].ARTSYBASHEV.product AS p
	INNER JOIN [KN301_ARTSYBASHEV].ARTSYBASHEV.productgroup AS pg
	ON p.IdGroup = pg.IdGroup
	INNER JOIN [KN301_ARTSYBASHEV].ARTSYBASHEV.warehouse AS w
	ON p.IdProduct = w.IdProduct
	INNER JOIN [KN301_ARTSYBASHEV].ARTSYBASHEV.shop AS s
	ON w.IdShop = s.IdShop
WHERE
	p.IdProduct = @IDPRODUCTvar
	AND Date_ = @DATEvar
	AND w.Prizn = N'+'
GROUP BY Date_, PrName
GO

-- Все стоимости товара с id = @IDPRODUCTvar
DECLARE @IDPRODUCTvar AS TINYINT = 8
SELECT 
	PrCent AS 'Стоимость',
	@IDPRODUCTvar AS 'ID товара',
	PrName AS 'Название товара'
FROM
	[KN301_ARTSYBASHEV].ARTSYBASHEV.product AS p
	INNER JOIN [KN301_ARTSYBASHEV].ARTSYBASHEV.productgroup AS pg
	ON p.IdGroup = pg.IdGroup
	INNER JOIN [KN301_ARTSYBASHEV].ARTSYBASHEV.warehouse AS w
	ON p.IdProduct = w.IdProduct
	INNER JOIN [KN301_ARTSYBASHEV].ARTSYBASHEV.shop AS s
	ON w.IdShop = s.IdShop
WHERE p.IdProduct = @IDPRODUCTvar
GROUP BY PrCent, PrName
GO
