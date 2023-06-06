CREATE TRIGGER [dbo].[start_corridas] ON [dbo].[Corridas]
INSTEAD OF INSERT 
AS
BEGIN
	IF (SELECT count(*) FROM inserted) > 0
		BEGIN
			DECLARE @partida as varchar(255);
			DECLARE @destino as varchar(255);
			DECLARE @id_cliente as int;
			DECLARE @id_motorista as int;
			DECLARE @status as varchar(50);
			

			SELECT @partida = partida, @destino = destino, @id_cliente = id_cliente, @id_motorista = id_motorista,@status = [status]  FROM inserted;

			INSERT INTO Corridas(partida,destino,inicio,id_cliente,id_motorista,[status]) values(@partida,@destino,GETDATE(),@id_cliente, @id_motorista, @status);

		END
END;
GO



CREATE TRIGGER [dbo].[update_corridas] ON [dbo].[Corridas]
INSTEAD OF UPDATE 
AS
BEGIN
	IF (SELECT count(*) FROM inserted) > 0
		BEGIN
			DECLARE @gorjeta as int;					
			DECLARE @status as varchar(50);
			DECLARE @id as INT;
			DECLARE @inicio as datetime;
			DECLARE @fim as datetime = GETDATE();			
			
			
			DECLARE @valor_pagamento as int;
			SELECT @valor_pagamento = CAST((RAND() * 100) + 1 AS INT) ;

			SELECT @id = id, @gorjeta = gorjeta, @status = [status], @inicio = inicio  FROM inserted;

			DECLARE @HourDiff as int;
			SELECT @HourDiff = DATEDIFF(hour, @inicio,@fim) ;
			
			DECLARE @MinuteDiff as int;
			SELECT @MinuteDiff = DATEDIFF(minute, @inicio,@fim) % 60;
			PRINT @MinuteDiff;
			DECLARE @SecondDiff as int;
			SELECT @SecondDiff = DATEDIFF(second, @inicio,@fim) % 60; 

			DECLARE @duracao as varchar(255) = CONCAT(@HourDiff,':',@MinuteDiff, ':', @SecondDiff);
			

			UPDATE Corridas SET gorjeta = @gorjeta, [status] = @status, pagamento = @valor_pagamento,fim = @fim, duracao = @duracao WHERE id = @id;			

		END
END;




CREATE TRIGGER [dbo].[Ponto_Descanso_Insert] ON [dbo].[Ponto_Descanso]
INSTEAD OF INSERT
AS
BEGIN
	IF (SELECT count(*) FROM inserted) = 1
	BEGIN
		DECLARE @id_ponto_recarga as int;
		DECLARE @morada as varchar(255);
		DECLARE @capacidade as int;
		DECLARE @avaliacao as int;
		DECLARE @InsertedID INT;
		DECLARE @nome as varchar(255);
		SELECT @avaliacao = CAST((RAND() * 5) + 1 AS INT) ;

		

		SELECT @id_ponto_recarga = id_ponto_recarga, @morada = morada, @capacidade = capacidade, @nome = nome FROM inserted;

		IF (@id_ponto_recarga) is null
		BEGIN
			INSERT INTO Ponto_Recarga(empresa,capacidade,disponibilidade,morada)values ('Brunao LTDA',@capacidade, 1, @morada)
			
			SET @InsertedID = SCOPE_IDENTITY();
			INSERT INTO Ponto_Descanso(morada, capacidade, avaliacao, id_ponto_recarga, nome) values (@morada,@capacidade,@avaliacao, @InsertedID, @nome)
		END
		ELSE
		BEGIN
			INSERT INTO Ponto_Descanso(morada, capacidade, avaliacao, id_ponto_recarga, nome) values (@morada,@capacidade,@avaliacao,@id_ponto_recarga, @nome)
		END
		
		SET @InsertedID = SCOPE_IDENTITY();

		INSERT INTO Ponto_Descanso_Comodidades values (@InsertedID,1);
		INSERT INTO Ponto_Descanso_Comodidades values (@InsertedID,2);


	END
END