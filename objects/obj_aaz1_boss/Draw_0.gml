	if((inv_timer > 0 || death_timer > 0) && instance_flash(2))
		effect_set_palette(spr_aaz1_boss_hit_pal, 0);
		
	draw_animator(animator);
	shader_reset();