USE [p10g2]
GO
/****** Object:  User [p10g2]    Script Date: 6/6/2023 11:05:20 PM ******/
CREATE USER [p10g2] FOR LOGIN [p10g2] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [p10g2]
GO
/****** Object:  UserDefinedFunction [dbo].[Soma_Pagamento_Clientes]    Script Date: 6/6/2023 11:05:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Soma_Pagamento_Clientes] (@id int) RETURNS money
AS
BEGIN
	DECLARE @money money;
	SELECT @money = sum(pagamento) FROM Corridas WHERE id_cliente = @id
	IF(@money IS NULL)
		BEGIN
			set @money = 0;			
		END
	RETURN @money;
END

GO
/****** Object:  UserDefinedFunction [dbo].[soma_Salario_Motorista]    Script Date: 6/6/2023 11:05:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[soma_Salario_Motorista] (@id int) RETURNS money
AS
	BEGIN
		DECLARE @money money;
		DECLARE @date int = MONTH(GETDATE());
		SELECT @money = sum(pagamento)*80/100 FROM Corridas WHERE id_motorista = @id AND (MONTH(inicio) = @date);
		IF(@money IS NULL)
		BEGIN
			set @money = 0;			
		END
		RETURN @money;
	END
GO
/****** Object:  Table [dbo].[Ponto_Recarga]    Script Date: 6/6/2023 11:05:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ponto_Recarga](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[empresa] [varchar](255) NOT NULL,
	[capacidade] [int] NOT NULL,
	[disponibilidade] [bit] NOT NULL,
	[morada] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[list_recarga]    Script Date: 6/6/2023 11:05:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[list_recarga]
AS
SELECT * FROM Ponto_Recarga;
GO
/****** Object:  Table [dbo].[Clientes]    Script Date: 6/6/2023 11:05:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clientes](
	[id] [int] NOT NULL,
 CONSTRAINT [PK_Clientes] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Clientes_Forma_de_Pagamento]    Script Date: 6/6/2023 11:05:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clientes_Forma_de_Pagamento](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_cliente] [int] NOT NULL,
	[id_forma_de_pagamento] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comodidades]    Script Date: 6/6/2023 11:05:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comodidades](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[tipo] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Corridas]    Script Date: 6/6/2023 11:05:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Corridas](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[partida] [varchar](255) NOT NULL,
	[destino] [varchar](255) NOT NULL,
	[inicio] [datetime] NULL,
	[fim] [datetime] NULL,
	[duracao] [varchar](255) NULL,
	[pagamento] [money] NULL,
	[gorjeta] [money] NULL,
	[id_cliente] [int] NOT NULL,
	[id_motorista] [int] NOT NULL,
	[status] [varchar](50) NOT NULL,
 CONSTRAINT [PK__Corridas__3213E83FF7B1B58F] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Formas_de_pagamento]    Script Date: 6/6/2023 11:05:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Formas_de_pagamento](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[tipo] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Mensagens]    Script Date: 6/6/2023 11:05:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mensagens](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[texto] [varchar](255) NOT NULL,
	[data] [datetime] NOT NULL,
	[status] [varchar](255) NOT NULL,
	[corrida_id] [int] NOT NULL,
	[pessoa_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Motorista_Veiculos]    Script Date: 6/6/2023 11:05:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Motorista_Veiculos](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_motorista] [int] NOT NULL,
	[id_veiculo] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Motoristas]    Script Date: 6/6/2023 11:05:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Motoristas](
	[id] [int] NOT NULL,
	[carta_conducao] [varchar](12) NULL,
 CONSTRAINT [PK_Motoristas] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pessoas]    Script Date: 6/6/2023 11:05:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pessoas](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](255) NOT NULL,
	[email] [varchar](255) NOT NULL,
	[foto] [varchar](255) NOT NULL,
	[avaliacao] [float] NOT NULL,
	[telefone] [int] NOT NULL,
 CONSTRAINT [PK__Pessoas__3213E83F6F97A537] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ponto_Descanso]    Script Date: 6/6/2023 11:05:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ponto_Descanso](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[morada] [varchar](255) NOT NULL,
	[capacidade] [int] NOT NULL,
	[avaliacao] [float] NULL,
	[id_ponto_recarga] [int] NULL,
	[nome] [varchar](255) NULL,
 CONSTRAINT [PK__Ponto_De__3213E83F41A1D4E3] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ponto_Descanso_Comodidades]    Script Date: 6/6/2023 11:05:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ponto_Descanso_Comodidades](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_ponto_descanso] [int] NOT NULL,
	[id_comodidades] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Veiculos]    Script Date: 6/6/2023 11:05:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Veiculos](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[marca] [varchar](255) NOT NULL,
	[modelo] [varchar](255) NOT NULL,
	[cor] [varchar](255) NOT NULL,
	[lugares] [int] NULL,
	[matricula] [varchar](50) NOT NULL,
	[capacidade_bateria] [int] NOT NULL,
 CONSTRAINT [PK__Veiculos__3213E83F762A1CEA] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Clientes]  WITH CHECK ADD  CONSTRAINT [FK_Clientes_Pessoas] FOREIGN KEY([id])
REFERENCES [dbo].[Pessoas] ([id])
GO
ALTER TABLE [dbo].[Clientes] CHECK CONSTRAINT [FK_Clientes_Pessoas]
GO
ALTER TABLE [dbo].[Clientes_Forma_de_Pagamento]  WITH CHECK ADD  CONSTRAINT [FK__Clientes___id_fo__1C5231C2] FOREIGN KEY([id_forma_de_pagamento])
REFERENCES [dbo].[Formas_de_pagamento] ([id])
GO
ALTER TABLE [dbo].[Clientes_Forma_de_Pagamento] CHECK CONSTRAINT [FK__Clientes___id_fo__1C5231C2]
GO
ALTER TABLE [dbo].[Clientes_Forma_de_Pagamento]  WITH CHECK ADD  CONSTRAINT [FK_Clientes_Forma_de_Pagamento_Clientes] FOREIGN KEY([id_cliente])
REFERENCES [dbo].[Clientes] ([id])
GO
ALTER TABLE [dbo].[Clientes_Forma_de_Pagamento] CHECK CONSTRAINT [FK_Clientes_Forma_de_Pagamento_Clientes]
GO
ALTER TABLE [dbo].[Corridas]  WITH CHECK ADD  CONSTRAINT [FK_Corridas_Clientes] FOREIGN KEY([id_cliente])
REFERENCES [dbo].[Clientes] ([id])
GO
ALTER TABLE [dbo].[Corridas] CHECK CONSTRAINT [FK_Corridas_Clientes]
GO
ALTER TABLE [dbo].[Corridas]  WITH CHECK ADD  CONSTRAINT [FK_Corridas_Motoristas] FOREIGN KEY([id_motorista])
REFERENCES [dbo].[Motoristas] ([id])
GO
ALTER TABLE [dbo].[Corridas] CHECK CONSTRAINT [FK_Corridas_Motoristas]
GO
ALTER TABLE [dbo].[Mensagens]  WITH CHECK ADD  CONSTRAINT [FK__Mensagens__corri__22FF2F51] FOREIGN KEY([corrida_id])
REFERENCES [dbo].[Corridas] ([id])
GO
ALTER TABLE [dbo].[Mensagens] CHECK CONSTRAINT [FK__Mensagens__corri__22FF2F51]
GO
ALTER TABLE [dbo].[Mensagens]  WITH CHECK ADD  CONSTRAINT [FK_Mensagens_Pessoas] FOREIGN KEY([pessoa_id])
REFERENCES [dbo].[Pessoas] ([id])
GO
ALTER TABLE [dbo].[Mensagens] CHECK CONSTRAINT [FK_Mensagens_Pessoas]
GO
ALTER TABLE [dbo].[Motorista_Veiculos]  WITH CHECK ADD  CONSTRAINT [FK__Motorista__id_ve__14B10FFA] FOREIGN KEY([id_veiculo])
REFERENCES [dbo].[Veiculos] ([id])
GO
ALTER TABLE [dbo].[Motorista_Veiculos] CHECK CONSTRAINT [FK__Motorista__id_ve__14B10FFA]
GO
ALTER TABLE [dbo].[Motorista_Veiculos]  WITH CHECK ADD  CONSTRAINT [FK_Motorista_Veiculos_Motoristas] FOREIGN KEY([id_motorista])
REFERENCES [dbo].[Motoristas] ([id])
GO
ALTER TABLE [dbo].[Motorista_Veiculos] CHECK CONSTRAINT [FK_Motorista_Veiculos_Motoristas]
GO
ALTER TABLE [dbo].[Motoristas]  WITH CHECK ADD  CONSTRAINT [FK_Motoristas_Pessoas] FOREIGN KEY([id])
REFERENCES [dbo].[Pessoas] ([id])
GO
ALTER TABLE [dbo].[Motoristas] CHECK CONSTRAINT [FK_Motoristas_Pessoas]
GO
ALTER TABLE [dbo].[Ponto_Descanso]  WITH CHECK ADD  CONSTRAINT [FK__Ponto_Des__id_po__37FA4C37] FOREIGN KEY([id_ponto_recarga])
REFERENCES [dbo].[Ponto_Recarga] ([id])
GO
ALTER TABLE [dbo].[Ponto_Descanso] CHECK CONSTRAINT [FK__Ponto_Des__id_po__37FA4C37]
GO
ALTER TABLE [dbo].[Ponto_Descanso_Comodidades]  WITH CHECK ADD FOREIGN KEY([id_comodidades])
REFERENCES [dbo].[Comodidades] ([id])
GO
ALTER TABLE [dbo].[Ponto_Descanso_Comodidades]  WITH CHECK ADD  CONSTRAINT [FK__Ponto_Des__id_po__3AD6B8E2] FOREIGN KEY([id_ponto_descanso])
REFERENCES [dbo].[Ponto_Descanso] ([id])
GO
ALTER TABLE [dbo].[Ponto_Descanso_Comodidades] CHECK CONSTRAINT [FK__Ponto_Des__id_po__3AD6B8E2]
GO
/****** Object:  StoredProcedure [dbo].[insertNewPessoa]    Script Date: 6/6/2023 11:05:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

GO
/****** Object:  StoredProcedure [dbo].[insertVeiculo]    Script Date: 6/6/2023 11:05:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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

	select * from Motorista_Veiculos
	select * FROM Veiculos
GO
/****** Object:  StoredProcedure [dbo].[listClientes]    Script Date: 6/6/2023 11:05:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[listClientes]
AS
	SELECT Clientes.id,nome,email,foto,avaliacao,telefone FROM Pessoas INNER JOIN Clientes ON Pessoas.id = Clientes.id 

	
GO
/****** Object:  StoredProcedure [dbo].[listMotoristas]    Script Date: 6/6/2023 11:05:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[listMotoristas]
AS
	SELECT Motoristas.id,nome,email,foto,avaliacao,telefone,carta_conducao FROM Pessoas INNER JOIN Motoristas ON Pessoas.id = Motoristas.id 


GO
/****** Object:  StoredProcedure [dbo].[sp_Cliente_Corridas]    Script Date: 6/6/2023 11:05:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_Cliente_Corridas] @cliente_id int = null
AS 
	IF @cliente_id is null
	BEGIN
		PRINT 'Please enter cliente id'
		RETURN
	END
	SELECT id, destino, partida, duracao, pagamento, gorjeta, id_motorista,  id_cliente FROM Corridas
	WHERE id_cliente = @cliente_id
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Cliente_Payment]    Script Date: 6/6/2023 11:05:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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



GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Person_Data]    Script Date: 6/6/2023 11:05:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_Get_Person_Data] @id int = null
AS 
	IF @id is null
	BEGIN
		PRINT 'Please enter id'
		RETURN
	END
	SELECT nome, email, foto, avaliacao, telefone FROM Pessoas
	WHERE id = @id
GO
/****** Object:  StoredProcedure [dbo].[sp_GetComodidades]    Script Date: 6/6/2023 11:05:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_GetComodidades] @id int
AS
	SELECT Comodidades.id,tipo FROM Ponto_Descanso_Comodidades
	INNER JOIN Comodidades ON id_comodidades = Comodidades.id
	WHERE Ponto_Descanso_Comodidades.id_ponto_descanso = @id
	


GO
/****** Object:  StoredProcedure [dbo].[sp_Motorista_Corridas]    Script Date: 6/6/2023 11:05:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[sp_Motorista_Corridas] @motorista_id int = null
AS 
	IF @motorista_id is null
	BEGIN
		PRINT 'Please enter motorista id'
		RETURN
	END
	SELECT destino, partida, duracao, pagamento FROM Corridas
	WHERE id_motorista = @motorista_id
GO
/****** Object:  StoredProcedure [dbo].[sp_Motorista_Veiculos]    Script Date: 6/6/2023 11:05:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
GO
/****** Object:  StoredProcedure [dbo].[sp_PontosDescanso]    Script Date: 6/6/2023 11:05:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_PontosDescanso] @id int
AS
	SELECT * FROM Ponto_Descanso
	WHERE id_ponto_recarga = @id

GO
