CREATE TABLE BrandData (
    BRAND1 VARCHAR(50),
    BRAND2 VARCHAR(50),
    YEAR INT,
    CUSTOM1 INT,
    CUSTOM2 INT,
    CUSTOM3 INT,
    CUSTOM4 INT
);

INSERT INTO BrandData (BRAND1, BRAND2, YEAR, CUSTOM1, CUSTOM2, CUSTOM3, CUSTOM4) VALUES
('apple', 'samsung', 2020, 1, 2, 1, 2),
('samsung', 'apple', 2020, 1, 2, 1, 2),
('apple', 'samsung', 2021, 1, 2, 5, 3),
('samsung', 'apple', 2021, 5, 3, 1, 2),
('google', NULL, 2020, 5, 9, NULL, NULL),
('oneplus', 'nothing', 2020, 5, 9, 6, 3);

SELECT *
FROM SqlQueries..BrandData

-- Problem statement
-- For pairs of brands in the same year
	-- If custom1 = custom3 and custom2 = custom4 keep only one pair
-- For pairs of brands in the same year
	-- If custom1 != custom3 and custom2 != custom4 keep both pairs
-- For brands that do not have pairs in the same year, keep those rows

WITH cte1 AS(
SELECT *,
CASE
	WHEN BRAND1 < BRAND2 THEN CONCAT(BRAND1, BRAND2, YEAR)
	ELSE CONCAT(BRAND2, BRAND1, YEAR)
END AS NewID
FROM SqlQueries..BrandData
),

Filtered_data AS(
SELECT *,
ROW_NUMBER() OVER (PARTITION BY NewID ORDER BY NewID) AS rn
FROM cte1
)

SELECT *
FROM Filtered_data
WHERE rn = 1
OR(CUSTOM1 <> CUSTOM3 AND CUSTOM2 <> CUSTOM4)







