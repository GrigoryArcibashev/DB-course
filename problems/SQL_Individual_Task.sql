USE master
GO

IF EXISTS (
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
   WHERE name = N'ARTSYBASHEV4'
) 
DROP SCHEMA ARTSYBASHEV4
GO

CREATE SCHEMA ARTSYBASHEV4
GO

CREATE TABLE ARTSYBASHEV4.authors
(
	code_author INT UNIQUE NOT NULL,
	name_author VARCHAR(30),
	birthday DATE,
	CONSTRAINT PK_code_author PRIMARY KEY(code_author)
)
GO

CREATE TABLE ARTSYBASHEV4.publishing_house
(
	code_publish INT UNIQUE NOT NULL,
	publish VARCHAR(30),
	city VARCHAR(30),
	CONSTRAINT PK_code_publish PRIMARY KEY(code_publish)
)
GO

CREATE TABLE ARTSYBASHEV4.books
(
	code_book INT UNIQUE NOT NULL,
	title_book VARCHAR(100),
	code_author INT NOT NULL,
	pages INT,
	code_publish INT NOT NULL,
	CONSTRAINT PK_code_book PRIMARY KEY(code_book),
	CONSTRAINT FK_code_author FOREIGN KEY(code_author)
	REFERENCES ARTSYBASHEV4.authors(code_author),
	CONSTRAINT FK_code_publish FOREIGN KEY(code_publish)
	REFERENCES ARTSYBASHEV4.publishing_house(code_publish)
)
GO

CREATE TABLE ARTSYBASHEV4.deliveries
(
	code_delivery INT UNIQUE NOT NULL,
	name_delivery VARCHAR(50),
	name_company VARCHAR(50),
	addres VARCHAR(50),
	phone NUMERIC(10),
	INN VARCHAR(12),
	CONSTRAINT PK_code_delivery PRIMARY KEY(code_delivery)
)
GO

CREATE TABLE ARTSYBASHEV4.purchases
(
	code_purchase INT UNIQUE NOT NULL,
	code_book INT NOT NULL,
	date_order DATE,
	code_delivery INT NOT NULL,
	type_purchase BIT,
	cost NUMERIC(15,2),
	amount INT,
	CONSTRAINT FK_code_book FOREIGN KEY(code_book)
	REFERENCES ARTSYBASHEV4.books(code_book),
	CONSTRAINT FK_code_delivery FOREIGN KEY(code_delivery)
	REFERENCES ARTSYBASHEV4.deliveries(code_delivery)
)
GO

INSERT INTO ARTSYBASHEV4.authors (code_author, name_author, birthday)
VALUES
	(1, N'authorName1', '01/01/1840'),
	(2, N'authorName2', '01/01/1976'),
	(3, N'authorName3', '02/06/1857'),
	(4, N'authorName4', '02/03/1954'),
	(5, N'Акунин Борис', '20/05/1956'),
	(6, N'authorName6', '22/08/1860'),
	(7, N'Кассиль Лев Абрамович', '27/06/1905'),
	(8, N'Куприн Александр Иванович', '26/08/1870'),
	(9, N'Вишневский Владимир Петрович', '20/08/1953'),
	(10, N'Иванова Лидия Михайловна', '07/03/1936'),
	(11, N'Иванов Анатолий Степанович', NULL),
	(12, N'Иванов Алексей Викторович', '23/11/1969'),	
	(13, N'Асиман Андрей', '02/01/1951'),
	(14, N'Ширвиндт Михаил', '14/08/1958'),
	(15, N'Голден Артур', '06/12/1956'),
	(16, N'Толстой Л.Н.', '28/08/1828'),
	(17, N'Достоевский Ф.М.', '30/10/1821'),
	(18, N'Пушкин А.С.', '26/05/1799')
GO

INSERT INTO ARTSYBASHEV4.publishing_house (code_publish, publish, city)
VALUES
	(1, N'publish1', N'Новосибирск'),
	(4, N'НГИ', N'Нижний Новгород'),
	(5, N'publish5', N'Новосибирск'),
	(6, N'Альфа', N'Москва'),
	(7, N'publish7', N'Новосибирск'),
	(9, N'Наука', N'Москва'),
	(10, N'Питер Софт', N'Санкт-Петербург'),
	(13, N'Мир', N'Москва'),
	(14, N'Питер', N'Санкт-Петербург'),
	(15, N'Питер Софт', N'Санкт-Петербург')
GO

INSERT INTO ARTSYBASHEV4.books (code_book, title_book, code_author, pages, code_publish)
VALUES
	(2, N'Труды', 11, 107, 1),
	(3, N'Труды2', 12, 342, 10),
	(4, N'Мемуары гейши', 13, 384, 15),
	(7, N'Из Египта. Мемуары', 3, 250, 13),
	(8, N'bookname8', 2, 339, 1),
	(9, N'bookname9', 10, 384, 6),
	(10, N'bookname10', 5, 324, 6),
	(11, N'bookname11', 1, 353, 6),
	(12, N'Мемуары двоечника', 13, 287, 14),
	(13, N'Труды Университета', 11, 389, 7),
	(15, N'bookname15', 7, 388, 7),
	(17, N'bookname17', 8, 379, 5),
	(18, N'bookname18', 15, 238, 4),
	(23, N'bookname23', 4, 301, 9),
	(24, N'bookname24', 9, 398, 7),
	(26, N'bookname26', 14, 303, 1),
	(31, N'Отрочество', 16, 80, 4),
	(32, N'Казаки', 16, 208, 4),
	(33, N'Игрок', 17, 224, 4),
	(34, N'Сказки', 18, 144, 4)
GO

INSERT INTO ARTSYBASHEV4.deliveries (code_delivery, name_delivery, name_company, addres, phone, INN)
VALUES
	(1, N'dilvery1', N'company1', N'adress1', 256678, N'19354851'),
	(2, N'dilvery2', N'company2', N'adress2', 256679, N'13498045'),
	(3, N'dilvery3', N'ОАО "Книги"', N'adress3', 256680, N'8601020863'),
	(4, N'dilvery4', N'ОАО Луч', N'adress4', 256681, N'7709028658'),
	(5, N'dilvery5', N'company5', N'adress5', 256682, N'14401362'),
	(6, N'dilvery6', N'ОАО «Каменск-Уральская типография»', N'adress6', 256683, N'6612045778'),
	(7, N'dilvery7', N'ОАО Книготорг', N'adress7', 256684, N'917024242'),
	(8, N'dilvery8', N'ЗАО Квантор', N'adress8', 256685, N'7725704102'),
	(9, N'dilvery9', N'company9', N'adress9', 256686, N'16251647'),
	(10, N'dilvery10', N'ОАО «Полиграфическое объединение «Север»', N'adress10', 256687, N'6680004508'),
	(11, N'dilvery11', N'Комбинат Волгоградский', N'adress11', 256688, N'3446015546'),
	(12, N'dilvery12', N'Торговый Дом Волжский', N'adress12', 256689, N'6313001606'),
	(13, N'dilvery13', N'company13', N'adress13', 256690, N'15316511'),
	(14, N'dilvery14', N'ЗАО Оптторг', N'adress14', 256691, N'6670129307'),
	(15, N'dilvery15', N'company15', N'adress15', 256692, N'18175323')
GO

INSERT INTO ARTSYBASHEV4.purchases(code_purchase, code_book, date_order, code_delivery, type_purchase, cost, amount)
VALUES
	(2,		24,	'02/01/2018',	4,	0,	 137.00,	13),
	(4,		12,	'04/01/2003',	8,	1,	 164.00,	2),
	(8,		15,	'14/05/2003',	5,	1,	 149.00,	0),
	(10,	11,	'10/06/2003',	4,	1,	 169.00,	19),
	(12,	8,	'12/01/2018',	8,	0,	 172.00,	10),
	(13,	3,	'13/01/2018',	5,	0,	187.00,		1),
	(14,	10,	'14/01/2002',	2,	1,	 128.00,	1),
	(15,	17,	'15/01/2018',	2,	0,	 139.00,	17),
	(16,	10,	'16/01/2018',	11,	0,	 176.00,	1),
	(19,	24,	'19/01/2018',	11,	0,	 132.00,	18),
	(21,	3,	'21/01/2018',	9,	1,	 146.00,	20),
	(22,	2,	'22/05/2002',	1,	0,	118.00,		12),
	(24,	26,	'24/01/2018',	7,	1,	 150.00,	18),
	(26,	23,	'26/01/2018',	8,	1,	 103.00,	7),
	(34,	12,	'03/02/2018',	5,	1,	 148.00,	22),
	(35,	24,	'04/02/2018',	7,	0,	 145.00,	4),
	(36,	24,	'05/02/2018',	11,	0,	 190.00,	21),
	(37,	4,	'06/02/2018',	11,	1,	 122.00,	1),
	(38,	4,	'07/02/2018',	3,	0,	 113.00,	0),
	(44,	26,	'13/02/2018',	5,	1,	 180.00,	12),
	(45,	9,	'14/02/2018',	12,	0,	 198.00,	16),
	(46,	7,	'15/02/2018',	7,	1,	 163.00,	21),
	(47,	8,	'16/02/2018',	1,	0,	 105.00,	17),
	(53,	11,	'22/02/2018',	11,	0,	 149.00,	6),
	(54,	24,	'23/02/2018',	15,	0,	 123.00,	13),
	(55,	13,	'24/02/2018',	4,	1,	 140.00,	5),
	(58,	10,	'27/02/2018',	13,	0,	 160.00,	22),
	(60,	9,	'01/03/2018',	1,	1,	 119.00,	5),
	(61,	31,	'01/01/2018',	3,	1,	 51.00,		5),
	(62,	32,	'01/02/2013',	3,	1,	 70.00,		5),
	(63,	33,	'21/11/2020',	4,	1,	 191.00,	5),
	(64,	34,	'22/11/2020',	4,	1,	 185.00,	6),
	(65,	34,	'23/11/2020',	4,	0,	 185.00,	110),
	(66,	9,	'24/11/2020',	2,	1,	 400.00,	5),
	(67,	32,	'21/03/2018',	1,	0,	 69.00,		20),
	(68,	23,	'20/02/2018',	8,	0,	 100.00,	20)
GO

/*
1
Выбрать все сведения о книгах из таблицы Books 
и отсортировать результат по коду книги (поле Code_book)
*/
SELECT * 
FROM ARTSYBASHEV4.books
ORDER BY code_book
GO

/*
2
Выбрать из таблицы Books названия книг и количество страниц
(поля Title_book и Pages), а из таблицы Authors выбрать 
имя соответствующего автора книги (поле Name_ author)
*/
SELECT title_book, pages, name_author
FROM 
	ARTSYBASHEV4.books AS b
	INNER JOIN ARTSYBASHEV4.authors AS a
	ON b.code_author = a.code_author
GO

/*
3
Выбрать из таблицы Authors фамилии, имена, отчества авторов 
(поле Name_author), значения которых начинаются с ‘Иванов'
*/
SELECT name_author
FROM ARTSYBASHEV4.authors
WHERE name_author LIKE N'%Иванов%'
GO

/*
4
Вывести список названий книг (поле Title_book) 
и количество страниц (поле Pages) из таблицы Books, 
у которых объем в страницах укладывается в диапазон 200 - 300 (условие по полю Pages)
*/
SELECT title_book, pages
FROM ARTSYBASHEV4.books
WHERE pages >= 200 AND pages <= 300
GO

/*
5
Вывести список авторов (поле Name_author) из таблицы Authors,
которые начинаются на букву 'К'
*/
SELECT name_author
FROM ARTSYBASHEV4.authors
WHERE LEFT(LTRIM(name_author), 1) = N'К'
GO

/*
6
Вывести список издательств (поле Publish) из таблицы Publishing_house, 
в которых выпущены книги, названия которых (поле Title_book) начинаются 
со слова ‘Труды' и город издания (поле City) - ‘Новосибирск'
*/
SELECT publish
FROM 
	ARTSYBASHEV4.publishing_house AS ph
	INNER JOIN ARTSYBASHEV4.books AS b
	ON ph.code_publish = b.code_publish
WHERE LEFT(b.title_book, 5) = N'Труды' AND ph.city = N'Новосибирск'
GO

/*
7
Вывести суммарную стоимость партии одноименных книг (использовать поля 
Amount и Cost) и название книги (поле Title_book) в каждой поставке.
*/
SELECT title_book, cost * amount AS total_cost
FROM 
	ARTSYBASHEV4.purchases AS p
	INNER JOIN ARTSYBASHEV4.books AS b
	ON p.code_book = b.code_book
GO

/*
8
Вывести среднюю стоимость (использовать поле Cost) и среднее 
количество экземпляров книг (использовать поле Amount) в одной поставке, 
где автором книги является ‘Акунин' (условие по полю Name_author).
*/
SELECT AVG(cost) AS avg_cost, AVG(amount) AS avg_amount
FROM 
	ARTSYBASHEV4.purchases AS p
	INNER JOIN ARTSYBASHEV4.books AS b
	ON p.code_book = b.code_book
	INNER JOIN ARTSYBASHEV4.authors AS a
	ON b.code_author = a.code_author
WHERE a.name_author LIKE N'%Акунин%'
GO

/*
9
Вывести общую сумму поставок книг (использовать поле Cost) 
и поместить результат в поле с названием Sum_cost, 
выполненных ‘ОАО Луч' (условие по полю Name_company)
*/
SELECT SUM(cost) AS Sum_cost
FROM 
	ARTSYBASHEV4.purchases AS p
	INNER JOIN ARTSYBASHEV4.deliveries AS d
	ON p.code_delivery = d.code_delivery
WHERE name_company = N'ОАО Луч'
GO

/*
10
Вывести список авторов (поле Name_author), 
книги которых были выпущены в издательствах 
‘Мир', ‘Питер Софт', ‘Наука' (условие по полю Publish)
*/
SELECT name_author
FROM
	ARTSYBASHEV4.authors AS a
	INNER JOIN ARTSYBASHEV4.books AS b
	ON a.code_author = b.code_author
	INNER JOIN ARTSYBASHEV4.publishing_house AS ph
	ON b.code_publish = ph.code_publish
WHERE publish IN (N'Мир', N'Питер Софт', N'Наука')
GROUP BY name_author
GO

/*
11
Вывести список книг (поле Title_book), у которых количество страниц 
(поле Pages) больше среднего количества страниц всех книг в таблице.
*/
SELECT title_book
FROM ARTSYBASHEV4.books
WHERE pages > (SELECT AVG(pages) FROM ARTSYBASHEV4.books)
GO

/*
12
Вывести список книг (поле Title_book), которые были поставлены 
поставщиком ‘ЗАО Квантор' (условие по полю Name_company).
*/
SELECT title_book
FROM
	ARTSYBASHEV4.books AS b
	INNER JOIN ARTSYBASHEV4.purchases AS p
	ON b.code_book = p.code_book
	INNER JOIN ARTSYBASHEV4.deliveries AS d
	ON p.code_delivery = d.code_delivery
WHERE d.name_company = N'ЗАО Квантор'
GROUP BY title_book
GO

/*
13
Добавить в таблицу Books новую запись, причем вместо ключевого поля
поставить код (поле Code_book), автоматически увеличенный на единицу
от максимального кода в таблице, вместо названия книги (поле Title_book)
написать ‘Наука. Техника. Инновации'.
*/
INSERT INTO ARTSYBASHEV4.books (code_book, title_book, code_author, pages, code_publish)
VALUES
	(
		(SELECT MAX(code_book) FROM ARTSYBASHEV4.books) + 1,
		N'Наука. Техника. Инновации', 
		1, 
		100, 
		1
	)
GO

-- проверка
SELECT code_book, title_book
FROM ARTSYBASHEV4.books
ORDER BY code_book
GO

/*
14
Создать триггер для команд INSERT и UPDATE таблицы Purchases, 
запрещающий производить изменения для поставщика, 
у которого не заполнены поля адрес и телефон.
*/
CREATE TRIGGER check_purchases_insert
ON ARTSYBASHEV4.purchases
INSTEAD OF INSERT
AS
	DECLARE @value VARCHAR(20)
	BEGIN
		SET @value = (
			SELECT d.code_delivery
			FROM inserted
			INNER JOIN ARTSYBASHEV4.deliveries AS d
			ON inserted.code_delivery = d.code_delivery
			WHERE d.phone IS NULL OR d.addres IS NULL
		)
		IF (DATALENGTH(@value) > 0)
			BEGIN
			ROLLBACK
			RAISERROR(N'ОШИБКА: У ПОСТАВЩИКА НЕ ЗАПОЛНЕНЫ ДАННЫЕ (АДРЕС/ТЕЛЕФОН)', 1, 1)
			END
		ELSE
			BEGIN
			INSERT INTO ARTSYBASHEV4.purchases
			SELECT * FROM inserted
			END
	END
GO

CREATE TRIGGER check_purchases_update
ON ARTSYBASHEV4.purchases
INSTEAD OF UPDATE
AS
	DECLARE @value VARCHAR(20)
	BEGIN
		SET @value = (
			SELECT d.code_delivery
			FROM inserted
			INNER JOIN ARTSYBASHEV4.deliveries AS d
			ON inserted.code_delivery = d.code_delivery
			WHERE d.phone IS NULL OR d.addres IS NULL
		)
		IF (DATALENGTH(@value) > 0)
			BEGIN
			ROLLBACK
			RAISERROR(N'ОШИБКА: У ПОСТАВЩИКА НЕ ЗАПОЛНЕНЫ ДАННЫЕ (АДРЕС/ТЕЛЕФОН)', 1, 1)
			END
		ELSE
			BEGIN
			INSERT INTO ARTSYBASHEV4.purchases
			SELECT * FROM inserted
			END
	END
GO

-- проверка триггера на вставку
/*
INSERT INTO ARTSYBASHEV4.deliveries
(code_delivery, name_delivery, name_company, addres, phone, INN)
VALUES
	(1000, N'bad_dilvery1', N'bad_company1', N'bad_adress', NULL, N'')
GO
INSERT INTO ARTSYBASHEV4.purchases
(code_purchase, code_book, date_order, code_delivery, type_purchase, cost, amount)
VALUES
	(1000, 24, '02/01/2018', 1000, 0, 1000.00, 1000)
GO
SELECT *
FROM ARTSYBASHEV4.deliveries
ORDER BY code_delivery
GO
*/
SELECT *
FROM ARTSYBASHEV4.purchases
ORDER BY code_purchase
GO

/*
15
Создать процедуру, которая для указанного ИНН поставщика выводит информацию о продажах:
Дата, Книга, Издательство, Общая стоимость, отсортированную по дате, по каждому месяцу 
показать итог, показать общий итог.
*/
CREATE PROCEDURE PurchasesInfoByINN
(@INN VARCHAR(12))
AS
BEGIN
	SELECT
		date_order AS 'Дата',
		title_book AS 'Название книги',
		b.code_book AS 'Код книги',
		publish AS 'Издательство',
		b.code_publish AS 'Код издательства',
		cost * amount AS 'Общая стоимость'
	FROM 
		ARTSYBASHEV4.deliveries AS d
		INNER JOIN ARTSYBASHEV4.purchases AS p
		ON d.code_delivery = p.code_delivery
		INNER JOIN ARTSYBASHEV4.books AS b
		ON p.code_book = b.code_book
		INNER JOIN ARTSYBASHEV4.publishing_house AS ph
		ON b.code_publish = ph.code_publish
	WHERE INN = @INN
	ORDER BY date_order

	SELECT
		YEAR(date_order) AS 'Год',
		MONTH(date_order) AS 'Номер месяца',
		DATENAME(MONTH, date_order) AS 'Месяц',
		SUM(amount) AS 'Продано книг',
		SUM(cost * amount) AS 'Выручка за месяц'
	FROM 
		ARTSYBASHEV4.deliveries AS d
		INNER JOIN ARTSYBASHEV4.purchases AS p
		ON d.code_delivery = p.code_delivery
		INNER JOIN ARTSYBASHEV4.books AS b
		ON p.code_book = b.code_book
		INNER JOIN ARTSYBASHEV4.publishing_house AS ph
		ON b.code_publish = ph.code_publish
	WHERE INN = @INN
	GROUP BY
		YEAR(date_order),
		MONTH(date_order),
		DATENAME(MONTH, date_order)
	ORDER BY
		YEAR(date_order),
		MONTH(date_order)

	SELECT
		SUM(amount) AS ' Всё количество проданных книг',
		SUM(cost * amount) AS 'Вся выручка'
	FROM 
		ARTSYBASHEV4.deliveries AS d
		INNER JOIN ARTSYBASHEV4.purchases AS p
		ON d.code_delivery = p.code_delivery
		INNER JOIN ARTSYBASHEV4.books AS b
		ON p.code_book = b.code_book
		INNER JOIN ARTSYBASHEV4.publishing_house AS ph
		ON b.code_publish = ph.code_publish
	WHERE INN = @INN
END
GO

EXEC PurchasesInfoByINN N'19354851'
GO