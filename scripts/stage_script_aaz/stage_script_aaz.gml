function raise_water_level(level, rise_speed = 2, water_obj = obj_water){
    water_obj.level_target = level;
	water_obj.rise_speed = rise_speed;
}