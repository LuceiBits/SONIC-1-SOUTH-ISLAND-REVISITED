// Inherit the parent event




if toggle_timer = 0
{

extended += 1


if extended > 1
extended = 0

	if extended && sprite_index != spr_pike_extend && sprite_index != spr_pike_idle_extended
	{
	show_debug_message("EXTEND BITCH")
	sprite_index = spr_pike_extend
	image_index = 0
	}

	if !extended && sprite_index != spr_pike_retract  && sprite_index != spr_pike_idle_retracted
	{
	show_debug_message("RETRACT BITCH")
	sprite_index = spr_pike_retract
	image_index = 0
	}

	toggle_timer = 200
}

if toggle_timer > 0
toggle_timer -= 1

player_spike_parry(x,y)

if place_meeting(x,y,obj_player) && obj_player.state != player_state_death && obj_player.state != player_state_drown
{
	
var center_x = floor((obj_player.x + 16)/32) * 32;

var player = player_find(0)
		if(player.invincible_timer == 0 && player.insta_shield_invincible == 0)
			sound_play(sfx_spike);
		
		player_hurt(center_x);	
}

