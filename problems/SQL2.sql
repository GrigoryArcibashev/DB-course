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
   WHERE name = N'ARTSYBASHEV2'
) 
 DROP SCHEMA ARTSYBASHEV2
GO

CREATE SCHEMA ARTSYBASHEV2
GO

-- Курсы валют
CREATE TABLE ARTSYBASHEV2.currency_rate
( 
	name_of_currency VARCHAR(5) NOT NULL,
	USD DECIMAL(15,5) NOT NULL,
	RUB DECIMAL(15,5) NOT NULL,
	EUR DECIMAL(15,5) NOT NULL,
	JPY DECIMAL(15,5) NOT NULL,
	CHF DECIMAL(15,5) NOT NULL,
	NZD DECIMAL(15,5) NOT NULL,
	GPB DECIMAL(15,5) NOT NULL,
	CONSTRAINT PK_name_of_currency_id PRIMARY KEY (name_of_currency) 
)
GO

CREATE TABLE ARTSYBASHEV2.bank_card
( 
	name_of_currency VARCHAR(5) NOT NULL,
	val DECIMAL(10,5) NOT NULL,
	CONSTRAINT PK_name_of_currency_id_copy PRIMARY KEY (name_of_currency) 
)
GO

-- Удаление нулевого счёта на карте
CREATE TRIGGER bank_card_UPDATE
ON ARTSYBASHEV2.bank_card
AFTER UPDATE 
AS
	DELETE FROM ARTSYBASHEV2.bank_card
	WHERE val = 0
GO

INSERT INTO ARTSYBASHEV2.currency_rate
VALUES 
 ('USD', 1, 61.43, 1.01, 147.12, 0.9974, 1.74, 0.86851),
 ('RUB', 0.0162, 1, 0.0164, 2.42, 0.0161, 0.028, 0.0141),
 ('EUR', 0.99, 60.97, 1, 146.35, 0.9878, 1.69, 0.8605),
 ('JPY', 0.0067, 0.413, 0.068, 1, 0.006677, 0.011755, 0.005842),
 ('CHF', 1, 61.85, 1.01, 149.77, 1, 1.76, 0.87451),
 ('NZD', 0.57465, 35.3, 0.59256, 85.07, 0.56674, 1, 0.50152),
 ('GBP', 1.15, 70.73, 1.16, 171.17, 1.14, 1.99,1)
GO

INSERT INTO ARTSYBASHEV2.bank_card
VALUES 
 ('USD', 100),
 ('RUB', 100),
 ('EUR', 200),
 ('JPY', 1000),
 ('CHF', 400),
 ('NZD', 1),
 ('GBP', 1)
GO

-- 1. Посмотреть баланс карты в указанной валюте 
CREATE PROCEDURE CheckBalance
(@currency VARCHAR(5) = 'USD')
AS 
BEGIN
	SELECT name_of_currency AS currency, val AS 'value'
	FROM ARTSYBASHEV2.bank_card
	WHERE name_of_currency = @currency AND val > 0
END
GO

-- 1'. Посмотреть баланс карты в во всех валютах 
CREATE PROCEDURE CheckAllBalance
AS
BEGIN
	SELECT name_of_currency AS currency, val AS 'value'
	FROM ARTSYBASHEV2.bank_card
END
GO

-- 2. Пополнить карту в указанной валюте
CREATE PROCEDURE TopUpCard
(@currency VARCHAR(5) = 'USD', @amount DECIMAL(10,5))
AS 
BEGIN
	IF NOT EXISTS
	(
		SELECT *
		FROM ARTSYBASHEV2.bank_card
		WHERE name_of_currency = @currency
	)
		PRINT 'UNKNOWN CURRENCY: ' + @currency
	ELSE
		UPDATE ARTSYBASHEV2.bank_card
		SET val = val + @amount
		WHERE name_of_currency = @currency
END
GO

-- 3. Снять средства в указанной валюте
CREATE PROCEDURE WithdrawMoneyFromCard
(@currency VARCHAR(5) = 'USD', @amount DECIMAL(10,5))
AS 
BEGIN
	IF @amount <= 
		(
			SELECT val AS 'money'
			FROM ARTSYBASHEV2.bank_card
			WHERE name_of_currency = @currency
		)
		UPDATE ARTSYBASHEV2.bank_card
		SET val = val - @amount 
		WHERE name_of_currency = @currency
	ELSE
		PRINT 'INSUFFICIENT FUNDS'
END
GO

-- 4. Перевести деньги из одной валюты в другую
CREATE PROCEDURE ConvertCurrency
(
	@from_currency VARCHAR(5) = 'USD', 
	@to_currency VARCHAR(5) = 'RUB', 
	@amount DECIMAL(10,5)
)
AS 
BEGIN
	IF @amount <=
		(
			SELECT val AS 'money'
			FROM ARTSYBASHEV2.bank_card
			WHERE name_of_currency = @from_currency
		)
	BEGIN
		-- пополнить валюту @to_currency 
		UPDATE ARTSYBASHEV2.bank_card
		SET val = CAST(val AS DECIMAL(15,5))
				+ CAST(@amount AS DECIMAL(15,5))
				* CASE @to_currency 
					 WHEN 'RUB' THEN (SELECT CAST(RUB AS DECIMAL(15,5)) FROM ARTSYBASHEV2.currency_rate WHERE name_of_currency = @from_currency)
					 WHEN 'EUR' THEN (SELECT CAST(EUR AS DECIMAL(15,5)) FROM ARTSYBASHEV2.currency_rate WHERE name_of_currency = @from_currency)
					 WHEN 'JPY' THEN (SELECT CAST(JPY AS DECIMAL(15,5)) FROM ARTSYBASHEV2.currency_rate WHERE name_of_currency = @from_currency) 
					 WHEN 'CHF' THEN (SELECT CAST(CHF AS DECIMAL(15,5)) FROM ARTSYBASHEV2.currency_rate WHERE name_of_currency = @from_currency) 
					 WHEN 'NZD' THEN (SELECT CAST(NZD AS DECIMAL(15,5)) FROM ARTSYBASHEV2.currency_rate WHERE name_of_currency = @from_currency)
					 WHEN 'GPB' THEN (SELECT CAST(GPB AS DECIMAL(15,5)) FROM ARTSYBASHEV2.currency_rate WHERE name_of_currency = @from_currency)
					 WHEN 'USD' THEN (SELECT CAST(USD AS DECIMAL(15,5)) FROM ARTSYBASHEV2.currency_rate WHERE name_of_currency = @from_currency)
				  END 
		WHERE name_of_currency = @to_currency;
		-- снять валюту @from_currency 
		UPDATE ARTSYBASHEV2.bank_card
		SET val = val - @amount
		WHERE name_of_currency = @from_currency;
	END
	ELSE
		PRINT 'INSUFFICIENT FUNDS'
	END
GO

-- 5. Перевод всех доступных средств в указанную валюту
CREATE PROCEDURE ShowOverallBalancee
(@currency VARCHAR(5) = 'USD')
AS 
BEGIN
	DECLARE @cursor CURSOR
	DECLARE @name VARCHAR(5)
	DECLARE @value DECIMAL(10,3)
	
	SET @cursor = CURSOR FOR
	SELECT name_of_currency, val
	FROM ARTSYBASHEV2.bank_card
	
	OPEN @cursor
	WHILE 1 = 1
	BEGIN
		FETCH @cursor INTO @name, @value
		IF @@FETCH_STATUS <> 0
			BREAK
		EXEC ConvertCurrency @name, @currency, @value
	END
	CLOSE @cursor ;
	DEALLOCATE @cursor;
END
GO



-- 1. Демонстрация работы CheckBalance
EXEC CheckBalance 'RUB'
GO

-- 2. Демонстрация работы TopUpCard
EXEC TopUpCard N'RUB', 333
EXEC CheckBalance 'RUB'
GO

-- 3. Демонстрация работы WithdrawMoneyFromCard
EXEC WithdrawMoneyFromCard 'RUB', 100
EXEC CheckBalance 'RUB'
GO

-- 4. Демонстрация работы ConvertCurrency
EXEC CheckBalance 'USD'
EXEC CheckBalance 'RUB'
EXEC ConvertCurrency 'USD', 'RUB', 50
EXEC CheckBalance 'USD'
EXEC CheckBalance 'RUB'
GO

-- 5. Демонстрация работы ShowOverallBalancee
EXEC CheckAllBalance
EXEC ShowOverallBalancee 'RUB'
EXEC CheckAllBalance
GO
