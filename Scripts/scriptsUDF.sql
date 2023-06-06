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