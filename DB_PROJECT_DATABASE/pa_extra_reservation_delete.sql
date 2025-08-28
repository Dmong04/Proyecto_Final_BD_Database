USE coco_tours_db
GO

create procedure pa_extra_details_reservation_delete(
    @extra_detail_id int
) as
begin
begin try
    set nocount on;

    declare @selected_extra_detail int;
    select @selected_extra_detail = id from extra_detail where id = @extra_detail_id;

    if @selected_extra_detail is null
    begin
        raiserror('El detalle extra no existe', 16, 1);
        return;
    end

    delete from extra_detail where id = @selected_extra_detail;
end try
begin catch
    declare @ErrorMessage nvarchar(4000) = error_message();
    raiserror(@ErrorMessage,16,1);
end catch
end
GO
