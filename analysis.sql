-- Which sectors have the highest average alpha value
-- ie, which sectors are have higher return than the SP500.
SELECT
	"Sector",
	ROUND(AVG("Alpha")::numeric, 4) as "Average Alpha"
FROM stock_metrics
GROUP BY "Sector"
ORDER BY "Average Alpha" DESC;

-- Which 10 stocks have beta <1 and highest alpha value
-- ie, stocks that are less risky than the market, but with high returns.
SELECT
	"Symbol",
	"Sector",
	"Alpha",
	"Beta"
FROM stock_metrics
WHERE "Beta" < 1.0 AND "Alpha" > 0
ORDER BY "Alpha" DESC LIMIT 10;

-- What is the average volatility per sector
SELECT
	"Sector",
	ROUND(AVG("Volatility")::numeric, 4) as "Average Volatility"
FROM stock_metrics
GROUP BY "Sector"
ORDER BY "Average Volatility" DESC;

-- Stocks with highest beta values
SELECT
	"Symbol",
	"Sector",
	"Beta"
FROM stock_metrics
ORDER BY "Beta" DESC LIMIT 5;

-- What percent of stocks have a positive alpha	
SELECT
	"Sector",
	SUM(CASE WHEN "Alpha" > 0 THEN 1 ELSE 0 END) as "Beating Market",
	Round (
		(SUM(CASE WHEN "Alpha" > 0 THEN 1 ELSE 0 END)::numeric / COUNT(*)) * 100, 2
	) as "Beating Market Percentage"
FROM stock_metrics
GROUP BY "Sector"
ORDER BY "Beating Market Percentage" DESC;

-- Categorize stocks into risk categories
WITH Risk_Categories AS (
	SELECT
		"Symbol",
		CASE
			WHEN "Beta" < 0.8 THEN 'Conversative'
			WHEN "Beta" BETWEEN 0.8 AND 1.2 THEN 'Moderate'
			ELSE 'Aggresive'
		END as "Risk Profile"
	FROM stock_metrics
)
SELECT 
	"Risk Profile",
	COUNT(*) as "Stock Count"
FROM Risk_Categories
GROUP BY "Risk Profile"
ORDER BY "Stock Count" DESC;


-- Best alpha stocks in each sector
WITH Top_Stocks AS (
	SELECT
		"Sector",
		"Symbol",
		"Alpha",
		ROW_NUMBER() OVER (PARTITION BY "Sector" ORDER BY "Alpha" DESC) as "Rank"
	FROM stock_metrics
)
SELECT
	"Sector",
	"Symbol",
	"Alpha"
FROM Top_Stocks
WHERE "Rank" <= 3;

-- Calculate average daily growth per sector
SELECT
	m."Sector",
	COUNT(h."Symbol") as "Data Points",
	ROUND(AVG(h."Daily Return")::numeric, 4) as "Average Daily Growth"
FROM individual_stock_history h
JOIN stock_metrics m ON h."Symbol" = m."Symbol"
GROUP BY m."Sector"
ORDER BY "Average Daily Growth" DESC;