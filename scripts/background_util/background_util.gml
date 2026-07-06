function background_add(sprite, frame, scroll_x, scroll_y, spd_x=0, spd_y=0, off_x=0, off_y=0, vertical_loop = false)
{
	var oldId = bg_id;
	
	background_sprite[bg_id] = sprite;
	background_frame[bg_id] = frame;
	factor_x[bg_id] = scroll_x;
	factor_y[bg_id] = scroll_y;
	speed_x[bg_id] = spd_x;
	speed_y[bg_id] = spd_y;
	offset_x[bg_id] = off_x;
	offset_y[bg_id] = off_y;
	background_vertical[bg_id] = vertical_loop;
	line_scroll[bg_id] = false;
	trigger[bg_id] = false;
	visibility[bg_id] = true;
	bg_id++;
	
	return oldId;
}

function background_add_line(sprite, frame, scroll_x, scroll_y, spd_x, spd_y, off_x, off_y, gaps, steps, y_scale = 1)
{
	var oldId = bg_id;
	
	background_sprite[bg_id] = sprite;
	background_frame[bg_id] = frame;
	factor_x[bg_id] = scroll_x;
	factor_y[bg_id] = scroll_y;
	speed_x[bg_id] = spd_x;
	speed_y[bg_id] = spd_y;
	offset_x[bg_id] = off_x;
	offset_y[bg_id] = off_y;
	background_vertical[bg_id] = false;
	line_scroll[bg_id] = true;
	line_gap[bg_id] = gaps;
	line_steps[bg_id] = steps;
	bg_scale[bg_id] = y_scale;
	trigger[bg_id] = false;
	visibility[bg_id] = true;
	bg_id++;
	
	return oldId;
}

function background_draw_layer(background_layer)
{
	if(!visibility[background_layer]) 
		exit;
	
	//Draw the background
	if(!line_scroll[background_layer])
	{
		draw_sprite_tiled_new(background_sprite[background_layer], background_frame[background_layer], floor(pos_x[background_layer]), floor(pos_y[background_layer]), background_vertical[background_layer] ? 2 : 0);
	}
	else
	{
		//Set the linescroll shader
		shader_set(shd_line_scroll);
		
		//Get shader's uniforms
		var BGWidth = shader_get_uniform(shd_line_scroll, "Width");
		var BGTexel = shader_get_uniform(shd_line_scroll, "TexelWidth");
		var OffX = shader_get_uniform(shd_line_scroll, "OffsetX");
		var PosX = shader_get_uniform(shd_line_scroll, "Position");
		var HeightY = shader_get_uniform(shd_line_scroll, "LineGaps");
		var StepY = shader_get_uniform(shd_line_scroll, "YSteps");
		var ScaleY = shader_get_uniform(shd_line_scroll, "YScale");
		var ShdHeight = shader_get_uniform(shd_line_scroll, "Height");
		
		var repSize = (camera_get_view_width(view_camera[view_current]) / sprite_get_width(background_sprite[background_layer]));
		
		for (var i = -1; i < repSize; ++i) 
		{
		    var px = camera_get_view_x(view_camera[view_current]) + sprite_get_width(background_sprite[background_layer]) * i;
		
			//Set shader uniforms
			shader_set_uniform_f(BGWidth, sprite_get_width(background_sprite[background_layer]));
			shader_set_uniform_f(BGTexel, texture_get_texel_width(sprite_get_texture(background_sprite[background_layer], 0)));
			shader_set_uniform_f(OffX, pos_x[background_layer]);
			shader_set_uniform_f(PosX, px, pos_y[background_layer]);
			shader_set_uniform_f(StepY, line_steps[background_layer]/(1-factor_x[background_layer]));
			shader_set_uniform_f(HeightY, line_gap[background_layer]);
			shader_set_uniform_f(ScaleY, bg_scale[background_layer]); 
			shader_set_uniform_f(ShdHeight, sprite_get_height(background_sprite[background_layer])); 
			
			draw_sprite_ext(background_sprite[background_layer], background_frame[background_layer], px, floor(pos_y[background_layer]) , 1, bg_scale[background_layer], 0, c_white, 1);
		}
	}
	
	//Reset the shader
	shader_reset();
}

function background_position_layer(background_layer)
{
	//Act transition background offset adjustments
	if(trigger[background_layer])
	{
		//Horizontal offset
		var reposition_x =  ((camera_get_view_x(view_camera[view_current])*factor_x[background_layer]) + offset_x[background_layer])
		diff_x[background_layer] = reposition_x - camera_get_view_x(view_camera[view_current]);
		offset_x[background_layer] += offset_x[background_layer] - diff_x[background_layer]
			
		//Vertical offset
		var reposition_y =  ((camera_get_view_y(view_camera[view_current])*factor_y[background_layer]) + offset_y[background_layer])
		diff_y[background_layer] = reposition_y - camera_get_view_y(view_camera[view_current]);
		offset_y[background_layer] += offset_y[background_layer] - diff_y[background_layer]
			
		//Disable the trigger
		trigger[background_layer] = false;
	}
	
	//Different types of scrolling
	if(!line_scroll[background_layer])
	{
		//Normal scrolling
		pos_x[background_layer] = ((camera_get_view_x(view_camera[view_current])*factor_x[background_layer]) + offset_x[background_layer])
		pos_y[background_layer] = floor(camera_get_view_y(view_camera[view_current])*factor_y[background_layer] + offset_y[background_layer]);
		
		diff_x[background_layer] = pos_x[background_layer] - camera_get_view_x(view_camera[view_current]);
		diff_y[background_layer] = pos_y[background_layer] - camera_get_view_y(view_camera[view_current]);
	}
	else
	{
		//Normal scrolling
		pos_x[background_layer] = ((camera_get_view_x(view_camera[view_current])*(1-factor_x[background_layer])) - offset_x[background_layer]);
		pos_y[background_layer] = floor(camera_get_view_y(view_camera[view_current])*factor_y[background_layer] + offset_y[background_layer]);
		
		diff_x[background_layer] = ((camera_get_view_x(view_camera[view_current])*factor_x[background_layer]) + offset_x[background_layer]) - camera_get_view_x(view_camera[view_current])
		diff_y[background_layer] = (floor(camera_get_view_y(view_camera[view_current])*factor_y[background_layer]) + offset_y[background_layer]) - camera_get_view_y(view_camera[view_current])
	}
		
	//Auto scrolling
	if(global.process_objects)
	{
		offset_x[background_layer] += speed_x[background_layer];
		offset_y[background_layer] += speed_y[background_layer];
	}
}