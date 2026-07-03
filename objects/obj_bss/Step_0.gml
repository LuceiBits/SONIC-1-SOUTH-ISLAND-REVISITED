/// @description BSS update

//Keep the bonus stage view fixed to the window
if (view_camera[0] >= 0) {
	view_enabled = true;
	camera_set_view_size(view_camera[0], WINDOW_WIDTH, WINDOW_HEIGHT);
	camera_set_view_pos(view_camera[0], 0, 0);
}

//Pause
if (input_active && input_press(INPUT.START) && !instance_exists(obj_pause) && !instance_exists(obj_game_over))
{
	global.process_objects = false;
	instance_create_depth(0, 0, -100, obj_pause);
}
if (!global.process_objects) exit;

//Input
var kU = input_active && input_hold(INPUT.UP);
var kL = input_active && input_hold(INPUT.LEFT);
var kR = input_active && input_hold(INPUT.RIGHT);
var kJump = input_active && input_press(INPUT.A);
if (kL && kR) { kL = false; kR = false; }

//---- BSS_Player_Update port ----
if (on_ground)
{
	if (kJump)
	{
		velocity_y = -1048576; //-TO_FIXED(16)
		on_ground = false;
		animation_play(animator, ANIM_BSS_JUMP);
		roll_timer = 0;
		play_sound(sfx_jump);
	}
}
else
{
	gravity_strength += velocity_y;
	var sp = (speedup_level == 0) ? 16 : speedup_level;
	velocity_y += sp << 12;
	if (gravity_strength >= 0)
	{
		gravity_strength = 0;
		on_ground = true;
		if (animation_get_current_animation(animator) == ANIM_BSS_SPRING) globe_speed = ashr(globe_speed, 1);
		globe_speed_inc = 2;
		animation_play(animator, (speedup_level != 0) ? ANIM_BSS_WALK : ANIM_BSS_STAND);
	}
}

//Drive the current animation
var cur_anim = animation_get_current_animation(animator);
if (cur_anim == ANIM_BSS_WALK)
{
	walk_timer += abs(globe_speed);
	if (walk_timer > 31)
	{
		walk_timer &= 31;
		var wn = animation_get_frame_count(animator);
		var wf = animation_get_frame(animator);
		if (globe_speed <= 0) {
			if (--wf < 0) wf = wn - 1;
		}
		else {
			if (++wf > wn - 1) wf = 0;
		}
		animation_set_frame(animator, wf);
	}
}
else if (cur_anim >= ANIM_BSS_JUMP)
{
	roll_timer += max(abs(speedup_level), 16);
	if (roll_timer >= 16)
	{
		roll_timer -= 16;
		var rn = animation_get_frame_count(animator);
		animation_set_frame(animator, (animation_get_frame(animator) + 1) mod rn);
	}
}

//Tails' tail
if (has_tail)
{
	animation_set_speed(tail_animator, (abs(speedup_level) + 40) / 96);
	animator_update(tail_animator);
}

//---- BSS_Message GETSPHERES port ----
if (msg_phase == 0)
{
	msg_fade_timer -= 16;
	if (msg_fade_timer <= 0) { msg_fade_timer = 0; msg_phase = 1; }
}
else if (msg_phase == 1)
{
	if (speedup_level == 0)
	{
		if (kU)
		{
			speedup_level   = 16;
			globe_speed     = 16;
			globe_speed_inc = 2;
			if (on_ground) animation_play(animator, ANIM_BSS_WALK);
			msg_phase = 2;
		}
		if (globe_timer == 0 && state == BS_MOVE)
		{
			if (kL) { state = BS_TURNL; spin_timer = 0; }
			if (kR) { state = BS_TURNR; spin_timer = 0; }
		}
	}
	if (msg_phase == 1 && ++msg_wait_timer >= 180)
	{
		msg_wait_timer  = 0;
		speedup_level   = 16;
		globe_speed     = 16;
		globe_speed_inc = 2;
		if (on_ground) animation_play(animator, ANIM_BSS_WALK);
		msg_phase = 2;
	}
}

//---- BSS_Setup state machine ----
switch (state)
{
	case BS_MOVE: //BSS_Setup_State_GlobeMoveZ
		globe_hidden = false;

		if (speedup_level < 32 && ++speedup_timer >= speedup_interval)
		{
			speedup_timer = 0;
			speedup_level += 4;
		}

		if (player_was_bumped) {
			if (!disable_bumpers && kU) player_was_bumped = false;
		}
		else if (globe_speed < speedup_level) {
			globe_speed += globe_speed_inc;
		}

		if (on_ground)
		{
			if (globe_timer > 0 && globe_timer < 256)
			{
				if (kL) spin_state = 1;
				if (kR) spin_state = 2;
			}
			globe_timer += globe_speed;
			stepped_objects(); //may change state
		}
		else
		{
			globe_timer += globe_speed;
			spin_state = 0;
		}

		if (state == BS_MOVE)
		{
			if (globe_speed > 0)
			{
				if (globe_timer >= 256)
				{
					switch (spin_state)
					{
						case 0: globe_timer -= 256; break;
						case 1: state = BS_TURNL; globe_timer = 0; spin_timer = 0; break;
						case 2: state = BS_TURNR; globe_timer = 0; spin_timer = 0; break;
					}
					palette_page ^= 1;
					spin_state = 0;
					player_x = (player_x + ashr(sin256(angle), 8)) & 31;
					player_y = (player_y - ashr(cos256(angle), 8)) & 31;
				}
			}
			else if (globe_timer < 0)
			{
				switch (spin_state)
				{
					case 0:
						globe_timer += 256;
						palette_page ^= 1;
						player_x = (player_x - ashr(sin256(angle), 8)) & 31;
						player_y = (player_y + ashr(cos256(angle), 8)) & 31;
						break;
					case 1: state = BS_TURNL; globe_timer = 0; spin_timer = 0; break;
					case 2: state = BS_TURNR; globe_timer = 0; spin_timer = 0; break;
				}
				spin_state = 0;
			}
		}

		palette_line = ashr(globe_timer, 4) & 15;
		break;

	case BS_TURNL: //BSS_Setup_State_GlobeTurnLeft
		if (speedup_level < 32 && ++speedup_timer >= speedup_interval)
		{
			speedup_timer = 0;
			speedup_level += 4;
		}
		angle = (angle - 4) & 255;

		if (spin_timer == 15)
		{
			globe_hidden = false;
			spin_timer = 0;
			palette_page ^= 1;
			state = (timer_100 == 0) ? BS_MOVE : BS_TELE_OUT;
		}
		else
		{
			globe_hidden = true;
			turn_frame = global.bss.globeFrameTable[spin_timer];
			turn_flip  = global.bss.globeDirTableL[spin_timer];
			spin_timer++;
			if (timer_100 > 1) timer_100--;
		}
		break;

	case BS_TURNR: //BSS_Setup_State_GlobeTurnRight
		if (speedup_level < 32 && ++speedup_timer >= speedup_interval)
		{
			speedup_timer = 0;
			speedup_level += 4;
		}
		angle = (angle + 4) & 255;

		if (spin_timer == 15)
		{
			globe_hidden = false;
			spin_timer = 0;
			state = (timer_100 == 0) ? BS_MOVE : BS_TELE_OUT;
		}
		else
		{
			globe_hidden = true;
			if (spin_timer == 0) palette_page ^= 1;
			turn_frame = global.bss.globeFrameTable[spin_timer];
			turn_flip  = global.bss.globeDirTableR[spin_timer];
			spin_timer++;
			if (timer_100 > 1) timer_100--;
		}
		break;

	case BS_TELE_IN: //BSS_Setup_State_StartGlobeTeleport
		tele_timer += 8;
		if (tele_timer == 320)
		{
			animation_play(animator, ANIM_BSS_STAND);

			//pick another pink sphere
			if (pink_count > 1)
			{
				var picks = [];
				for (var gy = 0; gy < BSS_H; gy++)
				{
					for (var gx = 0; gx < BSS_W; gx++)
					{
						if ((global.bss.pf[gy + (32 * gx)] & 0x7F) == C_PINK && (gx != player_x || gy != player_y))
							array_push(picks, [gx, gy]);
					}
				}
				if (array_length(picks) > 0)
				{
					var pk = picks[irandom(array_length(picks) - 1)];
					player_x = pk[0];
					player_y = pk[1];
				}
			}

			//pick a valid exit direction, distance 1 then distance 2
			var dir = irandom(3);
			var found_dir = false;
			for (var i = 0; i < 4; i++)
			{
				var tx = player_x;
				var ty = player_y;
				switch (dir) {
					case 0: ty = (ty - 1) & 31; break;
					case 1: tx = (tx + 1) & 31; break;
					case 2: ty = (ty + 1) & 31; break;
					case 3: tx = (tx - 1) & 31; break;
				}
				var tile = global.bss.pf[ty + (32 * tx)];
				if (tile < C_RED || (tile > C_BUMPER && tile != C_PINK)) { found_dir = true; break; }
				dir = (dir + 1) & 3;
			}
			if (!found_dir)
			{
				for (var i = 0; i < 4; i++)
				{
					var tx = player_x;
					var ty = player_y;
					switch (dir) {
						case 0: ty = (ty - 2) & 31; break;
						case 1: tx = (tx + 2) & 31; break;
						case 2: ty = (ty + 2) & 31; break;
						case 3: tx = (tx - 2) & 31; break;
					}
					var tile = global.bss.pf[ty + (32 * tx)];
					if (tile < C_RED || (tile > C_BUMPER && tile != C_PINK)) { found_dir = true; break; }
					dir = (dir + 1) & 3;
				}
			}

			angle = (dir << 6) & 255;

			array_push(collected, { ce : CE_PINK, cx : player_x, cy : player_y, t : 0 });
			global.bss.pf[player_y + (32 * player_x)] = C_PINK_STOOD;

			timer_100 = 100;
			state = BS_TELE_OUT;
			fade_change(FADE_IN, 6, FADE_WHITE); //fade the white flash back out
		}
		break;

	case BS_TELE_OUT: //BSS_Setup_State_FinishGlobeTeleport
		if (tele_timer <= 0)
		{
			if (kU) timer_100 = 1;
			else if (kL) { state = BS_TURNL; spin_timer = 0; }
			else if (kR) { state = BS_TURNR; spin_timer = 0; }
		}
		else {
			tele_timer -= 8;
		}

		timer_100--;
		if (timer_100 == 0)
		{
			state = BS_MOVE;
			if (on_ground) animation_play(animator, ANIM_BSS_WALK);
		}
		break;

	case BS_JETTISON: //BSS_Setup_State_GlobeJettison
		globe_hidden = false;
		globe_timer += globe_speed;
		if (globe_speed <= 0 && globe_timer < 0)
		{
			palette_page ^= 1;
			globe_timer += 256;
			player_x = (player_x - ashr(sin256(angle), 8)) & 31;
			player_y = (player_y + ashr(cos256(angle), 8)) & 31;
		}
		else if (globe_timer >= 256)
		{
			palette_page ^= 1;
			globe_timer -= 256;
			player_x = (player_x + ashr(sin256(angle), 8)) & 31;
			player_y = (player_y - ashr(cos256(angle), 8)) & 31;
		}
		palette_line = ashr(globe_timer, 4) & 15;

		if (++spin_timer == 128)
		{
			spin_timer = 0;
			speedup_level = 8;
			globe_speed = 8;
			setup_finish();
			input_active = false;
			state = BS_EMERALD;
		}
		break;

	case BS_EMERALD: //BSS_Setup_State_GlobeEmerald
		globe_timer += globe_speed;
		spin_timer++;
		if (spin_timer == 120) play_sound(sfx_shard_collect);
		stepped_objects();

		if (globe_speed <= 0 && globe_timer < 0)
		{
			palette_page ^= 1;
			globe_timer += 256;
			player_x = (player_x - ashr(sin256(angle), 8)) & 31;
			player_y = (player_y + ashr(cos256(angle), 8)) & 31;
		}
		else if (globe_timer >= 256)
		{
			palette_page ^= 1;
			globe_timer -= 256;
			player_x = (player_x + ashr(sin256(angle), 8)) & 31;
			player_y = (player_y - ashr(cos256(angle), 8)) & 31;
		}
		palette_line = ashr(globe_timer, 4) & 15;
		break;

	case BS_EXIT: //BSS_Setup_State_GlobeExit
		speedup_level = 0;
		input_active = false;

		if (spin_timer > 0) angle = (angle - 8) & 255;

		if (spin_timer & 15)
		{
			globe_hidden = true;
			var tt = spin_timer & 15;
			turn_frame = global.bss.globeFrameTable[tt - 1];
			turn_flip  = global.bss.globeDirTableL[tt - 1];
		}
		else if (spin_timer > 0)
		{
			palette_page ^= 1;
			globe_hidden = false;
		}

		spin_timer += 2;

		//Fade to black while spinning
		fade_change(FADE_OUT, 3, FADE_BLACK);
		exit_timer++;
		if (exit_timer >= 90 && obj_fade.fade_timer == 0 && global.bonus_stage_state == BONUSSTAGE.INSIDE) {
			global.bonus_stage_state = BONUSSTAGE.LEAVING;
		}
		break;
}

//---- BSS_Collected updates ----
update_collected();

//cosmetic
ring_spin += 0.25;
if (ring_spin >= sprite_get_number(spr_bss_ring)) ring_spin -= sprite_get_number(spr_bss_ring);
medal_spin += 0.5;
if (medal_spin >= sprite_get_number(spr_bss_medal_gold)) medal_spin -= sprite_get_number(spr_bss_medal_gold);

//background scroll
if (state != BS_TURNL && state != BS_TURNR) bg_scroll_y -= globe_speed / 4;
if (state == BS_EXIT) bg_scroll_x -= 32;
else bg_scroll_x = (angle & 255) * 4;

//GET BLUE SPHERES message scolling
if (msg_phase == 2)
{
	intro_offset += 16;
	if (intro_offset > 320) msg_phase = 3;
}

//PERFECT message
if (perfect_active)
{
	switch (perfect_phase)
	{
		case 0: perfect_offset -= 16; if (perfect_offset <= 0) { perfect_offset = 0; perfect_phase = 1; } break;
		case 1: if (++perfect_wait >= 180) perfect_phase = 2; break;
		case 2: perfect_offset += 16; if (perfect_offset > 320) perfect_active = false; break;
	}
}

//music speeds up 1.05x per speedup interval
music_set_pitch(BGM, power(1.05, (max(speedup_level, 16) - 16) / 4));
