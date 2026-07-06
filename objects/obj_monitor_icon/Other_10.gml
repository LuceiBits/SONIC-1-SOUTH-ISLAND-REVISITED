/// @description Rewards
	switch(monitor_type)
	{
		case MONITOR.RINGS:
			global.rings += 10;
			play_sound(sfx_superring);
		break;
		
		case MONITOR.SHIELD:
			obj_player.shield = S_NORMAL;
			play_sound(sfx_shield);
		break;
		
		case MONITOR.ELECTRIC_SHIELD:
			obj_player.shield = S_ELECTRIC;
			play_sound(sfx_shield_electric);
		break;
		
		case MONITOR.FIRE_SHIELD:
			obj_player.shield = S_FIRE;
			play_sound(sfx_shield_fire);
		break;
		
		case MONITOR.BUBBLE_SHIELD:
			obj_player.shield = S_BUBBLE;
			play_sound(sfx_shield_bubble);
		break;
		
		case MONITOR.INVINCIBLE:
			obj_player.invincible = true
			obj_player.invincible_timer = 1200;
			if(!audio_is_playing(j_super))
				music_play(MUSIC.J_INVINCIBLE, Jingle);
		break;
		
		case MONITOR.SPEED_SHOES:
			obj_player.speed_shoes = 1200;
			if(!audio_is_playing(j_super))
				music_play(MUSIC.J_SPEEDSHOE, Jingle);	
		break;
		
		case MONITOR.EGGMAN:
			player_hurt();
		break;
		
		case MONITOR.EXTRA_LIFE:
			SOUND_EXTRA_LIFE;
			global.life += 1;
		break;
		
		case MONITOR.COMBINE_RING:
			obj_player.combinering = 1;
			play_sound(sfx_combinering);
		break;
		
	}