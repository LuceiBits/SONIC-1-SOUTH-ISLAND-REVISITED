/// @description Start
	timer = 0;
	screen_x = 0;
	screen_y = 0;
	type = 0;
	angle = 0;
	anim_update = true;
	var animSpd = 4;
	
	animation_add(0, spr_bubble_number_0, animSpd, 0, false, true);
	animation_add(1, spr_bubble_number_1, animSpd, 0, false, true);
	animation_add(2, spr_bubble_number_2, animSpd, 0, false, true);
	animation_add(3, spr_bubble_number_3, animSpd, 0, false, true);
	animation_add(4, spr_bubble_number_4, animSpd, 0, false, true);
	animation_add(5, spr_bubble_number_5, animSpd, 0, false, true);
	
	animator = new animator_create();
	
	animation_play(animator, 0);