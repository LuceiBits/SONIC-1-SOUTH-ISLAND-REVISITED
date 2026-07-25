
y_speed += y_accel;	
if (y_speed > 2) {
	y_speed = 2;	
}
y += y_speed;
y = max(y, obj_gumball_machine.y+64);

image_index = reward;
image_speed = 0;

if (player_collide_object(COLLISION.MAIN) && !obj_player.input_disable){
	switch (reward){
		case GUMBALL.EMPTY:
			sound_play(sfx_burst);
			instance_destroy();
		break;
		case GUMBALL.NORMAL:
			sound_play(sfx_shield);
			player_set_shield(SHIELD.NORMAL);
			instance_destroy();
		break;
		case GUMBALL.BUBBLE:
			sound_play(sfx_shield_bubble);
			player_set_shield(SHIELD.BUBBLE);
			instance_destroy();
		break;
		case GUMBALL.ELECTRIC:
			sound_play(sfx_shield_electric);
			player_set_shield(SHIELD.ELECTRIC);
			instance_destroy();
		break;
		case GUMBALL.FIRE:
			sound_play(sfx_shield_fire)
			player_set_shield(SHIELD.FIRE);
			instance_destroy();
		break;
		case GUMBALL.RINGS:
			global.rings += 10;
			sound_play(sfx_ring);
			instance_destroy();
		break;
		case GUMBALL.ONEUP:
			music_play_jingle();
			global.life += 1;
			instance_destroy();
		break;
		case GUMBALL.REPOSITION:
			sound_play(sfx_burst);
			var spring = obj_crumple_spring;
			spring.y = spring.ystart;
			spring.crumple = false;
			spring.fall_speed = 0;
			spring.triggered = false;
			spring.visible = true;
			spring.collision_flag = true;
			instance_destroy();
		break;
		case GUMBALL.BUMPER:
			sound_play(sfx_rubber);
			var player = instance_nearest(x,y,obj_player);
			var angle = point_direction(x,y,player.x,player.y);
			player.x_speed = BUMPER_FACTOR * dcos(angle);
			player.y_speed = -BUMPER_FACTOR * dsin(angle);
			player.ground = false;
		break;
	}
}

if (y > obj_bonus_exit.bbox_bottom) {
	instance_destroy();	
}