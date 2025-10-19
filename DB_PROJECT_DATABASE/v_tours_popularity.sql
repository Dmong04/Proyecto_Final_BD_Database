CREATE VIEW v_tours_popularity AS
SELECT
  T.[type],
  COUNT(TD.id) AS veces_reservado,
  SUM(R.total) AS ingresos_generados
FROM tour_detail AS TD
JOIN tour AS T ON T.id = TD.tour_id
JOIN reservations AS R ON R.id = TD.reservation_id
GROUP BY T.[type];
GO