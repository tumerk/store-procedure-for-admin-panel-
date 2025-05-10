use TheFirstDatabase;
go

CREATE PROCEDURE CheckProductStock
    @ProductId UNIQUEIDENTIFIER,
    @Quantity INT,
    @IsInStock BIT OUTPUT
AS
BEGIN
    DECLARE @CurrentStock INT;
    SELECT @CurrentStock = Stock FROM Products WHERE Id = @ProductId;

    IF @CurrentStock >= @Quantity
        SET @IsInStock = 1;
    ELSE
        SET @IsInStock = 0;
END;
GO

CREATE PROCEDURE ReduceProductStock
    @ProductId UNIQUEIDENTIFIER,
    @Quantity INT
AS
BEGIN
    UPDATE Product
    SET Stock = Stock - @Quantity
    WHERE Id = @ProductId;
END;
GO

CREATE PROCEDURE NotifyOrderCreated
    @OrderId UNIQUEIDENTIFIER
AS
BEGIN
    INSERT INTO Notifications (Id, Message, CreatedAt)
    VALUES (NEWID(), CONCAT('Order created with ID: ', @OrderId), GETDATE());
END;