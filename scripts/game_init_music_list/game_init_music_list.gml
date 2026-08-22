function game_init_music_list()
{
	global.music_map = ds_map_create();
	
	// Menu background music:
	music_add(MUSIC.TITLE, bgm_title_screen, 3.856);
	music_add(MUSIC.MAIN_MENU, bgm_main_menu);
	
	// Stage background music:
	music_add(MUSIC.TECHDEMO_TOWER, bgm_test_stage, 0.000);
	music_add(MUSIC.ARBOREAL_AGATE1, bgm_arboreal_agate1);
	music_add(MUSIC.ARBOREAL_AGATE2, bgm_arboreal_agate2, 15.239);
	music_add(MUSIC.BONUS, bgm_bonus, 16.657, 92.33, true);
	music_add(MUSIC.BLUE_SPHERES, bgm_blue_spheres, 6.923);
	music_add(MUSIC.TEMP, bgm_temp, 0.000);
	music_add(MUSIC.GREEN_HILL_ZONE_ACT_1, greenhillact1_tripleb,,,true);
	music_add(MUSIC.MARBLE_ZONE_ACT_1, marble_zone, 2.030,74.030,true);
	music_add(MUSIC.SPRING_YARD_ZONE_ACT_1, springyard_zone, 2.290,79.090,true);
	music_add(MUSIC.WATERFALL_ZONE, waterfall_zone_tripleb, 2.050,71.790,true);
	music_add(MUSIC.LABYRINTH_ZONE_ACT_1, labyrinth_zone_act1_samwow, 3.900,105.360,true);
	music_add(MUSIC.LABYRINTH_ZONE_ACT_2, labyrinth_zone_act2_wip, 39.270,104.720,true);

	
	
	// General stage music:
	music_add(MUSIC.MINI_BOSS, bgm_mini_boss, 6.923);
	
	// Game jingles:
	music_add(MUSIC.GAME_OVER, j_game_over, 0.00, 0.00, false);
	music_add(MUSIC.INVINCIBLE, j_invincible,0.890,, true);
	music_add(MUSIC.SPEEDSHOES, j_speedshoe,0.890,, true);
	music_add(MUSIC.ACT_CLEAR, j_zone_complete, 0.00, 0.00, false);
	music_add(MUSIC.SUPER, j_super, 0.565);
}

	//Setup enum for music ID
	enum MUSIC 
	{
		TITLE,
		MAIN_MENU,
		ARBOREAL_AGATE1,
		ARBOREAL_AGATE2,
		TECHDEMO_TOWER,
		MINI_BOSS,
		BONUS,
		BLUE_SPHERES,
		GAME_OVER,
		INVINCIBLE,
		SPEEDSHOES,
		ACT_CLEAR,
		SUPER,
		TEMP,
		GREEN_HILL_ZONE_ACT_1,
		MARBLE_ZONE_ACT_1,
		SPRING_YARD_ZONE_ACT_1,
		WATERFALL_ZONE,
		LABYRINTH_ZONE_ACT_1,
		LABYRINTH_ZONE_ACT_2,
	}
