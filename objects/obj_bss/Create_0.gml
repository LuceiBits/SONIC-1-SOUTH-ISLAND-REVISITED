/// @description Blue Spheres controller

global.bss = {}; //all blue-spheres state + tables live under one namespace

bss_build_tables();
bss_load_data();      //frustum projection tables
bss_load_playfield(); //32x32 playfield from the room's "Playfield" tilemap

global.bss.chain = array_create(1024, BSS_CELL.NONE);
global.bss.coll  = array_create(1024, BSS_CELL.NONE);
global.bss.spark = array_create(1024, 0);
global.bss.lastSX = 0;
global.bss.lastSY = 0;
global.bss.loop = false;

center_x = WINDOW_WIDTH div 2;

//Per-stage config
stage_music = MUSIC.BLUE_SPHERES;
ring_target = 64;
palette_index = 0; //tex_pal_bss row used to recolour the stage

//Character animator
var _stand, _walk, _roll, _tail;
switch (global.character)
{
	case CHAR_TAILS:
		_stand = spr_bss_tails_stand;
		_walk = spr_bss_tails_walk;
		_roll = spr_bss_tails_roll;
		_tail = spr_bss_tails_tail;
		break;
	case CHAR_KNUX:
		_stand = spr_bss_knuckles_stand;
		_walk = spr_bss_knuckles_walk;
		_roll = spr_bss_knuckles_roll;
		_tail = noone;
		break;
	default:
		_stand = spr_bss_sonic_stand;
		_walk = spr_bss_sonic_walk;
		_roll = spr_bss_sonic_roll;
		_tail = noone;
		break;
}

animator = new animator_create();
animation_add(BSS_ANIM.STAND,  _stand, 0, 0, false);
animation_add(BSS_ANIM.WALK,   _walk,  0, 0, true);
animation_add(BSS_ANIM.JUMP,   _roll,  0, 0, true);
animation_add(BSS_ANIM.SPRING, _roll,  0, 0, true);
animation_play(animator, BSS_ANIM.STAND);

has_tail = (_tail != noone);
if (has_tail)
{
	animation_add(BSS_ANIM.TAIL, _tail, 0, 0, true);
	tail_animator = new animator_create();
	animation_play(tail_animator, BSS_ANIM.TAIL);
}

//---- BSS_Setup_GetStartupInfo port ----
setup_start_info = function() {
	sphere_count = 0;
	pink_count   = 0;
	for (var gy = 0; gy < BSS_H; gy++)
	{
		for (var gx = 0; gx < BSS_W; gx++)
		{
			var p = (gx * 32) + gy;
			switch (global.bss.pf[p])
			{
				case BSS_CELL.BLUE:
				case BSS_CELL.GREEN: sphere_count++; break;
				case BSS_CELL.PINK:  pink_count++; break;
				case BSS_CELL.SPAWN_UP:    angle = 0x00; player_x = gx; player_y = gy; global.bss.pf[p] = BSS_CELL.NONE; break;
				case BSS_CELL.SPAWN_RIGHT: angle = 0x40; player_x = gx; player_y = gy; global.bss.pf[p] = BSS_CELL.NONE; break;
				case BSS_CELL.SPAWN_DOWN:  angle = 0x80; player_x = gx; player_y = gy; global.bss.pf[p] = BSS_CELL.NONE; break;
				case BSS_CELL.SPAWN_LEFT:  angle = 0xC0; player_x = gx; player_y = gy; global.bss.pf[p] = BSS_CELL.NONE; break;
			}
		}
	}
};

//---- BSS_Setup_CollectRing port ----
collect_ring = function() {
	rings_collected++;
	play_sound(sfx_ring);
	if (ring_count > 0)
	{
		ring_count--;
		if (ring_count == 0)
		{
			//BSS_Message PERFECT
			perfect_active = true;
			perfect_phase  = 0;
			perfect_offset = 320;
			perfect_wait   = 0;
			play_sound(sfx_event);
		}
	}
};

//---- BSS_Setup_SetupFinishSequence port ----
setup_finish = function() {
	for (var gy = 0; gy < BSS_H; gy++)
		for (var gx = 0; gx < BSS_W; gx++) global.bss.pf[(gx * 32) + gy] = BSS_CELL.NONE;

	var fx = ashr(sin256(angle), 5) + player_x;
	var fy = (player_y - ashr(cos256(angle), 5)) & 31;
	var fp = fy + (32 * (fx & 31));

	global.bss.pf[fp] = (ring_count > 0) ? BSS_CELL.MEDAL_SILVER : BSS_CELL.MEDAL_GOLD;
};

//---- BSS_Setup_HandleSteppedObjects port (runs every grounded frame) ----
stepped_objects = function() {
	if (globe_timer < 32)  disable_bumpers = false;
	if (globe_timer > 224) disable_bumpers = false;

	//current cell
	var fp = player_y + (32 * player_x);
	switch (global.bss.pf[fp])
	{
		case BSS_CELL.BLUE:
			if (globe_timer < 128)
			{
				global.bss.lastSX = player_x;
				global.bss.lastSY = player_y;
				sphere_count -= bss_process_chain();
				sphere_count--;
				if (!global.bss.loop)
				{
					array_push(collected, { ce : BSS_COLLECT.BLUE, cx : player_x, cy : player_y, t : 0 });
					global.bss.pf[fp] = BSS_CELL.BLUE_STOOD;
				}
				if (sphere_count <= 0)
				{
					sphere_count = 0;
					state = BSS_STATE.JETTISON;
					spin_timer = 0;
					play_sound(sfx_jettison);
					music_fade_channel(BGM, FADE_OUT, 1);
				} else {
					play_sound(sfx_blue_sphere);
				}
			}
			break;

		case BSS_CELL.RED:
			if (state != BSS_STATE.EXIT && globe_timer < 32)
			{
				state = BSS_STATE.EXIT;
				spin_timer = 0;
				globe_timer = 0;
				exit_result = "fail";
				play_sound(sfx_warp_exit);
				music_fade_channel(BGM, FADE_OUT, 1);
			}
			break;

		case BSS_CELL.BUMPER:
			if (!disable_bumpers && globe_timer < 112)
			{
				if (globe_timer > 16)
				{
					if (globe_speed < 0)
					{
						disable_bumpers = true;
						globe_speed = -globe_speed;
						player_was_bumped = false;
						play_sound(sfx_bumper);
					}
				}
				else if (spin_state == 0)
				{
					if (globe_speed < 0)
					{
						globe_timer = 16;
						disable_bumpers = true;
						globe_speed = -globe_speed;
						player_was_bumped = false;
						play_sound(sfx_bumper);
					}
				}
			}
			break;

		case BSS_CELL.YELLOW:
			if (globe_timer < 128)
			{
				velocity_y = -1572864; //-TO_FIXED(24)
				on_ground = false;
				animation_play(animator, BSS_ANIM.SPRING);
				globe_speed *= 2;
				spin_state = 0;
				globe_speed_inc = 4;
				play_sound(sfx_spring);
			}
			break;

		case BSS_CELL.GREEN:
			if (globe_timer > 128)
			{
				array_push(collected, { ce : BSS_COLLECT.GREEN, cx : player_x, cy : player_y, t : 0 });
				global.bss.pf[fp] = BSS_CELL.GREEN_STOOD;
				play_sound(sfx_blue_sphere);
			}
			break;

		case BSS_CELL.PINK:
			if (state != BSS_STATE.TELE_IN && globe_timer < 64)
			{
				state = BSS_STATE.TELE_IN;
				spin_timer = 0;
				globe_timer = 0;
				tele_timer = 0;
				play_sound(sfx_teleport);
				fade_change(FADE_OUT, 6, FADE_WHITE); //Mania FXFade white flash, via the project fade system
			}
			break;

		case BSS_CELL.RING:
			if (globe_timer < 128)
			{
				array_push(collected, { ce : BSS_COLLECT.RING, cx : player_x, cy : player_y, t : 0 });
				global.bss.pf[fp] = BSS_CELL.SPARKLE;
				global.bss.spark[fp] = 0;
				collect_ring();
			}
			break;
	}

	//cell ahead
	var posX = (player_x + ashr(sin256(angle), 8)) & 31;
	var posY = (player_y - ashr(cos256(angle), 8)) & 31;
	fp = posY + (32 * posX);

	switch (global.bss.pf[fp])
	{
		case BSS_CELL.BLUE:
			if (globe_timer > 128)
			{
				global.bss.lastSX = posX;
				global.bss.lastSY = posY;
				sphere_count -= bss_process_chain();
				sphere_count--;
				if (!global.bss.loop)
				{
					array_push(collected, { ce : BSS_COLLECT.BLUE, cx : posX, cy : posY, t : 0 });
					global.bss.pf[fp] = BSS_CELL.BLUE_STOOD;
				}
				if (sphere_count <= 0)
				{
					sphere_count = 0;
					state = BSS_STATE.JETTISON;
					spin_timer = 0;
					play_sound(sfx_jettison);
					music_fade_channel(BGM, FADE_OUT, 1);
				} else {
					play_sound(sfx_blue_sphere);
				}
			}
			break;

		case BSS_CELL.RED:
			if (state != BSS_STATE.EXIT && globe_timer > 224)
			{
				palette_page ^= 1;
				state = BSS_STATE.EXIT;
				spin_timer = 0;
				globe_timer = 0;
				player_x = (player_x + ashr(sin256(angle), 8)) & 31;
				player_y = (player_y - ashr(cos256(angle), 8)) & 31;
				exit_result = "fail";
				play_sound(sfx_warp_exit);
				music_fade_channel(BGM, FADE_OUT, 1);
			}
			break;

		case BSS_CELL.BUMPER:
			if (!disable_bumpers && globe_timer > 144)
			{
				if (globe_timer >= 240)
				{
					if (spin_state == 0)
					{
						if (globe_speed > 0)
						{
							globe_timer = 240;
							disable_bumpers = true;
							globe_speed = -globe_speed;
							player_was_bumped = true;
							play_sound(sfx_bumper);
						}
					}
				}
				else
				{
					if (globe_speed > 0)
					{
						disable_bumpers = true;
						globe_speed = -globe_speed;
						player_was_bumped = true;
						play_sound(sfx_bumper);
					}
				}
			}
			break;

		case BSS_CELL.YELLOW:
			if (globe_timer > 128)
			{
				velocity_y = -1572864;
				on_ground = false;
				animation_play(animator, BSS_ANIM.SPRING);
				globe_speed *= 2;
				spin_state = 0;
				globe_speed_inc = 4;
				play_sound(sfx_spring);
			}
			break;

		case BSS_CELL.GREEN:
			if (globe_timer > 128)
			{
				array_push(collected, { ce : BSS_COLLECT.GREEN, cx : posX, cy : posY, t : 0 });
				global.bss.pf[fp] = BSS_CELL.GREEN_STOOD;
				play_sound(sfx_blue_sphere);
			}
			break;

		case BSS_CELL.RING:
			if (globe_timer > 128)
			{
				array_push(collected, { ce : BSS_COLLECT.RING, cx : posX, cy : posY, t : 0 });
				global.bss.pf[fp] = BSS_CELL.SPARKLE;
				global.bss.spark[fp] = 0;
				collect_ring();
			}
			break;

		case BSS_CELL.EMERALD_CHAOS:
		case BSS_CELL.EMERALD_SUPER:
		case BSS_CELL.MEDAL_SILVER:
		case BSS_CELL.MEDAL_GOLD:
			if (globe_timer > 240)
			{
				exit_result = (global.bss.pf[fp] == BSS_CELL.MEDAL_GOLD) ? "gold" : "silver";
				palette_page ^= 1;
				state = BSS_STATE.EXIT;
				spin_timer = 0;
				globe_timer = 0;
				player_x = (player_x + ashr(sin256(angle), 8)) & 31;
				player_y = (player_y - ashr(cos256(angle), 8)) & 31;
				play_sound(sfx_warp_exit);
			}
			break;
	}
};

//---- BSS_Collected_Update port ----
update_collected = function() {
	for (var i = array_length(collected) - 1; i >= 0; i--)
	{
		var e = collected[i];
		var fp = e.cy + (32 * e.cx);
		var remove = false;

		switch (e.ce)
		{
			case BSS_COLLECT.RING:
				e.t++;
				global.bss.spark[fp] = e.t;
				if (e.t >= 16 && state == BSS_STATE.MOVE)
				{
					global.bss.pf[fp] = BSS_CELL.NONE;
					remove = true;
				}
				break;

			case BSS_COLLECT.BLUE:
				if (sphere_count <= 0)
				{
					if (global.bss.pf[fp] == BSS_CELL.BLUE_STOOD) global.bss.pf[fp] = BSS_CELL.RED;
					remove = true;
				}
				else if (globe_timer < 32 || globe_timer > 224) {
					e.ce = BSS_COLLECT.BLUE_STOOD;
				}
				break;

			case BSS_COLLECT.BLUE_STOOD:
				if (state == BSS_STATE.MOVE && globe_timer > 32 && globe_timer < 224)
				{
					if (global.bss.pf[fp] == BSS_CELL.BLUE_STOOD) global.bss.pf[fp] = BSS_CELL.RED;
					remove = true;
				}
				break;

			case BSS_COLLECT.GREEN:
				if (globe_timer < 32 || globe_timer > 224)
				{
					e.t = 10;
					e.ce = BSS_COLLECT.GREEN_STOOD;
				}
				break;

			case BSS_COLLECT.GREEN_STOOD:
				if (state == BSS_STATE.MOVE)
				{
					e.t--;
					if (e.t <= 0)
					{
						if (global.bss.pf[fp] == BSS_CELL.GREEN_STOOD) global.bss.pf[fp] = BSS_CELL.BLUE;
						remove = true;
					}
				}
				break;

			case BSS_COLLECT.PINK:
				if (state == BSS_STATE.MOVE)
				{
					if (player_x != e.cx || player_y != e.cy)
					{
						if (global.bss.pf[fp] == BSS_CELL.PINK_STOOD) global.bss.pf[fp] = BSS_CELL.PINK;
						remove = true;
					}
				}
				break;
		}

		if (remove) array_delete(collected, i, 1);
	}
};

bonus_stage_start = function() {
	global.bss.pf = [];
	array_copy(global.bss.pf, 0, global.bss.pf_stage, 0, 1024);

	angle    = 0;
	player_x = 0;
	player_y = 0;
	setup_start_info();

	ring_count      = ring_target;
	rings_collected = 0;

	state             = BSS_STATE.MOVE;
	globe_timer       = 0;
	globe_speed       = 0;
	globe_speed_inc   = 0;
	speedup_level     = 0;
	speedup_timer     = 0;
	speedup_interval  = 30 * 60;
	spin_state        = 0;
	spin_timer        = 0;
	palette_page      = 0;
	palette_line      = 0;
	player_was_bumped = false;
	disable_bumpers   = false;
	timer_100         = 0;
	tele_timer        = 0;
	globe_hidden      = false;
	turn_frame        = 0;
	turn_flip         = 0;
	exit_timer        = 0;
	medal_spin        = 0;
	bg_scroll_x       = 0;
	bg_scroll_y       = 0;

	for (var si = 0; si < 1024; si++) global.bss.spark[si] = 0;

	//player (BSS_Player entity)
	on_ground        = true;
	velocity_y       = 0;
	gravity_strength = 0;
	walk_timer       = 0;
	roll_timer       = 0;
	input_active     = true;
	animation_play(animator, BSS_ANIM.STAND);

	collected = [];

	//intro (BSS_Message GETSPHERES)
	msg_phase      = 0;   //0 = fade-in, 1 = wait, 2 = sliding out, 3 = gone
	msg_fade_timer = 512;
	msg_wait_timer = 0;
	intro_offset   = 0;   //slide-out offset once the globe starts

	//PERFECT message (BSS_Message)
	perfect_active = false;
	perfect_phase  = 0;
	perfect_offset = 320;
	perfect_wait   = 0;

	ring_spin = 0;
};

bonus_stage_start();
