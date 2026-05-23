function game_init_collision()
{
	// Initilize tile arrays
	global.tile_top = [[]];
	global.tile_bottom = [[]];
	global.tile_left = [[]];
	global.tile_right = [[]];
	
	// Get the old sprite mask
	var oldMask = mask_index;
	
	// For debugging purposes
	var oldTime = current_time;
	
	// For now
	var tilemap = spr_tile_collision_new;
	
	// Get the tile count
	var tileW = floor(sprite_get_width(tilemap) / 16);
	var tileH = floor(sprite_get_height(tilemap) / 16);
	var tileCount = tileW * tileH;
	
	sprite_collision_mask(tilemap, false, bboxmode_fullimage, 0, 0, 16, 16, bboxkind_precise, 0);
	
	mask_index = tilemap;
	
	for (var i = 0; i < tileCount; ++i) 
	{
		
			
			
			_game_calculate_height(i, tileW);
		
	}
	
	show_debug_message("Baking took: " + string(current_time - oldTime) + "ms");
	
	// Restore it
	mask_index = oldMask;
}

function _game_calculate_height(tile_index, tile_width)
{
	var tileX = 16 * (tile_index % tile_width);
	var tileY = 16 * floor(tile_index / tile_width);
	
	for(var w = 0; w < 16; w++)
	{
		var pY = 16;
		while(!position_meeting(x + tileX + w, y + tileY + 16 - pY, self) && pY > 0)
		{
			pY--;
		}
		
		global.tile_top[tile_index][w] = pY;
		
		pY = 16;
		while(!position_meeting(x + tileX + w, y + tileY + pY - 1, self) && pY > 0)
		{
			pY--;
		}
		
		global.tile_bottom[tile_index][w] = pY;
		
		var pX = 16;
		while(!position_meeting(x + tileX + 16 - pX, y + tileY + w, self) && pX > 0)
		{
			pX--;
		}
		
		global.tile_left[tile_index][w] = pX;
		
		// Right side of the collision
		pX = 16;
		while(!position_meeting(x + tileX + pX - 1, y + tileY + w, self) && pX > 0)
		{
			pX--;
		}
		
		global.tile_right[tile_index][w] = pX;
		
	}
	
	/*show_debug_message(string(global.tile_top[tile_index][0]) + string(global.tile_top[tile_index][1]) + string(global.tile_top[tile_index][2]) + string(global.tile_top[tile_index][3]) + 
	string(global.tile_top[tile_index][4]) + string(global.tile_top[tile_index][5]) + string(global.tile_top[tile_index][6]) + string(global.tile_top[tile_index][7]) + 
	string(global.tile_top[tile_index][8]) + string(global.tile_top[tile_index][9]) + string(global.tile_top[tile_index][10]) + string(global.tile_top[tile_index][11]) + 
	string(global.tile_top[tile_index][12]) + string(global.tile_top[tile_index][13]) + string(global.tile_top[tile_index][14]) + string(global.tile_top[tile_index][15])
	)*/

/*	show_debug_message(string(global.tile_bottom[tile_index][0]) + string(global.tile_bottom[tile_index][1]) + string(global.tile_bottom[tile_index][2]) + string(global.tile_bottom[tile_index][3]) + 
	string(global.tile_bottom[tile_index][4]) + string(global.tile_bottom[tile_index][5]) + string(global.tile_bottom[tile_index][6]) + string(global.tile_bottom[tile_index][7]) + 
	string(global.tile_bottom[tile_index][8]) + string(global.tile_bottom[tile_index][9]) + string(global.tile_bottom[tile_index][10]) + string(global.tile_bottom[tile_index][11]) + 
	string(global.tile_bottom[tile_index][12]) + string(global.tile_bottom[tile_index][13]) + string(global.tile_bottom[tile_index][14]) + string(global.tile_bottom[tile_index][15])
	)*/

	/*show_debug_message(string(global.tile_left[tile_index][0]) + string(global.tile_left[tile_index][1]) + string(global.tile_left[tile_index][2]) + string(global.tile_left[tile_index][3]) + 
	string(global.tile_left[tile_index][4]) + string(global.tile_left[tile_index][5]) + string(global.tile_left[tile_index][6]) + string(global.tile_left[tile_index][7]) + 
	string(global.tile_left[tile_index][8]) + string(global.tile_left[tile_index][9]) + string(global.tile_left[tile_index][10]) + string(global.tile_left[tile_index][11]) + 
	string(global.tile_left[tile_index][12]) + string(global.tile_left[tile_index][13]) + string(global.tile_left[tile_index][14]) + string(global.tile_left[tile_index][15])
	)*/
	
	show_debug_message(string(global.tile_right[tile_index][0]) + string(global.tile_right[tile_index][1]) + string(global.tile_right[tile_index][2]) + string(global.tile_right[tile_index][3]) + 
	string(global.tile_right[tile_index][4]) + string(global.tile_right[tile_index][5]) + string(global.tile_right[tile_index][6]) + string(global.tile_right[tile_index][7]) + 
	string(global.tile_right[tile_index][8]) + string(global.tile_right[tile_index][9]) + string(global.tile_right[tile_index][10]) + string(global.tile_right[tile_index][11]) + 
	string(global.tile_right[tile_index][12]) + string(global.tile_right[tile_index][13]) + string(global.tile_right[tile_index][14]) + string(global.tile_right[tile_index][15])
	)

}