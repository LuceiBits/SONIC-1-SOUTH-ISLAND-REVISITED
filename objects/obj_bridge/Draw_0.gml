/// @description Draw logs
	for (var i = 0; i < bridge_size; ++i) 
	{
		var pushOffset = ((ystart + push_offset) - ystart) * ((1 / bridge_size) * i);
		draw_sprite(sprite_index, log_frames[i], x + 16 * i, floor(ystart + log_offset[i] + pushOffset));
	}