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

}