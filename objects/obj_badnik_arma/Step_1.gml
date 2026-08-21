/// @description Main player
if global.process_objects = false
exit;

// ACTUAL ENEMY CODE
var timer_init = 50

if arma_state = ARMA_STATE.IDLE
{
if has_shell
animation_play(arma_animator, 0,);
else
animation_play(arma_animator, 2,);
	
x_speed = 0
ground_speed = 0

var c = point_distance(x,y,obj_player.x,obj_player.y)	

if c < 100
{
if arma_attack = false && ground
	{
	//duped jump code
	if has_shell
	animation_play(arma_animator, 1, true);
	else
	animation_play(arma_animator, 3, true);
	
	
		y_speed -= jump_strength * dcos(ground_angle);	
		x_speed -= jump_strength * dsin(ground_angle);
			
		//Trigger the jump flag
		jump_flag = true;
			
		//Detach player off the ground and change state
		ground = false;
		//state = player_state_jump
		//dropdash_timer = 0;
		//idle_timer = 0;
		
		//Change jump animation duration
		//jump_anim_speed = floor(max(0, 4 - abs(ground_speed)));
			
		//Reset angle and floor mode
		ground_angle = 0;
		player_mode(COLLISION_MODE.FLOOR);
			
		//Play the sound
		sound_play(sfx_jump);
		//jump_buffer = 0
	
	//

	arma_attack = true	
	arma_attack_timer = timer_init
	arma_state = ARMA_STATE.TUCKED
	}
}	
}
	
if arma_attack = true && ground
{
if arma_attack_timer = timer_init
{
sound_play(sfx_spindash)
	if obj_player.x > x 
		{
		facing = 1
		show_debug_message("FACE PLAYER ON RIGHT")
		}

		if obj_player.x < x 
		{
		facing = -1
		show_debug_message("FACE PLAYER ON LEFT")
		}	
}
arma_attack_timer -= 1
}

if arma_attack_timer = 0 && arma_attack = true
{
arma_attack = false
show_debug_message("attempted to spindash")
x_speed = 5 * facing
ground_speed = x_speed
}

if x_speed = 0 && ground_speed = 0 && arma_state = ARMA_STATE.TUCKED && arma_attack = false && ground
idle_timer += 1
else if idle_timer > 0
idle_timer -= 1

if idle_timer > 50
arma_state = ARMA_STATE.IDLE
	
if inv_timer = 0 && obj_player.attacking = true && arma_state = ARMA_STATE.TUCKED && has_shell = true
{
	if player_collide_object(COLLISION.MAIN){
		inv_timer = 20
		var player = instance_nearest(x,y,obj_player);
		var angle = point_direction(x,y,player.x,player.y);
		var player_ground_speed = player.ground_speed
		player.x_speed = BUMPER_FACTOR * dcos(angle);
		player.y_speed = -BUMPER_FACTOR * dsin(angle);
		if player.ground || player.on_terrain
		player.ground_speed = ground_speed * -1
		x_speed = BUMPER_FACTOR * dcos(angle + 180);
		y_speed = -BUMPER_FACTOR * dsin(angle + 180);
		if ground || on_terrain
		{
		if ground_speed = 0
		ground_speed = player_ground_speed
		else
		ground_speed = ground_speed * -1
		}
		else
		x_speed *= 0.8
		y_speed *= 0.8
		player.ground = false;
		//arma_state = ARMA_STATE.VULNERABLE
		arma_attack = false
				if has_shell
		{
		animation_play(arma_animator, 3, true);
		sound_play(sfx_rubber)
		has_shell = false
		}
	}
}	
	
	
	
	
	
	
// PLAYER CODE FUCKERY START

//hacky physics fix this sucks
state = arma_state_roll()
	

	hitbox_top_offset = 0;
	hitbox_left_offset = 0;
	hitbox_bottom_offset = 0;
	hitbox_right_offset = 0;
	
	
	//Player input scripts
	//player_get_input();
	
	//Hande player physics values
	player_handle_physics();
	
	//prevent player for dieing in the bonus stage

	
	//check if player should be able to turn super
	
	//Handle invincibility and speed shoes
	
	//Step movement for sticking on the collision
	steps = min(1 + abs(round(x_speed / PLAYER_STEPS_AMOUNT)) + abs(round(y_speed / PLAYER_STEPS_AMOUNT)), PLAYER_MAX_STEPS);
	
	//Cancel when in debug mode

	//Include step movement
	repeat(steps)
	{
		//Handle player movement:
		player_movement();
		
		//Handle how player changes floor modes:
		if(!PLAYER_ALT_COLLISION_MODE)
			player_mode();
		
		//Handle player terrain collision:
		player_collision();
	}
	
	//Handle how player is controlled:
	arma_control();

	//Update player's animator
	animator_update(arma_animator);
	
	//Handle player states
	//player_states();
		
	//Player facing direction
	player_direction();
	
	//Handle partial visual rotation
	//player_visual_angle();
	
	//Various hitbox cases
	arma_hitbox();
	
	//Misc. player stuff
	arma_misc();
	
	//Handle player's interaction with water
	player_water();
	
	// Update the recorder
	//instance_recorder_update(recorder);