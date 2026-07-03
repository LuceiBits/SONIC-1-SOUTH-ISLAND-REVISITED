/// @description Stage start
	ring_count = ring_target; //pick up any per-stage override from the room creation code
	play_music(stage_music, BGM);
	fade_in_room(3.125, FADE_WHITE);
	global.bonus_stage_state = BONUSSTAGE.INSIDE;
