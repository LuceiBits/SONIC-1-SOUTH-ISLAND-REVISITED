if place_meeting(x,y,obj_player) && activated = false
{
activated = true
change_water_level(y + 32,rise_speed)
image_index = 1
sound_play(sfx_opendoor);
}