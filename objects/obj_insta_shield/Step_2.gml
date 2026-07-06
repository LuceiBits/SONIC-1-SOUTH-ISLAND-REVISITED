	// Position the insta shield
	x = player.x;
	y = player.y;
	
	// Update the animator
	animator_update(animator);
	
	// Destroy the insta shield when the animation is over
	if(animation_has_finished(animator)) 
		instance_destroy();
	