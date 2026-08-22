/// @description Script
	//Update the animator
	animator_update(animator);
	
	var c = player_act_solid();
	var player = player_find(0);
	if instance_place(x,y,obj_badnik_arma)
	{
	player = instance_place(x,y,obj_badnik_arma)
	c = COLLISION.TOP
	}
		if instance_place(x,y,obj_spikeball)
	{
	player = instance_place(x,y,obj_spikeball)
	c = COLLISION.TOP
	}

	if player.object_index != obj_spikeball
	var m = detach_sides ? 0 : player.mode;
	else
	var m = 0
	
	if(c == COLLISION.TOP && sign(image_yscale) == 1)
	{
		animator.animation_finished = false;
		triggered = true;
		if player.object_index = obj_badnik_arma
		player.arma_state = ARMA_STATE.TUCKED
		
		switch(m)
		{
			case 0:
			player.ground = false;
			player.y_speed = -spring_power;
			if player.object_index = obj_spikeball
			break;
			player.state = player_state_spring;
			break;
			
			case 1:
			case 3:
			if player.object_index = obj_spikeball
			break;
			player.facing = player.x_dir;
			player.ground_speed = spring_power * player.x_dir;
			break;
		}
		
		sound_play(sfx_spring);
	}
	
	if(c == COLLISION.BOTTOM && sign(image_yscale) == -1)
	{
		animator.animation_finished = false;
		triggered = true;
		
		switch(m)
		{
			case 0:
			player.ground = false;
			player.y_speed = spring_power;
			if player.object_index = obj_spikeball
			break;
			player.state = player.force_roll ? player_state_roll : player_state_normal;
			break;
			
			case 1:
			case 3:
			if player.object_index = obj_spikeball
			break;
			player.facing = -player.x_dir;
			player.ground_speed = -spring_power * player.x_dir;
			break;
		}
		
		sound_play(sfx_spring);
	}
	
	//Stop the animation
	if(!triggered) 
	{
		animation_set_frame(animator, 0);
	}
	
	//Reset the trigger
	if(animation_has_finished(animator) && triggered) 
	{
		triggered = false;
	}