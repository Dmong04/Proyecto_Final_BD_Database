CREATE VIEW v_month_income AS
SELECT
  YEAR(R.date) AS anio,
  MONTH(R.date) AS mes,
  SUM(R.total) AS ingresos_totales,
  COUNT(R.id) AS cantidad_reservas
FROM reservations as R
GROUP BY YEAR(R.date), MONTH(R.date)
GO