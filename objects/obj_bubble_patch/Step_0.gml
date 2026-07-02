
	if(--timer <= 0)
	{
		if(!bubble_flag)
		{
			bubble_flag = 1;
			bubble_type = irandom(0x10000) % 6;
			
			if(dud_count-- <= 0)
			{
				bubble_flag |= 2;
				dud_count = 0;			// temp
			}
		}
		
		// Set the base timer
		timer = 16 + irandom(32);
			
		var bubble = instance_create_depth(x + random_range(-8, 8), y - 2, depth - 1, obj_bubble);
			
		if(bubble_flag & 2 && (!irandom(4) || !bubble_type) && !(bubble_flag & 4))
		{
			bubble.type = 2;
			bubble_flag |= 4;
		}
		
		// Small spawn bubbles
		if(bubble_type-- <= 0)
		{
			bubble.type = irandom(1);
			bubble_flag = 0;
			timer += irandom(128) + 64;
		}
		
		// Correct the depth
		bubble.depth -= bubble.type;
	}