/// @self									
/// @description						Function used for drawing tiled sprite (Improved over gamemaker's default one)
/// @param {Asset.GMSprite} sprite		The sprite that will be drawn
/// @param {Real} subimg				The frame of the sprite
/// @param {Real} x						Horizontal position of the sprite
/// @param {Real} y						Vertical position of the sprite
/// @param {Real} [type]				The looping direction of the sprite
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

/// @self									
/// @description						Function used for drawing the object with positions being floored
function draw_self_floor()
{
	//Only purpose of this is because of GameMaker's horrible sub - pixeling
	draw_sprite_ext(sprite_index, image_index, floor(x) , floor(y), image_xscale, image_yscale, image_angle, draw_get_color(), draw_get_alpha());
}

/// @self									
/// @description						Function that pushes the current rendering state to the rendering stack
function draw_state_push()
{
	
	global.draw_state_holder = 
	{
		col : draw_get_colour(),
		alpha : draw_get_alpha(),
		halign : draw_get_halign(),
		valign : draw_get_valign(),
		font : draw_get_font(),
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
        mw : matrix_get(matrix_world),
        mv : matrix_get(matrix_view),
        mp : matrix_get(matrix_projection)
    };
	
	ds_stack_push(global.draw_state, global.draw_state_holder);
}

/// @self									
/// @description						Function that restores the rendering state that was previously pushed to the stack
function draw_state_pop()
{
    var _state = ds_stack_pop(global.draw_state);
    
	draw_set_color(_state.col);
	draw_set_alpha(_state.alpha);
	
	draw_set_halign(_state.valign);
	draw_set_valign(_state.halign);
	draw_set_font(_state.font);
	
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
    
    matrix_set(matrix_world, _state.mw);
    matrix_set(matrix_view, _state.mv);
    matrix_set(matrix_projection, _state.mp);
}

/// @self									
/// @description						Function that makes everything drawn follow the viewport's camera
function draw_set_follow_camera()
{
	// Store because of the matrices
	draw_state_push();
	
	// Make the view matrix follow the camera
	matrix_set(matrix_view, matrix_build(-CAMERA_VIEW_W / 2, -CAMERA_VIEW_H / 2, 16000, 0, 0, 0, 1, 1, 1));
}

/// @self									
/// @description						Function that stops following the camera during the rendering
function draw_set_follow_end()
{
	// Restore the old stuff, pretty much a wrapper
	draw_state_pop();
}