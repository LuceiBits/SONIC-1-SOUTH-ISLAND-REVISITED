	draw_sprite(spr_title_background, 0, CAMERA_VIEW_W / 2, CAMERA_VIEW_H / 2);
	
	var animScale = scale_test;
	
	if(scale_test < 0)
		animScale = scale_test + 1;
	
	gpu_set_blendmode(bm_add);
	draw_sprite(spr_title_floor, animScale * 32, CAMERA_VIEW_W / 2, CAMERA_VIEW_H);
	gpu_set_blendmode(bm_normal);
	
	draw_state_push();
	
	gpu_set_depth(0);
	
	var z_position = 15791.5;
	show_debug_message(z_position)
	
	//matrix_set(matrix_projection, matrix_build_projection_perspective_fov(-60, -426 / 240, 1.0, 32000.0))
	//matrix_set(matrix_world, matrix_build(CAMERA_VIEW_W / 2, (CAMERA_VIEW_H / 2) + 0, -z_position - (200 * (scale_test - 1)), 0, 0, 0, 1, 1, 1));
	
	var s = math_pinhole_scale((CAMERA_VIEW_W / 2) - 5, (CAMERA_VIEW_H / 2) + (44 + 12), -scale_test);
	draw_sprite_ext(spr_title_sonic, 0, s[0], s[1], s[2], s[2], 0, c_white, 1);
	
	s = math_pinhole_scale(CAMERA_VIEW_W / 2, (CAMERA_VIEW_H / 2) + (-44), -scale_test * 1.1);
	
	effect_set_palette(spr_title_logo_palette, FRAME_TIMER / 4);
	draw_sprite_ext(spr_title_logo, 0, s[0], s[1], s[2], s[2], 0, c_white, 1);
	shader_reset();
	
	s = math_pinhole_scale(CAMERA_VIEW_W / 2, (CAMERA_VIEW_H / 2) + (-44), -scale_test * 1.3);
	draw_sprite_ext(spr_title_logo, 1, s[0], s[1], s[2], s[2], 0, c_white, 1);
	
	draw_state_pop();