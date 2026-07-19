function game_init_collision()
{
	// Initilize tile arrays
	global.tile_top = [[[]]];
	global.tile_bottom = [[[]]];
	global.tile_left = [[[]]];
	global.tile_right = [[[]]];
	
	// Get the old sprite mask
	var oldMask = mask_index;
		
	// For now
	var tilemap = [spr_tile_collision_new];
	
	for (var j = 0; j < array_length(tilemap); ++j) 
	{
		// For debugging purposes
		var oldTime = current_time;
	
		// Get the tile count
		var tileW = floor(sprite_get_width(tilemap[j]) / 16);
		var tileH = floor(sprite_get_height(tilemap[j]) / 16);
		var tileCount = tileW * tileH;
	
		mask_index = tilemap[j];
	
		for (var i = 0; i < tileCount; ++i) 
		{
			_game_calculate_height(j, i, tileW);
		}
	
		show_debug_message("Collision index {1} height map baking took: {0} ms", current_time - oldTime, j);
	}
	// Restore it
	mask_index = oldMask;
}

function _game_calculate_height(collision_index, tile_index, tile_width)
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
		
		global.tile_top[collision_index][tile_index][w] = pY;
		
		pY = 16;
		while(!position_meeting(x + tileX + w, y + tileY + pY - 1, self) && pY > 0)
		{
			pY--;
		}
		
		global.tile_bottom[collision_index][tile_index][w] = pY;
		
		var pX = 16;
		while(!position_meeting(x + tileX + 16 - pX, y + tileY + w, self) && pX > 0)
		{
			pX--;
		}
		
		global.tile_left[collision_index][tile_index][w] = pX;
		
		// Right side of the collision
		pX = 16;
		while(!position_meeting(x + tileX + pX - 1, y + tileY + w, self) && pX > 0)
		{
			pX--;
		}
		
		global.tile_right[collision_index][tile_index][w] = pX;
		
	}

}