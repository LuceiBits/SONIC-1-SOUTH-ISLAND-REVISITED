	exit; // TEMP DELETE WHEN DOING MENU STUFF
	
	draw_sprite(spr_title_background, 0, CAMERA_VIEW_W / 2, CAMERA_VIEW_H / 2);
	
	var animScale = scale_test;
	
	gpu_set_blendmode(bm_add);
	draw_sprite(spr_title_floor, animScale * 33, CAMERA_VIEW_W / 2, CAMERA_VIEW_H);
	gpu_set_blendmode(bm_normal);
	
	draw_state_push();
	
	gpu_set_depth(0);
	
	var s;
	
	// Draw shadows
	s = math_pinhole_scale((CAMERA_VIEW_W / 2) + 52, (CAMERA_VIEW_H / 2) + 94, -scale_test);
	draw_sprite_ext(spr_title_shadow, 0, s[0], s[1], s[2], s[2], 0, c_white, 0.5);
	
	s = math_pinhole_scale((CAMERA_VIEW_W / 2) - 52, (CAMERA_VIEW_H / 2) + 94, -scale_test);
	draw_sprite_ext(spr_title_shadow, 0, s[0], s[1], s[2], s[2], 0, c_white, 0.5);
	
	s = math_pinhole_scale((CAMERA_VIEW_W / 2), (CAMERA_VIEW_H / 2) + 103, -scale_test * 1.2);
	draw_sprite_ext(spr_title_shadow, 0, s[0], s[1], s[2], s[2], 0, c_white, 0.5);
	
	// Draw tails
	s = math_pinhole_scale((CAMERA_VIEW_W / 2) + 45, (CAMERA_VIEW_H / 2) + 67, -scale_test);
	draw_sprite_ext(spr_title_tails_tail, FRAME_TIMER / 8, s[0], s[1], s[2], s[2], 0, c_white, 1);
	
	s = math_pinhole_scale((CAMERA_VIEW_W / 2) + 55, (CAMERA_VIEW_H / 2) + 59, -scale_test);
	draw_sprite_ext(spr_title_tails, 0, s[0], s[1], s[2], s[2], 0, c_white, 1);
	draw_animator(tails_face, s[0], s[1], s[2], s[2], 0, c_white, 1);
	
	var knuxMulti = 12;
	
	// Draw knuckles
	var offX = -1 * dsin(FRAME_TIMER * knuxMulti);
	var offY = 1 * dcos(FRAME_TIMER * knuxMulti);
	
	s = math_pinhole_scale((CAMERA_VIEW_W / 2) - 51 - 14 + offX, (CAMERA_VIEW_H / 2) + (44 + 25 - 17) + offY, -scale_test);
	draw_sprite_ext(spr_title_knuckles_arm, 1, s[0], s[1], s[2], s[2], 0, c_white, 1);
	
	s = math_pinhole_scale((CAMERA_VIEW_W / 2) - 51, (CAMERA_VIEW_H / 2) + (44 + 25), -scale_test);
	draw_sprite_ext(spr_title_knuckles, 0, s[0], s[1], s[2], s[2], 0, c_white, 1);
		
	offY = -1 * dcos(FRAME_TIMER * knuxMulti);
	s = math_pinhole_scale((CAMERA_VIEW_W / 2) - 51 - 2, (CAMERA_VIEW_H / 2) + (44 + 25 - 38) + offY, -scale_test);
	draw_animator(knux_face, s[0], s[1], s[2], s[2], 0, c_white, 1);
	
	offX = 1 * dsin(FRAME_TIMER * knuxMulti);
	offY = -1 * dcos(FRAME_TIMER * knuxMulti);
	s = math_pinhole_scale((CAMERA_VIEW_W / 2) - 51 + 9 + offX, (CAMERA_VIEW_H / 2) + (44 + 25 - 16) + offY, -scale_test);
	draw_sprite_ext(spr_title_knuckles_arm, 0, s[0], s[1], s[2], s[2], 0, c_white, 1);
	
	// Draw sonic
	var sonicFrame = FRAME_TIMER / 6;
	var sonicFaceOff = [0, 1, 2, 1]
	s = math_pinhole_scale((CAMERA_VIEW_W / 2) - 3, (CAMERA_VIEW_H / 2) + (44 + 17), -scale_test * 1.2);
	draw_sprite_ext(spr_title_sonic, sonicFrame, s[0], s[1], s[2], s[2], 0, c_white, 1);
	
	// Draw sonic's face
	s = math_pinhole_scale((CAMERA_VIEW_W / 2) - 5, (CAMERA_VIEW_H / 2) + (44 + 12) + sonicFaceOff[sonicFrame % 4], -scale_test * 1.2);
	draw_animator(sonic_face, s[0], s[1], s[2], s[2], 0, c_white, 1);
	
	s = math_pinhole_scale(CAMERA_VIEW_W / 2, (CAMERA_VIEW_H / 2) + (-44), -scale_test * 0.9);
	
	effect_set_palette(spr_title_logo_palette, FRAME_TIMER / 4);
	draw_sprite_ext(spr_title_logo, 0, s[0], s[1], s[2], s[2], 0, c_white, 1);
	shader_reset();
	
	s = math_pinhole_scale(CAMERA_VIEW_W / 2, (CAMERA_VIEW_H / 2) + (-44), -scale_test * 1.4);
	draw_sprite_ext(spr_title_logo, 1, s[0], s[1], s[2], s[2], 0, c_white, 1);
	
	if((instance_flash(16) && !is_exiting || instance_flash(4) && is_exiting) && scale_test == 0)
	{
		s = math_pinhole_scale(CAMERA_VIEW_W / 2, (CAMERA_VIEW_H / 2) - 9, -scale_test * 1.5);
		draw_sprite_ext(spr_title_press_start, 1, s[0], s[1], s[2] * press_start_scale, s[2] * press_start_scale, 0, c_white, 1);
	}
	
	draw_state_pop();