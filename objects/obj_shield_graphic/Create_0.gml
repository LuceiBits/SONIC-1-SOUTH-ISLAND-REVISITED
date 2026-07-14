	enum SHIELD_ANIM
	{
		// Normal Shield
		NORMAL_IDLE,
		
		// Fire Shield
		FIRE_IDLE,
		FIRE_DASH,
		
		// Electric Shield
		ELECTRIC_IDLE,
		
		// Bubble Shield
		BUBBLE_IDLE,
		BUBBLE_BOUNCE_IN,
		BUBBLE_BOUNCE_OUT
	}
	
	// Add animations
	animation_add(SHIELD_ANIM.NORMAL_IDLE, spr_shield, 0, 0, true, true);
	
	// Fire shield
	animation_add(SHIELD_ANIM.FIRE_IDLE, spr_fire_shield, 1, 0, true, true);
	animation_add(SHIELD_ANIM.FIRE_DASH, spr_fire_shield_dash, 1, 0, true, true);
	
	// Electric shield
	animation_add(SHIELD_ANIM.ELECTRIC_IDLE, spr_electric_shield, 1, 0, true, true);
	
	// Bubble shield
	animation_add(SHIELD_ANIM.BUBBLE_IDLE, spr_bubble_shield, 1, 0, true, true);
	animation_add(SHIELD_ANIM.BUBBLE_BOUNCE_IN, spr_bubble_shield_bounce, 1, 0, true, true);
	animation_add(SHIELD_ANIM.BUBBLE_BOUNCE_OUT, spr_bubble_shield_bounce_reverse, 1, 0, true, true);
	
	// Setup the animator
	animator = new animator_create();
	animation_play(animator, SHIELD_ANIM.NORMAL_IDLE);
	
	parent = noone;