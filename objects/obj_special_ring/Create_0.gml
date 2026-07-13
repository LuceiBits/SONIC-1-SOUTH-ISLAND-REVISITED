	entered = false;
	enter_timer = 0;
	
	animator = new animator_create();
	
	animation_add(0, sprite_index, 0.3);
	
	animation_play(animator, 0);