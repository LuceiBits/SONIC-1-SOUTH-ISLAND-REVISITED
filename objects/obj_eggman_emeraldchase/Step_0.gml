// Reused Bumper Code
animator_update(animator);

if player_collide_object(COLLISION.MAIN) && invincible_frames = 0{
	var player = instance_nearest(x,y,obj_player);
	var angle = point_direction(x,y,player.x,player.y);
	player.x_speed = BUMPER_FACTOR * dcos(angle);
	player.y_speed = -BUMPER_FACTOR * dsin(angle);
	player.ground = false;
	
	
	invincible_frames = 100
	pause_timer = clamp(101 - round(pause_timer_decay),5,100000)
	pause_timer_decay += pause_timer_decay
	
	sound_play(sfx_boss_hit)
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

if movespeed_increase_timer <= 0
	{
	movespeed += 0.1
	clamp(movespeed,0,5)
	var timer_init = 500 - round(movespeed)
	movespeed_increase_timer = timer_init
	}

if aligning = false && pause_timer = 0
	{
		if movedir_y = "Up"
		y -= movespeed
		if movedir_y = "Down"
		y += movespeed
		if movedir_x = "Left"
		x -= movespeed
		if movedir_x = "Right"
		x += movespeed
	}

//if movedir_x = "WON"
//lose_timer += 1


if movedir_x = "WON"
{
movedir_y = "PLAYED SOUND"
}

//if lose_timer = 1 && obj_player.state != player_state_death
//{
///obj_player.state = player_state_death
//ground = false
//on_terrain = false
//y_speed = -10
//}

movespeed_increase_timer -= 1

if pause_timer > 0
pause_timer -= 1

if invincible_frames > 0
{
invincible_frames -= 1
}