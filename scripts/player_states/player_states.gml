

function player_states(){	
	
	//Default flags:
	if(flag_override)
	{
		direction_allow = true;
		movement_allow = true;
		collision_allow = true;
		attacking = false;
		gravity_allow = true;
		hitbox_allow = true;
		speed_allow = true;
	}
	
	//State allowing flags:
	can_jump = false;
	can_roll = false;
	
	// Update the shiled animator here
	with(shield_obj)
	{
		// Update the animation system
		animator_update(animator);
	}
	
	// Run the shield system
	if(shield != -1)
	{
		if(shield < array_length(shield_list))
		{
			script_execute(shield_list[shield]);
		}
	}
	else
	{
		instance_destroy(shield_obj);	
		shield_state = 0;
	}
	
	// Create the shield graphic
	if(!instance_exists(obj_shield_graphic) && shield != SHIELD.NONE)
	{
		shield_obj = instance_create_depth(x, y, depth - 10, obj_shield_graphic);	
		shield_obj.parent = id;
	}
	
	script_execute(state);	
	player_state_conditions();
	
	//Tails object
	player_handle_tails();
}


function player_state_conditions()
{
	
	// Reset the idle and skid timer if the state isn't normal
	if(state != player_state_normal)
	{
		idle_timer = 0;
		skid_timer = 0;
	}
	
	// Reset the flag
	if(ground)
		insta_shield_used = false;
	
	//Reset the timer
	if(state != player_state_jump || state == player_state_dropdash || shield != SHIELD.NONE && shield != SHIELD.NORMAL && !invincible)
	{
		dropdash_timer = 0;
	}
	
	//Do the air roll
	if(press_action && !ground && global.use_airroll)
	{
		if(state == player_state_normal || state == player_state_spring)
		{
			state = player_state_jump;
			jump_flag = false;
			jump_anim_speed = floor(max(0, 4-abs(ground_speed)));
		}
	}
	
	//Trigger look down:
	if(state == player_state_normal || state == player_state_knuxfall)
	{
		if(ground && abs(ground_speed) < 1 && mode = 0 && hold_down)
		{
			state = player_state_lookdown;
			idle_timer = 0;
		}
	}
	
	
	//Stop if not specific state
	if(state != player_state_tailsfly)
	{
		audio_stop_sound(sfx_tailsfly);
		audio_stop_sound(sfx_tailstired);
	}
	
}