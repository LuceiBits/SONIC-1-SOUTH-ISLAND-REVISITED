function player_water()
{
	// Reset the water run flag
	water_run = false;
	
	//Stop executing if theres no water
	if(!instance_exists(obj_water) || !collision_allow) 
		exit;
	
	// Constants 
	var waterY = obj_water.y;
	var waterRange = 8;
	var waterSpd = 4;
	
	// Is player's bottom side in the water's range?
	if(y + hitbox_h > waterY - waterRange && y + hitbox_h < waterY + waterRange && ground
	&& abs(ground_speed) > waterSpd && y_speed >= -0.1)
	{
		// Attach player to the water horizon
		if(!on_terrain)
		{
			y = waterY - hitbox_h - 1;	
			ground_angle = 0;
			
			//Player effect
			if(FRAME_TIMER mod 4 == 0 && global.water_running_effect == 1)
			{
				//Create effects
				var splash = instance_create_depth(obj_player.x, obj_water.y, obj_player.depth - 1, obj_water_splash);
				splash.par = obj_water; //add pool support later
				sound_play(sfx_water_splash);	
			}
		}
		
		// Flag player to be on water
		water_run = true;
		
		// Play the water run sound
		if(global.water_running_effect == 0 && !audio_is_playing(sfx_water_run))
			sound_play(sfx_water_run, true);
	}
	
	// Stop the water run sound
	if(!water_run || on_terrain)
		audio_stop_sound(sfx_water_run);
	
	
	//Entering water
	if(y >= obj_water.y)
	{
		//Player hitting the water
		if(!underwater)
		{
			//Slow down the player
			x_speed *= 0.5;
			y_speed *= 0.25;
			
			//Create effects
			var splash = instance_create_depth(obj_player.x, obj_water.y, obj_player.depth - 1, obj_water_splash);
			splash.par = obj_water; //add pool support later
			
			//Play sound
			sound_play(sfx_water_splash);
		}
		
		//Trigger the flag
		underwater = true;
	}
	
	//Exiting water
	if(y < obj_water.y)
	{
		//Player hitting the water
		if(underwater)
		{
			//Speed up the player
			y_speed *= 1.25;
			
			//Create effects
			var splash = instance_create_depth(obj_player.x, obj_water.y, obj_water.depth + 1, obj_water_splash);
			splash.par = obj_water; //add pool support later
			
			//Play sound
			sound_play(sfx_water_splash);
		}
		
		//Trigger the flag
		underwater = false;
	}
	
	//Aquaphobia
	if(underwater)
	{
		if(shield == SHIELD.ELECTRIC || shield == SHIELD.FIRE)
		{
			shield = SHIELD.NONE;
			if(shield == SHIELD.ELECTRIC)
			{
				sound_play(sfx_electric_shield_lose);
				obj_water.flash_hold_timer = 4;
			}
		}
		
		if (shield != SHIELD.BUBBLE) 
		{
			//bubbles
			if (bubble_delay > 0 && (air % bubble_delay == 0))
			{
				bubble_delay = 0
				var bubble = instance_create_depth(x + 6 * facing, y, depth - 1, obj_bubble);
				bubble.type = 0;	
				bubble.angle = facing == -1 ? 180 : 0;
			}
		
			if(air % 60 == 0)
			{
				var rand = irandom(1);

				if (rand == 0)
					bubble_delay = irandom_range(6,16) * 2;
				
				if (air < 20*60) 
				{
					var bubble = instance_create_depth(x+6*facing, y-4, depth-1, obj_bubble);
					bubble.type = 0;	
					bubble.angle = facing == -1 ? 180 : 0;
				}
			}
		
			//Add air timer
			air++;
		}
		else
		{
			air = 0;
		}
			
		//Uh oh drowning music
		if(!audio_is_playing(j_drowning) && air == 20 * 60)
			audio_play_sound(j_drowning, 0, false, global.bgm_volume);
		
	}
	else
	{
		air = 0;
	}
	
	switch(air)
	{
		// Bubble warning sounds
		case 6 * 60:
		case 12 * 60:
		case 18 * 60:
			sound_play(sfx_air_warning);
		break;
		
		// Play the drowning theme
		case 20 * 60:
			if(!audio_is_playing(j_drowning))
				audio_play_sound(j_drowning, 0, false, global.bgm_volume);
		
		// Begin the count down
		case 22 * 60:
		case 24 * 60:
		case 26 * 60:
		case 28 * 60:
		case 30 * 60:
			var drown_bubble = instance_create_depth(x + 6 * facing, y - 4, depth - 10, obj_drown_bubble);
			drown_bubble.type = bubble_number;
			drown_bubble.angle = facing == -1 ? 180 : 0;
			bubble_number--;
			
		break;
		// The end, drown the player
		case 32 * 60:
			sound_play(sfx_drown);
			camera_set_mode(CAM_NULL);
			state = player_state_drown;
			x_speed = 0;
			y_speed = 0;
		break;
	}
	
	// Reset if there's air
	if(air < 20 * 60) 
	{
		bubble_number = 5;
		audio_stop_sound(j_drowning);
	}
}