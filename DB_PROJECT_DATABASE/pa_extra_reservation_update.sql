USE coco_tours_db
GO

create procedure pa_extra_details_reservation_update(
    @extra_detail_id int,
    @person_count int,
    @extra_id int
) as
begin
begin try
    set nocount on;

    declare @selected_extra_detail int, @reservation_id int;
    select @selected_extra_detail = id, @reservation_id = reservation_id 
    from extra_detail where id = @extra_detail_id;

    if @selected_extra_detail is null
    begin
        raiserror('El detalle extra no existe', 16, 1);
        return;
    end


    declare @selected_extra int;
    select @selected_extra = id from extra where id = @extra_id;

    if @selected_extra is null
    begin
        raiserror('El extra no existe', 16, 1);
        return;
    end


    declare @limit_participants int;
    select @limit_participants = isnull(count(p.id),0)
    from reservations as r
    inner join tour_detail as td on r.id = td.reservation_id
    inner join passengers as p on td.id = p.tour_detail_id
    where td.reservation_id = @reservation_id;

    if @person_count > @limit_participants
    begin
        raiserror('El número de participantes del extra no puede superar el número de pasajeros', 16, 1);
        return;
    end

    update extra_detail
    set person_count = @person_count,
        extra_id = @selected_extra
    where id = @selected_extra_detail;

end try
begin catch
    declare @ErrorMessage nvarchar(4000) = error_message();
    raiserror(@ErrorMessage,16,1);
end catch
end
GO