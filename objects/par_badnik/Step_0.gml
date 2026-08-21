/// @description Parent script
	
	//Destroy the enemy
	if((player_collide_object() || player_insta_shield_collide() || place_meeting(x,y,obj_badnik_arma)) && destructible)
	{
		var fly_angle = 90 - point_direction(obj_player.x, obj_player.y,x,y) 
		var fly_cond = (obj_player.state == player_state_tailsfly && abs(fly_angle) < 45)
		var arma_check = place_meeting(x,y,obj_badnik_arma)
		
		
		if(obj_player.attacking || obj_player.invincible || fly_cond) || (arma_check && instance_place(x,y,obj_badnik_arma).arma_state = ARMA_STATE.TUCKED)
		{
			//Create animal buddies instead
			instance_create_depth(x, y, depth, obj_animal);
		
			//Player bounce
			obj_player.y_speed = -abs(obj_player.y_speed);
		
			//Create score object and add combo and badnik chain
			obj_level.badnik_chain += 1;
			instance_create_score();
		
			//Create explosion effect
			instance_create_particle(x, y, spr_effect_explosion01, 0.3);
		
			//Play destroying sound
			sound_play(sfx_destroy);
		
			//Destroy badnik
			if (!instance_exists(obj_bonus_cont)) {
				global.store_object_state[| id] = true
			}
			instance_destroy();	
		}
		else if(hurting) && !place_meeting(x,y,obj_badnik_arma)
		{
			//Player getting hurt
			player_hurt();
		}
	}