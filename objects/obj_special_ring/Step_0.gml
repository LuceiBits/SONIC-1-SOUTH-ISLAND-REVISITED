	animator_update(animator);
	
	var player = player_find(0);
	
	// Enter the ring
	if(player_collide_object() && !entered)
	{
		entered = true;
		
		with(player)
		{
			visible = false;
			flag_override = false;
			speed_allow = false;
			hitbox_allow = false;
			state = player_state_null;
			
		}
		
		visible = false;
		
		create_effect(x, y, spr_special_ring_effect, 0.3);
	}
	
	// Enter events
	if(entered)
	{
		enter_timer++;
		
		if(enter_timer == 60)
		{
			fade_to_room(rm_blue_spheres, 2, FADE_WHITE);
			music_set_fade(FADE_OUT, 2);
		}
	}