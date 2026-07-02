/// @description Draw and flicker
	if(!animation_has_finished(animator) || animation_has_finished(animator) && FRAME_TIMER mod 16 < 16 / 2)
	{
		draw_animator(animator);
	}