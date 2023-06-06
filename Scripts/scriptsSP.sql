
CREATE PROC [dbo].[sp_Cliente_Corridas] @cliente_id int = null
AS 
	IF @cliente_id is null
	BEGIN
		PRINT 'Please enter cliente id'
		RETURN
	END
	SELECT id, destino, partida, duracao, pagamento, gorjeta, id_motorista,  id_cliente FROM Corridas
	WHERE id_cliente = @cliente_id



CREATE PROC [dbo].[sp_Get_Cliente_Payment] @cliente_id int = null
AS
	IF @cliente_id is null
	BEGIN
		PRINT 'Please enter Employee Code!'
		RETURN
	END
	SELECT tipo FROM Clientes_Forma_de_Pagamento
	INNER JOIN Formas_de_Pagamento 
	ON id_forma_de_pagamento = Formas_de_Pagamento.id
	WHERE id_cliente = @cliente_id



	CREATE PROC [dbo].[sp_Get_Person_Data] @id int = null
AS 
	IF @id is null
	BEGIN
		PRINT 'Please enter id'
		RETURN
	END
	SELECT nome, email, foto, avaliacao, telefone FROM Pessoas
	WHERE id = @id


	CREATE PROC [dbo].[sp_GetComodidades] @id int
AS
	SELECT Comodidades.id,tipo FROM Ponto_Descanso_Comodidades
	INNER JOIN Comodidades ON id_comodidades = Comodidades.id
	WHERE Ponto_Descanso_Comodidades.id_ponto_descanso = @id



CREATE PROC [dbo].[insertNewPessoa] @nome varchar(255), @email varchar(255), @foto varchar(255),
@avaliacao float, @telefone int, @carta_conducao varchar(12)
AS
	BEGIN TRANSACTION
		
	BEGIN TRY
		DECLARE @InsertedID INT;
		INSERT INTO Pessoas(nome,email,foto,avaliacao,telefone) values(@nome,@email,@foto,@avaliacao,
		@telefone);
		
		SET @InsertedID = SCOPE_IDENTITY();
		IF(@carta_conducao IS NULL)
		BEGIN
			INSERT INTO Clientes values(@InsertedID);
		END
		ELSE
		BEGIN
			INSERT INTO Motoristas values(@InsertedID,@carta_conducao);
		END		
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		 ROLLBACK TRANSACTION;
	END CATCH;



	CREATE PROC [dbo].[insertVeiculo] @id_motorista int , @marca varchar(255), @modelo varchar(255),@cor varchar(255), @lugares int,
@matricula varchar(50),@capacidade_bateria int
AS
	BEGIN TRANSACTION
		
	BEGIN TRY
		DECLARE @InsertedID INT;
		INSERT INTO Veiculos values(@marca,@modelo,@cor,@lugares,@matricula,@capacidade_bateria)
		SET @InsertedID = SCOPE_IDENTITY();

		INSERT INTO Motorista_Veiculos values(@id_motorista,@InsertedID)		
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		 ROLLBACK TRANSACTION;
	END CATCH;

	

	CREATE PROC [dbo].[listClientes]
AS
	SELECT Clientes.id,nome,email,foto,avaliacao,telefone FROM Pessoas INNER JOIN Clientes ON Pessoas.id = Clientes.id 




CREATE PROC [dbo].[listMotoristas]
AS
	SELECT Motoristas.id,nome,email,foto,avaliacao,telefone,carta_conducao FROM Pessoas INNER JOIN Motoristas ON Pessoas.id = Motoristas.id 




CREATE PROC [dbo].[sp_Motorista_Corridas] @motorista_id int = null
AS 
	IF @motorista_id is null
	BEGIN
		PRINT 'Please enter motorista id'
		RETURN
	END
	SELECT destino, partida, duracao, pagamento FROM Corridas
	WHERE id_motorista = @motorista_id




CREATE PROCEDURE [dbo].[sp_Motorista_Veiculos] @motorista_id int
AS
	
	IF @motorista_id is null
		BEGIN
		PRINT 'Please enter motorista id'
		RETURN
	END
	SELECT Veiculos.id , marca, modelo, cor, lugares, matricula, capacidade_bateria FROM Veiculos
	JOIN Motorista_Veiculos ON Veiculos.id =id_veiculo 
	WHERE id_motorista = @motorista_id

	


CREATE PROC [dbo].[sp_PontosDescanso] @id int
AS
	SELECT * FROM Ponto_Descanso
	WHERE id_ponto_recarga = @id



