if instance_place(x,y,obj_player) && activated = false
{
activated = true
obj_player.control_lock = 10000
}

if activated = true 
{
if activation_timer < 1
{

music_set_fade(FADE.OUT,2)
if fail_state = false
sound_play(sfx_signpost)
else
sound_play(sfx_ringloss)
fade_change(FADE.OUT,2,c_white)
}
obj_player.input_disable = true
activation_timer += 1
obj_camera.target_left = x - obj_camera.center_x;
obj_camera.target_right = x + obj_camera.center_x;
}


if activation_timer = 100
{
fade_change(FADE.IN,1,)
var _clear = instance_create_depth(0, 0, 0, obj_special_stage_clear);
				
				if (reward_is_emerald)
				{
				if !fail_state // check if eggman got it first
					{
					emerald_was_new = !global.emeralds[emerald_index]; //new, or a replay of one we own?
					global.emeralds[emerald_index] = true;  
					}//award it
				}
				
				
				if (reward_is_emerald)
				{
					if !fail_state
					{
					if (emerald_was_new && game_has_all_emeralds()) _clear.heading = "gotall";
					else if (emerald_was_new)  _clear.heading = "gotone";
					else _clear.heading = "chaos";
					}
					else
					_clear.heading = "failed"
					//_clear.perfect = (ring_count <= 0);
				}
				activation_timer += 1
}

if obj_eggman_emeraldchase.movedir_x = "WON" && activated = false
{
	y = math_approach(y,obj_eggman_emeraldchase.y,0.25)
	obj_camera.camera_shake = 1
	if y = obj_eggman_emeraldchase.y 
	{
	fail_state = true
	activated = true
	}
	else
	{
	if !audio_is_playing(sfx_elevator)
	sound_play(sfx_elevator)	
	}
}