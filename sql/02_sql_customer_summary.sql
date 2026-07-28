-- 지역별 고객수
SELECT
	region,
	count(*) AS customer_count
FROM customers
GROUP BY region
ORDER BY customer_count DESC;

