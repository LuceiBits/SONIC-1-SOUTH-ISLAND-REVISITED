	death_timer++;
	
	obj_level.disable_timer = true;
	
	if(FRAME_TIMER mod 4 == 0 && death_timer < 120)
	{
		sound_play(sfx_explosion);
		instance_create_particle(x + random_range(-32, 32), y + random_range(-16, 16), spr_effect_explosion02, 0.3);
	}
	
	if(death_timer == 120)
	{
		instance_create_debris(x - 25, y - 13, spr_aaz1_boss_debris, 0, -2, 0, 0, 0.2);
		var d = instance_create_debris(x + 25, y - 13, spr_aaz1_boss_debris, 0, 2, 0, 0, 0.2);
		d.image_xscale = -1;
		animation_play(animator, 1);	
	}