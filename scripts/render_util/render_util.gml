function draw_sprite_tiled_new(sprite, subimg, x, y, type = 0)
{
	var sprW = sprite_get_width(sprite);
	var sprH = sprite_get_height(sprite);
	
	var camX = camera_get_view_x(view_camera[view_current]);
	var camY = camera_get_view_y(view_camera[view_current]);
	var camW = camera_get_view_width(view_camera[view_current]);
	var camH = camera_get_view_height(view_camera[view_current]);
	
	var offsetX = x mod sprW;
	var offsetY = y mod sprH;
	
	var startTileX = floor((camX - offsetX) / sprW) - 1;
    var endTileX = ceil((camX + camW - offsetX) / sprW) + 1;
	var startTileY = floor((camY - offsetY) / sprH) - 1;
    var endTileY = ceil((camY + camH - offsetY) / sprH) + 1;
	
	switch(type)
	{
		default:
		case 0:
			for (var i = startTileX; i <= endTileX; i++)
		    {
				draw_sprite(sprite, subimg, offsetX + i * sprW, y);
		    }
		break;
		

		case 1:
			for (var i = startTileY; i <= endTileY; i++)
		    {
				draw_sprite(sprite, subimg, x, offsetY + i * sprH);
		    }
		break;
		
		case 2:
			for (var i = startTileX; i <= endTileX; i++)
		    {
				for (var j = startTileY; j <= endTileY; j++)
				{
					draw_sprite(sprite, subimg, offsetX + i * sprW, offsetY + j * sprH);
				}
		    }
		break;
	}
}

function draw_background_layer(background_layer)
{
	//Draw the background
	if(line_scroll[background_layer] = false)
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
		
		//Normal scrolling
		pos_x[background_layer] = ((camera_get_view_x(view_camera[view_current])*factor_x[background_layer]) + offset_x[background_layer])
		pos_y[background_layer] = floor(camera_get_view_y(view_camera[view_current])*factor_y[background_layer] + offset_y[background_layer]);
		
		diff_x[background_layer] = pos_x[background_layer] - camera_get_view_x(view_camera[view_current]);
		diff_y[background_layer] = pos_y[background_layer] - camera_get_view_y(view_camera[view_current]);

		//Auto scrolling
		if(global.process_objects)
		{
			offset_x[background_layer] += speed_x[background_layer];
			offset_y[background_layer] += speed_y[background_layer];
		}
		
		//Draw the background if the visibility flag is on
		if (visibility[background_layer] == true) 
		{
			draw_sprite_tiled_new(background_sprite[background_layer], background_frame[background_layer], floor(pos_x[background_layer]), floor(pos_y[background_layer]), background_vertical[background_layer] ? 2 : 0);
		}
	}
	else
	{
		//Act transition background offset adjustments
		if(trigger[background_layer])
		{
			//Horizontal offset
			var reposition_x = ((camera_get_view_x(view_camera[view_current])*(factor_x[background_layer])) + offset_x[background_layer]);
			diff_x[background_layer] = reposition_x - camera_get_view_x(view_camera[view_current]);
			offset_x[background_layer] += offset_x[background_layer] - diff_x[background_layer]
			
			//Vertical offset
			var reposition_y =  ((camera_get_view_y(view_camera[view_current])*factor_y[background_layer]) + offset_y[background_layer])
			diff_y[background_layer] = reposition_y - camera_get_view_y(view_camera[view_current]);
			offset_y[background_layer] += offset_y[background_layer] - diff_y[background_layer]
			
			//Disable the trigger
			trigger[background_layer] = false;
		}
		
		//Normal scrolling
		pos_x[background_layer] = ((camera_get_view_x(view_camera[view_current])*(1-factor_x[background_layer])) - offset_x[background_layer]);
		pos_y[background_layer] = floor(camera_get_view_y(view_camera[view_current])*factor_y[background_layer] + offset_y[background_layer]);
		
		diff_x[background_layer] = ((camera_get_view_x(view_camera[view_current])*factor_x[background_layer]) + offset_x[background_layer]) - camera_get_view_x(view_camera[view_current])
		diff_y[background_layer] = (floor(camera_get_view_y(view_camera[view_current])*factor_y[background_layer]) + offset_y[background_layer]) - camera_get_view_y(view_camera[view_current])


		//Auto scrolling
		offset_x[background_layer] += speed_x[background_layer];
		offset_y[background_layer] += speed_y[background_layer];
		
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
		
			//Draw the background if visibility flag is on
			if (visibility[background_layer] == true) 
			{
				draw_sprite_ext(background_sprite[background_layer], background_frame[background_layer], px, floor(pos_y[background_layer]) , 1, bg_scale[background_layer], 0, c_white, 1);
			}
		}
	}
	
	//Reset the shader
	shader_reset();
}

function draw_self_floor()
{
	//Only purpose of this is because of GameMaker's horrible sub - pixeling
	draw_sprite_ext(sprite_index, image_index, floor(x) , floor(y), image_xscale, image_yscale, image_angle, draw_get_color(), draw_get_alpha());
}

function draw_state_save()
{
    global.draw_state = {
        blendmode : gpu_get_blendmode(),
        blendmode_ext : gpu_get_blendmode_ext(),
        colourwriteenable : gpu_get_colourwriteenable(),
        cullmode : gpu_get_cullmode(),
        fog : gpu_get_fog(),
        ztestenable : gpu_get_ztestenable(),
        zfunc : gpu_get_zfunc(),
        zwriteenable : gpu_get_zwriteenable(),
        alphatestenable : gpu_get_alphatestenable(),
        alphatestref : gpu_get_alphatestref(),
        filter : gpu_get_texfilter(),
        wrap : gpu_get_texrepeat(),
        shader : shader_current(),
        matrix_world : matrix_get(matrix_world),
        matrix_view : matrix_get(matrix_view),
        matrix_projection : matrix_get(matrix_projection)
    };
}

function draw_state_restore()
{
    var _state = global.draw_state;
    
    gpu_set_blendmode(_state.blendmode);
    
    var blend_src = _state.blendmode_ext[0];
    var blend_dest = _state.blendmode_ext[1];
    gpu_set_blendmode_ext(blend_src, blend_dest);
    
    var colour_write = _state.colourwriteenable;
    gpu_set_colourwriteenable(colour_write[0], colour_write[1], colour_write[2], colour_write[3]);
    
    gpu_set_cullmode(_state.cullmode);
    
    var fog_data = _state.fog;
    gpu_set_fog(fog_data[0], fog_data[1], fog_data[2], fog_data[3]);
    
    gpu_set_ztestenable(_state.ztestenable);
    gpu_set_zfunc(_state.zfunc);
    gpu_set_zwriteenable(_state.zwriteenable);
    
    gpu_set_alphatestenable(_state.alphatestenable);
    gpu_set_alphatestref(_state.alphatestref);
    
    gpu_set_texfilter(_state.filter);
    gpu_set_texrepeat(_state.wrap);
    
    shader_set(_state.shader);
    
    matrix_set(matrix_world, _state.matrix_world);
    matrix_set(matrix_view, _state.matrix_view);
    matrix_set(matrix_projection, _state.matrix_projection);
}