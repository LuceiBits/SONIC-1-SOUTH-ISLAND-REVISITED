function raise_water_level(level, rise_speed = 2, water_obj = obj_water){
    with (water_obj)
    {
        //IF it's a pool, turn the y coordinate "level" parameter into a y scale one
        if (object_index = obj_water_pool)
        {
            level_target = max(0, ((y - level + 16)/spr_height));
        }
        else
        {
            level_target = level;
        }
    	water_obj.rise_speed = rise_speed;
    }
}