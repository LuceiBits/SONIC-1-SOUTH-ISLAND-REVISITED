	// Draw nothing if there's nothing to draw
	if(!animator.animation_sprite || parent.invincible)
		exit;
		
	// Draw it
	draw_animator(animator);
	
	// Exclusive to the bubble shield
	var duration = 4;
	if(parent.shield == SHIELD.BUBBLE && FRAME_TIMER mod duration == 0 && animation_is_playing(animator, SHIELD_ANIM.BUBBLE_IDLE))
	{
		draw_sprite(spr_bubble_shield_other, FRAME_TIMER / duration, floor(x), floor(y));	
	}