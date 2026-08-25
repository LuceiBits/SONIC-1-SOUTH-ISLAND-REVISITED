/// @description Values
	type = 0;
	angle = 2 * random(360);
	decay_timer = 120
	x_speed = 0
	y_speed = 0
	image_speed = 0.12;
	
	var baseAnimSpd = 0.12;
	
	animation_add(0, spr_bubble_1, baseAnimSpd, 0, false);
	animation_add(1, spr_bubble_2, baseAnimSpd, 0, false);
	animation_add(2, spr_bubble_3, baseAnimSpd, 0, false);
	
	animator = new animator_create();
	
	animation_play(animator, irandom_range(0,2));
	/*
	waterID = noone
	
	if place_meeting(x,y,obj_water)
		waterID = instance_place(x,y,obj_water)
	else if place_meeting(x,y,obj_water_pool)
		waterID = instance_place(x,y,obj_water_pool)
		*/