animator_update(animator);

if player_collide_object(COLLISION.MAIN) || instance_place(x,y,obj_badnik_arma)
{
	var player = instance_nearest(x,y,obj_player);
	if instance_place(x,y,obj_badnik_arma)
	player = instance_place(x,y,obj_badnik_arma) 
	var angle = point_direction(x,y,player.x,player.y);
	player.jump_flag = false
	player.ground = false;
	player.x_speed = BUMPER_FACTOR * dcos(angle);
	player.y_speed = -BUMPER_FACTOR * dsin(angle);


	
	sound_play(sfx_bumper)
	score_life--;
	if (score_life > 0) {
		var obj = instance_create_depth(x, y, depth-1, obj_score_effect);
		obj.image_index = 6;
		global.score += 10;
	
	}
	animation_play(animator, BUMPERANI.BUMP);
}

if (animation_is_playing(animator, BUMPERANI.BUMP) && animation_has_finished(animator)){
	animation_play(animator, BUMPERANI.STOPPED);	
}