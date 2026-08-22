function player_spike_parry(targetX = x,targetY = y)
{
	if place_meeting(targetX,targetY,obj_insta_shield) // Lucei aura spike parry
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
			instance_create_particle(targetX, targetY, spr_electric_sparks, 1, depth + 1, 2 * dsin(45 + (90 * i)), 2 * dcos(45 + (90 * i)))
		
		instance_destroy(obj_insta_shield)
		return true
		exit;
	}
	else
		return false
}