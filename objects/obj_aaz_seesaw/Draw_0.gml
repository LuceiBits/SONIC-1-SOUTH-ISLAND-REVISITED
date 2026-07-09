	
	// Draw beads
	var px, py;
	for (var i = 1; i < 3; ++i) 
	{
		// left side
		px = x - 12 * i;
		py = (y + 73) + (left_platform_y - (y + 62)) * ((1 / 3) * i);
		draw_sprite(spr_seesaw_bead, 0, px, py);
		
		// right side
		px = x + 12 * i;
		py = (y + 73) + (right_platform_y - (y + 62)) * ((1 / 3) * i);
		draw_sprite(spr_seesaw_bead, 0, px, py);
	}

	// Draw the main pole
	draw_sprite_ext(sprite_index, 0, x, y, image_xscale, yscale, 0, c_white, 1.0);
	
	// Draw the platforms
	draw_sprite(spr_seesaw_launcher, 0, left_platform_x, floor(left_platform_y));
	draw_sprite(spr_seesaw_launcher, 0, right_platform_x, right_platform_y);
	
	// Draw the weight
	draw_sprite(spr_seesaw_weight, 0, weight_x, weight_y);
	
