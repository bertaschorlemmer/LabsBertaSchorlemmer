USE bands;

SELECT mn.musician_name,
       SUM(a.sales_amount) AS total_sales,
       CASE
         WHEN SUM(a.sales_amount) >= 33273156 THEN 'Alta'
         WHEN SUM(a.sales_amount) >= 16636539 THEN 'Media'
         ELSE 'Baja'
       END AS categoria
FROM musician m
JOIN musician_name mn ON m.musician_id = mn.musician_id
JOIN band_musician bm ON m.musician_id = bm.musician_id
JOIN band b ON bm.band_id = b.band_id
JOIN album a ON b.band_id = a.band_id
WHERE bm.musician_status = 'current'
GROUP BY mn.musician_name
ORDER BY total_sales DESC;

SELECT b.band_name, t.best_year, t.total_sales
FROM band b
JOIN (
    SELECT a.band_id, YEAR(a.release_date) AS best_year, SUM(a.sales_amount) AS total_sales
    FROM album a
    GROUP BY a.band_id, YEAR(a.release_date)
) AS t ON b.band_id = t.band_id
JOIN (
    SELECT band_id, MAX(year_sales) AS max_sales
    FROM (
        SELECT band_id, YEAR(release_date) AS y, SUM(sales_amount) AS year_sales
        FROM album
        GROUP BY band_id, YEAR(release_date)
    ) AS yearly_sales
    GROUP BY band_id
) AS m ON t.band_id = m.band_id AND t.total_sales = m.max_sales
ORDER BY t.total_sales DESC, b.band_name;
 
SELECT MIN(mn.musician_name) AS musician_name, bm.musician_id, COUNT(DISTINCT a.album_id) AS albums_cnt
FROM band_musician bm
JOIN album a ON a.band_id = bm.band_id
LEFT JOIN musician_name mn ON mn.musician_id = bm.musician_id
WHERE LOWER(bm.musician_status) = 'current'
GROUP BY bm.musician_id
ORDER BY albums_cnt DESC
LIMIT 1;
 
 
 