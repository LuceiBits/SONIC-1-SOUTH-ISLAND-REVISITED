/// @description Values
	type = 0;
	angle = 2 * random(360);
	image_speed = 0.12;
	
	var baseAnimSpd = 0.12;
	
	animation_add(0, spr_bubble_1, baseAnimSpd, 0, false);
	animation_add(1, spr_bubble_2, baseAnimSpd, 0, false);
	animation_add(2, spr_bubble_3, baseAnimSpd, 0, false);
	
	animator = new animator_create();
	
	animation_play(animator, 0);