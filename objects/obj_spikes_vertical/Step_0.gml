/// @description Hurt player
	
	//Get the center of the hitbox
	var center_x = floor((obj_player.x + 16)/32) * 32;
	var col = player_act_solid();
	
	if place_meeting(x,y,obj_insta_shield) // Lucei aura spike parry
		{
			with obj_player
			{
			//jump_flag = true;
			ground = false;
			if other.image_yscale = 1
			y_speed = -8
			if other.image_yscale = -1
			y_speed = 8
			state = player_state_spring
			dropdash_timer = 0;
			idle_timer = 0;
			ground_angle = 0;
			player_mode(COLLISION_MODE.FLOOR);
			sound_play(sfx_electric_shield_jump);
			}
	
			parryTimer = 10
			
				for (var i = 0; i < 4; ++i) 
		    instance_create_particle(x, y, spr_electric_sparks, 1, depth + 1, 2 * dsin(45 + (90 * i)), 2 * dcos(45 + (90 * i)))
		
			instance_destroy(obj_insta_shield)
			
			exit;
		//y_speed = -10
		//obj_player.y_speed = -abs(obj_player.y_speed);
		}
	
	//Hurt the player
	if(col == (sign(image_yscale) == 1 ? COLLISION.TOP : COLLISION.BOTTOM)) && parryTimer = 0
	{
		


		
		var player = player_find(0)
		if(player.invincible_timer == 0 && player.insta_shield_invincible == 0)
			sound_play(sfx_spike);
		

		player_hurt(center_x);
		
		
	}
	
	if parryTimer > 0
	parryTimer -= 1
	
	
