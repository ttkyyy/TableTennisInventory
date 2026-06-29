USE TableTennisInventory;
GO

DELETE FROM RacketRubbers;
DELETE FROM Rubbers;
DELETE FROM Rackets;
DELETE FROM Categories;
DELETE FROM Players;
GO

INSERT INTO Players (FullName, Email, Phone, BirthDate, IsActive, Rating) VALUES
('Владимир Тарасов', 'vladimir.t@email.com', '+7-999-123-45-67', '1990-05-12', 1, 850.50),
('Алина Брагина', 'alina.b@email.com', '+7-999-234-56-78', '2003-01-08', 1, 920.00),
('Егор Граблев', 'egor.g@email.com', '+7-999-345-67-89', '2004-10-17', 1, 850.00),
('Роман Ливанов', 'roman.l@email.com', '+7-999-456-78-90', '1985-03-10', 1, 850.50);

INSERT INTO Categories (Name, Description) VALUES
('OFF', 'Атакующие ракетки для активной игры'),
('ALL', 'Универсальные ракетки для любого стиля'),
('DEF', 'Защитные ракетки для контроля мяча');

INSERT INTO Rubbers (Name, Brand, Color, Thickness, Price, IsInStock) VALUES
('Tenergy 05', 'Butterfly', 'Красный', 2.1, 8990, 1),
('Tenergy 05', 'Butterfly', 'Черный', 2.1, 8990, 1),
('Dignics 09c', 'Butterfly', 'Красный', 2.0, 11990, 1),
('Dignics 09c', 'Butterfly', 'Черный', 2.0, 11990, 0),
('Fastarc G-1', 'Nittaku', 'Красный', 2.0, 5490, 1),
('Fastarc G-1', 'Nittaku', 'Черный', 2.0, 5490, 1),
('Rakza 7', 'Yasaka', 'Красный', 2.2, 4990, 0),
('Rakza 7', 'Yasaka', 'Черный', 2.2, 4990, 1);

INSERT INTO Rackets (Name, Brand, Weight, BladeType, Price, IsAvailable, CategoryId, OwnedBy) VALUES
('Viscaria', 'Butterfly', 88.5, 'OFF', 16990, 1, (SELECT TOP 1 Id FROM Categories WHERE Name = 'OFF'), (SELECT TOP 1 Id FROM Players WHERE FullName = 'Владимир Тарасов')),
('Tim Boll ALC', 'Butterfly', 86.0, 'OFF', 15990, 1, (SELECT TOP 1 Id FROM Categories WHERE Name = 'OFF'), (SELECT TOP 1 Id FROM Players WHERE FullName = 'Алина Брагина')),
('Primorac', 'Butterfly', 92.0, 'ALL', 8990, 0, (SELECT TOP 1 Id FROM Categories WHERE Name = 'ALL'), (SELECT TOP 1 Id FROM Players WHERE FullName = 'Владимир Тарасов')),
('Donic Waldner', 'Donic', 85.0, 'ALL', 7490, 1, (SELECT TOP 1 Id FROM Categories WHERE Name = 'ALL'), NULL),
('Joola Rossi', 'Joola', 90.0, 'DEF', 9990, 1, (SELECT TOP 1 Id FROM Categories WHERE Name = 'DEF'), (SELECT TOP 1 Id FROM Players WHERE FullName = 'Роман Ливанов'));

INSERT INTO Rackets (Name, Brand, Weight, BladeType, Price, IsAvailable, CategoryId, OwnedBy) VALUES
('Stiga OFF', 'Stiga', 87.5, 'OFF', 12000, 1, (SELECT TOP 1 Id FROM Categories WHERE Name = 'OFF'), (SELECT TOP 1 Id FROM Players WHERE FullName = 'Егор Граблев'));

DECLARE @ViscariaId UNIQUEIDENTIFIER = (SELECT TOP 1 Id FROM Rackets WHERE Name = 'Viscaria');
DECLARE @TimBollId UNIQUEIDENTIFIER = (SELECT TOP 1 Id FROM Rackets WHERE Name = 'Tim Boll ALC');
DECLARE @PrimoracId UNIQUEIDENTIFIER = (SELECT TOP 1 Id FROM Rackets WHERE Name = 'Primorac');
DECLARE @StigaId UNIQUEIDENTIFIER = (SELECT TOP 1 Id FROM Rackets WHERE Name = 'Stiga OFF');

DECLARE @TenergyRedId UNIQUEIDENTIFIER = (SELECT TOP 1 Id FROM Rubbers WHERE Name = 'Tenergy 05' AND Color = 'Красный' AND Thickness = 2.1);
DECLARE @TenergyBlackId UNIQUEIDENTIFIER = (SELECT TOP 1 Id FROM Rubbers WHERE Name = 'Tenergy 05' AND Color = 'Черный' AND Thickness = 2.1);
DECLARE @DignicsRedId UNIQUEIDENTIFIER = (SELECT TOP 1 Id FROM Rubbers WHERE Name = 'Dignics 09c' AND Color = 'Красный' AND Thickness = 2.0);
DECLARE @FastarcBlackId UNIQUEIDENTIFIER = (SELECT TOP 1 Id FROM Rubbers WHERE Name = 'Fastarc G-1' AND Color = 'Черный' AND Thickness = 2.0);
DECLARE @RakzaRedId UNIQUEIDENTIFIER = (SELECT TOP 1 Id FROM Rubbers WHERE Name = 'Rakza 7' AND Color = 'Красный' AND Thickness = 2.2);
DECLARE @RakzaBlackId UNIQUEIDENTIFIER = (SELECT TOP 1 Id FROM Rubbers WHERE Name = 'Rakza 7' AND Color = 'Черный' AND Thickness = 2.2);

INSERT INTO RacketRubbers (RacketId, RubberId, IsForehand) VALUES
(@ViscariaId, @TenergyRedId, 1),
(@ViscariaId, @TenergyBlackId, 0),
(@TimBollId, @DignicsRedId, 1),
(@TimBollId, @FastarcBlackId, 0),
(@PrimoracId, @RakzaRedId, 1),
(@PrimoracId, @RakzaBlackId, 0),
(@StigaId, @TenergyRedId, 1),
(@StigaId, @TenergyBlackId, 0);