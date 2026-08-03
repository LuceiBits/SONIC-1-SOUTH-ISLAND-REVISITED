/// @description Values
	//Object values:
object_list = [
obj_ring, 
obj_monitor, 

obj_badnik_fish,
obj_badnik_newton_green,
obj_badnik_newton_purple,
obj_badnik_ribbot,
obj_badnik_test,
obj_badnik_wasp,
obj_badnik_wheeltank,

obj_spring_vertical, 
obj_spring_horizontal, 
obj_spring_diagonal, 

obj_spikes_vertical, 
obj_spikes_horizontal, 

obj_checkpoint, 
obj_battery_ring, 

obj_solid_object, 

obj_signpost, 

obj_capsule, 
obj_animal, 

obj_player
];
object_select = 0;
debug = false;
show_collision = false;
show_hitbox = false;
show_player = false;
show_fps = false;
show_culling = false;
	
shell_open = false;
store_truefps = fps_real;
alarm[0] = 10;
caption = window_get_caption();
teleport_id = 0;
	
cursor_x = WINDOW_WIDTH / 2;
cursor_y = WINDOW_HEIGHT / 2;
debug_use_analog = true;
	
depth = -1000;