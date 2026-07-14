/// @description Script
	// Update the animator
	animator_update(animator);
	animation_play(animator, type);
	
	// Bounding box reasons
	sprite_index = animation_get_sprite(animator);
	
	//Movement
	y -= 0.53125;
	x = xstart + 4 * dsin(angle);
	
	//Add and modulate angle
	angle = (angle + 2.8125) mod 360;
	
	//Destroy outside of window or above water horizon
	if(!instance_on_screen() || bbox_top < obj_water.y) 
	{
		instance_destroy();
		exit;
	}
	
	// Get the player object
	var player = player_find(0);
	
	//Suck it!
	if(player_collide_object([-8, -8, 8, 8]) && !player.ground && player.shield != S_BUBBLE && animation_is_playing(animator, 2) && animation_has_finished(animator))
	{
		with(player)
		{
			air = 0;
			x_speed = 0;
			y_speed = 0;
			ground_speed = 0;
			state = player_state_normal;
			animation_play(animator, ANIM.BREATHE);
			sound_play(sfx_breathe);
		}
		
		instance_destroy();	
	}
	