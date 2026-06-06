/// @description Dev menu
	room_speed = 60;
	
	if((keyboard_check_pressed(vk_escape) || gamepad_button_check_pressed(global.gamepad_slot, gp_select)) && !instance_exists(obj_devmenu) && !obj_shell.isOpen)
	{
		instance_create_depth(0, 0, -99999, obj_devmenu)
	}
	
	//Destroy just in case
	if(!global.dev_mode) 
	{
		instance_destroy();
	}
	
	//Go to level select
	if(keyboard_check_pressed(ord("M")) && !obj_shell.isOpen)
	{
		fade_to_room(rm_stage_select, 4);
		music_set_fade(FADE_OUT, 5);
	}
	
	//Toggle debug mode
	if(keyboard_check_pressed(vk_f5) && instance_exists(obj_shell)) obj_shell.isOpen = !obj_shell.isOpen;
	
	if(!obj_shell.isOpen)
	{
		if(keyboard_check_pressed(vk_tab) || Input.BumperLPress) debug = !debug;
		if(keyboard_check_pressed(ord("B")) && instance_exists(obj_hud)) obj_hud.render = !obj_hud.render;
		if(keyboard_check_pressed(ord("T"))) global.title_card = !global.title_card;
		if(keyboard_check_pressed(vk_f9)) show_collision = !show_collision;
		if(keyboard_check_pressed(vk_f8)) show_hitbox = !show_hitbox;
		if(keyboard_check_pressed(vk_f3)) show_fps = !show_fps;
		if(keyboard_check_pressed(ord("N"))) global.bgm_volume = (global.bgm_volume + 1) mod 2;
		if(keyboard_check_pressed(vk_f7)) show_player = !show_player;
		if(keyboard_check_pressed(vk_f2)) 
		{
			fade_to_room(room, 5);
			music_set_fade(FADE_OUT, 5);
		}
		if(keyboard_check_pressed(vk_f1)) game_restart();
		if(keyboard_check_pressed(vk_f10))
		{
			global.character = (global.character + 1) mod 3;
			with(obj_player)
			{
				player_animation_list();
				animator_reset(animator);
				
			}
		}
		
		if(keyboard_check(vk_f6)) room_speed = 5;
		if(keyboard_check(vk_backspace) || Input.BumperR) room_speed = 240;
	
		//Stop if player doesn't exist
		if(!instance_exists(obj_player)) exit;
	
		if(keyboard_check_pressed(ord("V")) && !instance_exists(obj_act_clear)){
			instance_create_layer(0, 0, "Utilities", obj_act_clear)
			obj_level.act_transition = false;
		}
		
		//Add rings
		if(keyboard_check(ord("1")))
		{
			global.rings++;
			play_sound(sfx_ring);
		}
		
		//Give the player extra life
		if(keyboard_check_pressed(ord("2")))
		{
			global.life++;
			SOUND_EXTRA_LIFE;
		}
		
		//Change shields
		if(keyboard_check_pressed(ord("3")))
		{
			obj_player.shield++;
			
			if(obj_player.shield >= array_length(obj_player.shield_list))
			{
				obj_player.shield = -1;
			}
		}
		
		//Give the player invincibility
		if(keyboard_check_pressed(ord("4")))
		{
			obj_player.invincible = true;
			obj_player.invincible_timer = 1200;
		}
		
		//Give the player speed shoes
		if(keyboard_check_pressed(ord("5")))
		{
			obj_player.speed_shoes_flag = true;
			obj_player.speed_shoes = 1200;
		}
		
		//Combine Rings
		if(keyboard_check_pressed(ord("6")))
		{
			obj_player.combinering = 1;
			play_sound(sfx_combinering);
		}
		
		//Hurt the player
		if(keyboard_check_pressed(ord("7")))
		{
			player_hurt(obj_player.x + obj_player.facing);
		}
		
		//Hurt the player
		if(keyboard_check_pressed(ord("8")))
		{
			obj_player.knockout_type = K_DIE;
		}
		
		//Toggle teleport
		if(keyboard_check_pressed(vk_space) && instance_exists(obj_debug_teleport))
		{
			var t = instance_find(obj_debug_teleport, teleport_id);
		
			obj_player.x = t.x;
			obj_player.y = t.y;
			obj_camera.camera_x = t.x;
			obj_camera.camera_y = t.y;
			
			obj_camera.target_x = obj_camera.camera_x;
			obj_camera.target_y = obj_camera.camera_y - 16;
			obj_camera.target_right = room_width;
			obj_camera.target_top = 0;
			obj_camera.target_bottom = room_height;
			obj_camera.limit_right = room_width;
			obj_camera.limit_top = 0;
			obj_camera.limit_bottom = room_height;
			
			teleport_id++;
			teleport_id %= instance_number(obj_debug_teleport);
		}
	}
	//Stop if player doesn't exist
	if(!instance_exists(obj_player)) exit;
		
	//Change player debug flag
	obj_player.debug = debug;
	
	//Disable not in debug mode
	if(!debug) exit;
	
	var c, cx, cy;
	c = view_camera[view_current];
	cx = camera_get_view_x(c);
	cy = camera_get_view_y(c);
	
	//Set up previous mouse x and y vars when getting into debug
	if (!variable_instance_exists(id, "prev_win_mouse_x"))
	{
	    prev_win_mouse_x = window_mouse_get_x();
	    prev_win_mouse_y = window_mouse_get_y();
	}
	
	//Check
	if (abs(window_mouse_get_x() - prev_win_mouse_x) > 0.5 || abs(window_mouse_get_y() - prev_win_mouse_y) > 0.5)
	{
	    debug_use_analog = false;
	}
	prev_win_mouse_x = window_mouse_get_x();
	prev_win_mouse_y = window_mouse_get_y();
	
	if (Input.axis_r_h != 0 || Input.axis_r_v != 0)
	{
	    debug_use_analog = true;
	}
	
	//Move cursor
	if (!debug_use_analog)
	{
	    cursor_x = mouse_x - cx;
	    cursor_y = mouse_y - cy;
	}
	else
	{
	    cursor_x += Input.axis_r_h * 2;
	    cursor_y += Input.axis_r_v * 2;
	    cursor_x = clamp(cursor_x, 0, WINDOW_WIDTH);
	    cursor_y = clamp(cursor_y, 0, WINDOW_HEIGHT);
	}
	
	//The scroll!
	if((mouse_wheel_up() && !debug_use_analog) || (Input.CPress && debug_use_analog)) object_select += 1;
	if((mouse_wheel_down() && !debug_use_analog)) object_select -= 1;
	
	//Repeat
	if(object_select < 0) object_select = array_length(object_list) - 1;
	if(object_select > array_length(object_list) - 1) object_select = 0;
	
	//Spawn the object
	if((mouse_check_button_pressed(mb_left) && !debug_use_analog) || (Input.APress && debug_use_analog))
	{
		instance_create_layer(cursor_x + cx, cursor_y + cy, "Objects", object_list[object_select]);
		if(object_select = 11)
		{
			obj_level.act_transition = false;	
		}
	}
	
	//Object loop
	for(var i = 0; i < array_length(object_list); i++)
	{
		var mouse_overlap = instance_position(cursor_x + cx, cursor_y + cy, object_list[i])

		if(mouse_overlap && (mouse_check_button_pressed(mb_right) && !debug_use_analog) || (Input.BPress && debug_use_analog))
		{
			instance_destroy(mouse_overlap);
		}
	}