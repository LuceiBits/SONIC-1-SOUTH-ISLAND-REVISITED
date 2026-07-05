	for(var w = 0; w < array_length(dust); w++)
	{
		for(var h = 0; h < array_length(dust[w]); h++)
		{
			//Get dust info
			var d = dust[w][h];
			
			//If the info array is empty, continue to the next loop
			if(array_length(d) == 0) continue;
			
			//Draw dust speck
			draw_sprite_part(sprite_index, frame, w, h, 1, 1, x + d[DUST.X] - sprite_get_xoffset(sprite_index), y + d[DUST.Y] - sprite_get_yoffset(sprite_index))
		}
	}