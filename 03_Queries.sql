USE TableTennisInventory;
GO

SELECT FullName, Rating, Email, BirthDate
FROM Players
WHERE IsActive = 1
ORDER BY Rating DESC;

SELECT Name, Brand, Price, IsAvailable
FROM Rackets
WHERE Brand = 'Butterfly' AND IsAvailable = 1
ORDER BY Price ASC;

UPDATE Players
SET Rating = Rating + 50
WHERE IsActive = 1;

UPDATE Rackets
SET IsAvailable = 0
WHERE Name = 'Donic Waldner';

DELETE FROM Players
WHERE FullName = 'Роман Ливанов' AND IsActive = 0;

SELECT 
    c.Name AS CategoryName,
    COUNT(r.Id) AS RacketCount,
    AVG(r.Price) AS AvgPrice
FROM Categories c
LEFT JOIN Rackets r ON c.Id = r.CategoryId
GROUP BY c.Id, c.Name
ORDER BY RacketCount DESC;

SELECT 
    Brand,
    COUNT(*) AS RubberCount,
    AVG(Price) AS AvgPrice
FROM Rubbers
GROUP BY Brand
ORDER BY RubberCount DESC;

SELECT 
    r.Name AS RacketName,
    r.Brand,
    r.Price,
    c.Name AS Category
FROM Rackets r
INNER JOIN Categories c ON r.CategoryId = c.Id
ORDER BY r.Name;

SELECT 
    r.Name AS RacketName,
    r.Brand,
    p.FullName AS OwnerName,
    CASE 
        WHEN p.FullName IS NULL THEN 'Не назначена'
        ELSE 'Назначена'
    END AS Status
FROM Rackets r
LEFT JOIN Players p ON r.OwnedBy = p.Id
ORDER BY r.Name;

SELECT 
    p.FullName AS PlayerName,
    r.Name AS RacketName,
    r.Brand
FROM Rackets r
RIGHT JOIN Players p ON r.OwnedBy = p.Id
ORDER BY p.FullName;

SELECT 
    r.Name AS RacketName,
    r.Brand AS RacketBrand,
    r.Price AS RacketPrice,
    c.Name AS Category,
    p.FullName AS OwnerName,
    rub.Name AS RubberName,
    rub.Brand AS RubberBrand,
    rub.Color AS RubberColor,
    rub.Thickness AS RubberThickness,
    CASE 
        WHEN rr.IsForehand = 1 THEN 'Форхенд' 
        ELSE 'Бекхенд' 
    END AS RubberSide
FROM Rackets r
INNER JOIN Categories c ON r.CategoryId = c.Id
LEFT JOIN Players p ON r.OwnedBy = p.Id
LEFT JOIN RacketRubbers rr ON r.Id = rr.RacketId
LEFT JOIN Rubbers rub ON rr.RubberId = rub.Id
ORDER BY r.Name;