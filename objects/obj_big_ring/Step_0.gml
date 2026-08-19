
if global.rings >= 100
unlocked_bonus = true
else
unlocked_bonus = false



if unlocked_bonus = true && obj_signpost.triggered = true
visible = true
else
visible = false

if sprite_index = spr_big_ring_idle && instance_place(x,y,obj_player) && visible
{
sprite_index = spr_big_ring_disappear
obj_player.input_disable = true;
			
			sound_play(sfx_warp_into);
			fade_to_room(rm_bonus_temp, 2, FADE_COLOR.WHITE, 30);
			music_fade_channel(BGM, FADE.OUT, 3);
			
			global.store_player_state.combinering = obj_player.combinering;
			global.store_player_state.shield = obj_player.shield;
			global.store_player_state.rings = global.rings;
			global.previous_room = room;
			
			global.process_objects = false;
			bonus_stage_trigger = true;
}