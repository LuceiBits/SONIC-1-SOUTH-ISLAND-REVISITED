function game_init_music_list()
{
	global.music_map = ds_map_create();
	
	//Menu background music:
	music_add(MUSIC.MENU, bgm_menu, 0.565);
	
	//Stage background music:
	music_add(MUSIC.TECHDEMO_TOWER, bgm_foregone, 0.000);
	music_add(MUSIC.ARBOREAL_AGATE1, bgm_arboreal_agate1);
	music_add(MUSIC.ARBOREAL_AGATE2, bgm_arboreal_agate2, 15.239);
	music_add(MUSIC.BONUS, bgm_bonus, 16.657, 92.33, true);
	
	//Game jingles:
	music_add(MUSIC.J_GAME_OVER, j_game_over, 0.00, 0.00, false);
	music_add(MUSIC.J_INVINCIBLE, j_invincible, 0.00, 0.00, false);
	music_add(MUSIC.J_SPEEDSHOE, j_speedshoe, 0.00, 0.00, false);
	music_add(MUSIC.J_ACT_CLEAR, j_zone_complete, 0.00, 0.00, false);
	music_add(MUSIC.SUPER, j_super, 0.565);
}

	//Setup enum for music ID
	enum MUSIC 
	{
		MENU,
		ARBOREAL_AGATE1,
		ARBOREAL_AGATE2,
		TECHDEMO_TOWER,
		BONUS,
		J_GAME_OVER,
		J_INVINCIBLE,
		J_SPEEDSHOE,
		J_ACT_CLEAR,
		SUPER
	}
