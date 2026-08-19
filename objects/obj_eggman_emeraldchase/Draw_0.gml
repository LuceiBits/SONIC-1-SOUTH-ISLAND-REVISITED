if !instance_on_screen()
{
var y_draw = clamp(y,obj_camera.camera_y - (WINDOW_HEIGHT - 16)/2,obj_camera.camera_y + (WINDOW_HEIGHT - 16)/2)
var x_draw = clamp(x,obj_camera.camera_x - (WINDOW_WIDTH - 16)/2,obj_camera.camera_x + (WINDOW_WIDTH - 16)/2)
draw_sprite(spr_monitor_icon_eggman,image_index,x_draw,y_draw)
}
else
{
if instance_flash(3) && invincible_frames > 0
exit;
draw_self()
}
