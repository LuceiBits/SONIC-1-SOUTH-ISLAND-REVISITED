/// @description Draw debug

	//Camera variables
	var c, cx, cy;
	c = view_camera[view_current];
	cx = camera_get_view_x(c);
	cy = camera_get_view_y(c);
	
	//Draw hitboxes
	if(show_hitbox)
	{
		with(all)
		{
			if(object_index != obj_player && object_index != obj_effect && object_index != obj_dust_effect)	
			{
				if(object_index = par_solid) exit
				draw_set_color(c_blue);
				draw_set_alpha(0.5);
				draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, false);
				draw_set_alpha(1);
				draw_set_color(c_white);
			}
		}
	}
	
	//Create surface
	if(!surface_exists(surf)) surf = surface_create(global.window_width, global.window_height);
			
	if(show_player && !debug && instance_exists(obj_player))
	{
		//Set surface target
		surface_set_target(surf);
		draw_clear_alpha(c_black, 0);
		
		draw_set_font(global.font_small);
		
		//Reset surface target
		surface_reset_target();
		
		//Draw surface
		draw_surface(surf, cx, cy)	
		
		//Draw hitbox
		draw_set_color(c_red);
		draw_set_alpha(0.7);
		draw_rectangle(floor(obj_player.x)-obj_player.wall_w - obj_player.hitbox_left_offset, floor(obj_player.y)-obj_player.hitbox_h - obj_player.hitbox_top_offset, floor(obj_player.x)+obj_player.wall_w + obj_player.hitbox_right_offset, floor(obj_player.y)+obj_player.hitbox_h + obj_player.hitbox_bottom_offset, false);
		draw_set_alpha(1);
		draw_set_color(c_white);
		
		//Draw main sensors
		with(obj_player)
		{
			draw_set_color(#ff38ff);
			draw_col_line_wall(-wall_h, -wall_w-1)
			draw_set_color(#ff5454);
			draw_col_line_wall(-wall_h, wall_w)
			draw_set_color(#38ffa2);
			draw_col_line(-hitbox_w, hitbox_h);
			draw_set_color(#00f000);
			draw_col_line(hitbox_w, hitbox_h);
			draw_set_color(c_white);
			draw_col_line(0, hitbox_h);
			draw_set_color(#00aeef);
			draw_col_line(-hitbox_w, -hitbox_h-1);
			draw_set_color(#fff238);
			draw_col_line(hitbox_w, -hitbox_h-1);
			draw_set_color(c_white);
			
			draw_sprite(spr_point, 0, floor(x), floor(y));
			
			if(shield = S_ELECTRIC) draw_circle(floor(x), floor(y), 64, true);
		}
	}
	
	if(show_fps)
	{
		//Set surface target
		surface_set_target(surf);
		draw_clear_alpha(c_black, 0);
		
		//Draw text in rectangle
		draw_set_font(global.font_small);
		draw_set_halign(fa_left);
		draw_text(0, global.window_height-8, "FPS: " + string(fps) + " " + "TRUE FPS:" +string(store_truefps));
		draw_text(0, global.window_height-16, "INSTANCES: " + string(instance_count));
		
		//Reset surface target
		surface_reset_target();
		
		//Draw surface
		draw_surface(surf, cx, cy)	
	}
	//Disable not in debug mode
	if(!debug || !instance_exists(obj_player)) exit;
	
	draw_set_alpha(0.75);
	var sprite = object_get_sprite(object_list[object_select]);
	draw_sprite(sprite, 0, cursor_x + cx, cursor_y + cy);
	draw_set_alpha(1);
	
	//Set surface target
	surface_set_target(surf);
	draw_clear_alpha(c_black, 0);
	
	//Draw text in rectangle
	draw_set_font(global.font_small);
	draw_set_halign(fa_left);
	draw_text(0, 0, string_upper(window_get_caption()) +" "+ string(GM_version));
	draw_text(0, 8, "BUILD DATE: " + date_date_string(GM_build_date));
	draw_text(0, 16, "BUILD TIME: " + date_time_string(GM_build_date));
	
	//Draw info
	draw_set_halign(fa_right);
	draw_text(global.window_width, 0,"PLAYER: " + string(floor(obj_player.x)) + " " + string(floor(obj_player.y)));
	draw_text(global.window_width, 8,"CAMERA: " + string(floor(obj_camera.camera_x)) + " " + string(floor(obj_camera.camera_y)));
	draw_text(global.window_width, 16,"CANVAS: " + string(room_width) + " " + string(room_height));
	draw_text(global.window_width, 24,"LX: " + string(Input.axis_l_h));
	draw_text(global.window_width, 32,"LY: " + string(Input.axis_l_v));
	draw_text(global.window_width, 40,"RX: " + string(Input.axis_r_h));
	draw_text(global.window_width, 48,"RY: " + string(Input.axis_r_v));
	
	surface_reset_target()
	
	draw_set_halign(fa_center);
	draw_text(cursor_x + cx, cursor_y - 32 + cy, string_upper(object_get_name(object_list[object_select])));
	
	//Draw surface
	draw_surface(surf, cx, cy)	