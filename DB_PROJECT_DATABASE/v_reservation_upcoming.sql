 CREATE VIEW v_reservation_upcoming AS
 SELECT
   R.id AS reserva_id,
   C.[name] AS cliente,
   R.[date] AS fecha,
   R.total AS total
 FROM reservations AS R
 JOIN [user] AS U ON U.id = R.user_id
 JOIN client AS C ON C.id = U.client_id
 WHERE R.date >= CAST(GETDATE() AS DATE);
 GO