// Blue Spheres engine, accurate port of Sonic Mania's BSS_Setup / BSS_Player / BSS_Collectable / BSS_Collected.

#macro BSS_W 32
#macro BSS_H 32

// Cell values
#macro C_NONE          0
#macro C_BLUE          1
#macro C_RED           2
#macro C_BUMPER        3
#macro C_YELLOW        4
#macro C_GREEN         5
#macro C_PINK          6
#macro C_RING          7
#macro C_SPAWN_UP      8
#macro C_SPAWN_RIGHT   9
#macro C_SPAWN_DOWN    10
#macro C_SPAWN_LEFT    11
#macro C_SPARKLE       15
#macro C_EMERALD_CHAOS 16
#macro C_EMERALD_SUPER 17
#macro C_MEDAL_SILVER  18
#macro C_MEDAL_GOLD    19
#macro C_GREEN_STOOD   0x81
#macro C_BLUE_STOOD    0x82
#macro C_PINK_STOOD    0x86

// Setup states
#macro BS_MOVE     0
#macro BS_TURNL    1
#macro BS_TURNR    2
#macro BS_TELE_IN  3
#macro BS_TELE_OUT 4
#macro BS_JETTISON 5
#macro BS_EMERALD  6
#macro BS_EXIT     7

// Collected-event types
#macro CE_RING        0
#macro CE_BLUE        1
#macro CE_BLUE_STOOD  2
#macro CE_GREEN       3
#macro CE_GREEN_STOOD 4
#macro CE_PINK        5

// Player anims
#macro ANIM_BSS_STAND  0
#macro ANIM_BSS_WALK   1
#macro ANIM_BSS_JUMP   2
#macro ANIM_BSS_SPRING 3
#macro ANIM_BSS_TAIL   4

function bss_idx(_x, _y) {
	return (((_x & 31) << 5) + (_y & 31));
}

// BSS_Message two-part message
function draw_bss_message(_spr, _cx, _cy, _offset) {
	var fw = sprite_get_width(_spr);
	var fh = sprite_get_height(_spr);
	draw_sprite(_spr, 0, _cx - _offset - fw, _cy - (fh div 2));
	draw_sprite(_spr, 1, _cx + _offset,      _cy - (fh div 2));
}

// BSS_HUD_DrawNumbers
function draw_bss_number(_value, _right_x, _y) {
	var s = string(_value mod 1000);
	s = string_repeat("0", max(0, 3 - string_length(s))) + s;
	draw_set_font(global.bss_number);
	draw_set_halign(fa_right);
	draw_set_valign(fa_top);
	draw_text(_right_x, _y, s);
	draw_set_halign(fa_left);
}

// Build global.bss.pf_stage from the room's "Playfield" tilemap (mirrors Mania's BSS_Setup_StageLoad,
// which reads the playfield from a tile layer). Tile index == cell value; index 0 = C_NONE.
function bss_load_playfield() {
	global.bss.pf_stage = array_create(1024, C_NONE);

	var lay = layer_get_id("Playfield");
	if (lay == -1) return;

	var tm = layer_tilemap_get_id(lay);
	var spawns = 0;
	for (var gx = 0; gx < BSS_W; gx++)
	{
		for (var gy = 0; gy < BSS_H; gy++)
		{
			var t = tile_get_index(tilemap_get(tm, gx, gy)); //== Mania's tile & 0x3FF
			if (t > 24) t = C_NONE;
			global.bss.pf_stage[gx * 32 + gy] = t;
			if (t >= C_SPAWN_UP && t <= C_SPAWN_LEFT) spawns++;
		}
	}

	//editor-only markers, hidden in-game
	layer_set_visible(lay, false);

	if (spawns != 1)
		show_debug_message("BSS Playfield: expected exactly 1 spawn tile, found " + string(spawns));
}

// Arithmetic (floor) right shift, matching C's signed >> on negatives
function ashr(_v, _n) {
	return floor(_v / (1 << _n));
}

// Lookup tables copied verbatim from Mania's BSS_Setup.h / BSS_Collectable.h
function bss_build_tables() {
	global.bss.screenYTable = [
		280, 270, 260, 251, 243, 235, 228, 221, 215, 208, 202, 197, 191, 185, 180, 175, 170, 165, 160, 155, 151, 147, 143,
		139, 135, 131, 127, 124, 121, 117, 114, 111, 108, 105, 103, 100, 97,  95,  92,  90,  88,  86,  83,  81,  79,  77,
		76,  74,  72,  70,  69,  67,  66,  64,  63,  62,  60,  59,  58,  57,  56,  55,  54,  53,  52,  51,  50,  49,  48,
		47,  47,  46,  45,  45,  44,  44,  43,  43,  42,  42,  41,  40,  40,  40,  40,  40,  40,  40,  40,  39,  39,  39,
		39,  39,  38,  38,  38,  38,  38,  38,  38,  38,  38,  38,  38,  38,  38,  38,  38,  38,  38,  38
	];

	global.bss.divisorTable = [
		4096, 4032, 3968, 3904, 3840, 3776, 3712, 3648, 3584, 3520, 3456, 3392, 3328, 3264, 3200, 3136, 3072, 2995, 2920, 2847, 2775, 2706, 2639,
		2572, 2508, 2446, 2384, 2324, 2266, 2210, 2154, 2100, 2048, 2012, 1976, 1940, 1906, 1872, 1838, 1806, 1774, 1742, 1711, 1680, 1650, 1621,
		1592, 1564, 1536, 1509, 1482, 1455, 1429, 1404, 1379, 1354, 1330, 1307, 1283, 1260, 1238, 1216, 1194, 1173, 1152, 1134, 1116, 1099, 1082,
		1065, 1048, 1032, 1016, 1000, 985,  969,  954,  939,  925,  910,  896,  892,  888,  884,  880,  875,  871,  867,  863,  859,  855,  851,
		848,  844,  840,  836,  832,  830,  828,  826,  824,  822,  820,  818,  816,  814,  812,  810,  808,  806,  804,  802
	];

	global.bss.xMultiplierTable = [
		134, 131, 128, 125, 123, 121, 119, 117, 115, 114, 112, 111, 109, 108, 106, 104, 104, 102, 100, 98, 97, 96, 94, 93, 92, 90, 89, 88,
		86,  84,  83,  82,  80,  80,  79,  78,  77,  76,  74,  73,  72,  71,  70,  70,  68,  68,  67,  66, 65, 64, 63, 62, 61, 60, 60, 59,
		58,  57,  57,  56,  55,  54,  53,  53,  52,  51,  51,  50,  50,  49,  48,  48,  47,  47,  46,  46, 45, 45, 44, 44, 44, 43, 43, 43,
		42,  42,  42,  41,  41,  41,  41,  40,  40,  40,  40,  39,  39,  39,  39,  39,  38,  38,  38,  38, 38, 37, 37, 37, 37, 37, 36, 36
	];

	global.bss.frameTable = [
		31, 31, 31, 31, 31, 31, 31, 30, 30, 30, 30, 30, 30, 29, 29, 29, 29, 29, 28, 28, 28, 28, 27, 27, 27, 26, 26, 26, 26, 25, 25, 25,
		24, 24, 24, 24, 23, 23, 23, 23, 22, 22, 22, 22, 21, 21, 21, 21, 20, 20, 20, 20, 19, 19, 19, 19, 18, 18, 18, 18, 17, 17, 17, 17,
		16, 16, 16, 15, 15, 14, 14, 14, 13, 13, 13, 12, 12, 12, 11, 11, 10, 10, 10, 10, 9,  9,  9,  9,  8,  8,  8,  8,  7,  7,  7,  7,
		6,  6,  6,  6,  5,  5,  5,  5,  4,  4,  3,  3,  2,  2,  1,  1,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
	];

	global.bss.globeFrameTable = [0, 1, 2, 3, 4, 5, 6, 7, 6, 5, 4, 3, 2, 1, 0];
	global.bss.globeDirTableL  = [0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1];
	global.bss.globeDirTableR  = [1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0];

	// BSS_Collectable ring/medal scale tables + the BSS_Collectable_StageLoad transform
	global.bss.ringScaleX = [2, 4, 4, 4, 6, 6, 6, 7, 7, 8, 8, 9, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 22, 24, 26, 28, 30, 32, 32, 32];
	global.bss.ringScaleY = [2, 4, 4, 4, 6, 6, 6, 7, 7, 8, 8, 9, 9, 10, 11, 12, 13, 14, 15, 16, 16, 17, 17, 18, 18, 19, 19, 20, 21, 22, 23, 24];
	global.bss.medalScale = [4, 4, 5, 5, 6, 6, 7, 7, 8, 10, 12, 14, 16, 18, 20, 22, 24, 25, 26, 27, 28, 29, 30, 31, 32, 32, 32, 32, 32, 32, 32, 32];
	global.bss.ringScreenY = array_create(32, 0);

	var did = 32;
	for (var i = 0; i < 32; i++)
	{
		global.bss.ringScaleX[i] *= 14;
		global.bss.ringScaleY[i] *= 14;
		global.bss.medalScale[i] *= 16;
		global.bss.ringScreenY[i] = did * (global.bss.ringScaleY[i] << 6);

		var sc  = i * (global.bss.ringScaleY[i] - global.bss.ringScaleX[i]);
		var scX = global.bss.ringScaleX[i];
		global.bss.ringScaleY[i] = scX + ashr(sc, 5);

		did--;
	}
}

// Blue sphere -> ring enclosure (BSS_Setup_ProcessChain family), masks verbatim
function bss_check_sphere_valid(_x, _y) {
	var pf = global.bss.pf;
	var x1 = 32 * ((_x - 1) & 31);
	var y1 = (_y - 1) & 31;
	var x2 = 32 * ((_x + 1) & 31);
	var y2 = (_y + 1) & 31;

	if ((pf[x1 + y1] & 0x7F) == C_BLUE) return true;
	if ((pf[x2 + y1] & 0x7F) == C_BLUE || (pf[x1 + _y] & 0x7F) == C_BLUE || (pf[x2 + _y] & 0x7F) == C_BLUE) return true;
	if ((pf[x1 + y2] & 0x7F) != C_BLUE && (pf[x2 + y2] & 0x7F) != C_BLUE
		&& (pf[(32 * _x) + y1] & 0x7F) != C_BLUE && (pf[(32 * _x) + y2] & 0x7F) != C_BLUE) return false;
	return true;
}

function bss_scan_up(_x, _y) {
	if (global.bss.loop) return true;
	var pf = global.bss.pf;
	var px = 32 * _x;
	var cid = 0;
	while (true)
	{
		_y = (_y - 1) & 31;
		if ((pf[px + _y] & 0x7F) != C_RED) break;
		if ((global.bss.chain[px + _y] & 0x7F) == C_BLUE) break;
		if (!bss_check_sphere_valid(_x, _y)) break;
		global.bss.chain[_y + px] = C_BLUE;
		global.bss.coll[_y + px] = C_BLUE;
		if (_x == global.bss.lastSX && _y == global.bss.lastSY) { global.bss.loop = true; return true; }
		var found = false;
		if ((pf[_y + (32 * ((_x + 1) & 31))] & 0x7F) == C_RED) found = bss_scan_right(_x, _y) || found;
		if ((pf[_y + (32 * ((_x - 1) & 31))] & 0x7F) == C_RED) found = bss_scan_left(_x, _y) || found;
		if (!found) cid++; else cid = 0;
		if (global.bss.loop) return true;
	}
	for (var i = cid; i > 0; i--) { _y = (_y + 1) & 31; global.bss.coll[px + _y] = C_NONE; }
	return false;
}

function bss_scan_down(_x, _y) {
	if (global.bss.loop) return true;
	var pf = global.bss.pf;
	var px = 32 * _x;
	var cid = 0;
	while (true)
	{
		_y = (_y + 1) & 31;
		if ((pf[px + _y] & 0x7F) != C_RED) break;
		if (global.bss.chain[px + _y] == C_BLUE) break;
		if (!bss_check_sphere_valid(_x, _y)) break;
		global.bss.chain[_y + px] = C_BLUE;
		global.bss.coll[_y + px] = C_BLUE;
		if (_x == global.bss.lastSX && _y == global.bss.lastSY) { global.bss.loop = true; return true; }
		var found = false;
		if ((pf[_y + (32 * ((_x - 1) & 31))] & 0x7F) == C_RED) found = bss_scan_left(_x, _y) || found;
		if ((pf[_y + (32 * ((_x + 1) & 31))] & 0x7F) == C_RED) found = bss_scan_right(_x, _y) || found;
		if (!found) cid++; else cid = 0;
		if (global.bss.loop) return true;
	}
	for (var i = cid; i > 0; i--) { _y = (_y - 1) & 31; global.bss.coll[px + _y] = C_NONE; }
	return false;
}

function bss_scan_left(_x, _y) {
	if (global.bss.loop) return true;
	var pf = global.bss.pf;
	var cid = 0;
	while (true)
	{
		_x = (_x - 1) & 31;
		var px = 32 * _x;
		if ((pf[px + _y] & 0x7F) != C_RED) break;
		if ((global.bss.chain[px + _y] & 0x7F) == C_BLUE) break;
		if (!bss_check_sphere_valid(_x, _y)) break;
		global.bss.chain[_y + px] = C_BLUE;
		global.bss.coll[_y + px] = C_BLUE;
		if (_x == global.bss.lastSX && _y == global.bss.lastSY) { global.bss.loop = true; return true; }
		var found = false;
		if ((pf[(32 * _x) + ((_y - 1) & 31)] & 0x7F) == C_RED) found = bss_scan_up(_x, _y) || found;
		if ((pf[(32 * _x) + ((_y + 1) & 31)] & 0x7F) == C_RED) found = bss_scan_down(_x, _y) || found;
		if (!found) cid++; else cid = 0;
		if (global.bss.loop) return true;
	}
	for (var i = cid; i > 0; i--) { _x = (_x + 1) & 31; global.bss.coll[(32 * _x) + _y] = C_NONE; }
	return false;
}

function bss_scan_right(_x, _y) {
	if (global.bss.loop) return true;
	var pf = global.bss.pf;
	var cid = 0;
	while (true)
	{
		_x = (_x + 1) & 31;
		var px = 32 * _x;
		if ((pf[px + _y] & 0x7F) != C_RED) break;
		if ((global.bss.chain[px + _y] & 0x7F) == C_BLUE) break;
		if (!bss_check_sphere_valid(_x, _y)) break;
		global.bss.chain[_y + px] = C_BLUE;
		global.bss.coll[_y + px] = C_BLUE;
		if (_x == global.bss.lastSX && _y == global.bss.lastSY) { global.bss.loop = true; return true; }
		var found = false;
		if ((pf[(32 * _x) + ((_y + 1) & 31)] & 0x7F) == C_RED) found = bss_scan_down(_x, _y) || found;
		if ((pf[(32 * _x) + ((_y - 1) & 31)] & 0x7F) == C_RED) found = bss_scan_up(_x, _y) || found;
		if (!found) cid++; else cid = 0;
		if (global.bss.loop) return true;
	}
	for (var i = cid; i > 0; i--) { _x = (_x - 1) & 31; global.bss.coll[(32 * _x) + _y] = C_NONE; }
	return false;
}

function bss_chained_count(_x, _y) {
	var pf = global.bss.pf;
	var px = 32 * _x;

	var y1 = (_y - 1) & 31;
	for (var i = 0; i < BSS_H; i++)
	{
		if (global.bss.coll[px + y1] == C_BLUE) break;
		var t = pf[px + y1] & 0x7F;
		if (t == C_NONE || t == C_RED) return false;
		y1 = (y1 - 1) & 31;
	}
	y1 = (_y + 1) & 31;
	for (var i = 0; i < BSS_H; i++)
	{
		if (global.bss.coll[px + y1] == C_BLUE) break;
		var t = pf[px + y1] & 0x7F;
		if (t == C_NONE || t == C_RED) return false;
		y1 = (y1 + 1) & 31;
	}
	var x1 = (_x - 1) & 31;
	for (var i = 0; i < BSS_W; i++)
	{
		if (global.bss.coll[_y + (32 * x1)] == C_BLUE) break;
		var t = pf[_y + (32 * x1)] & 0x7F;
		if (t == C_NONE || t == C_RED) return false;
		x1 = (x1 - 1) & 31;
	}
	x1 = (_x + 1) & 31;
	for (var i = 0; i < BSS_W; i++)
	{
		if (global.bss.coll[_y + (32 * x1)] == C_BLUE) break;
		var t = pf[_y + (32 * x1)] & 0x7F;
		if (t == C_NONE || t == C_RED) return false;
		x1 = (x1 + 1) & 31;
	}

	global.bss.coll[px + _y] = C_BLUE;
	return true;
}

// Runs when a blue sphere is collected. Sets global.bss.loop, converts enclosed cells to rings.
// Returns spheres converted (caller subtracts from sphere count)
function bss_process_chain() {
	for (var i = 0; i < 1024; i++) { global.bss.chain[i] = C_NONE; global.bss.coll[i] = C_NONE; }

	var lp = bss_idx(global.bss.lastSX, global.bss.lastSY);
	global.bss.pf[lp] = C_RED;
	global.bss.coll[lp] = C_BLUE;

	global.bss.loop = false;
	bss_scan_up(global.bss.lastSX, global.bss.lastSY);
	bss_scan_down(global.bss.lastSX, global.bss.lastSY);
	bss_scan_left(global.bss.lastSX, global.bss.lastSY);
	bss_scan_right(global.bss.lastSX, global.bss.lastSY);

	global.bss.pf[lp] = C_BLUE;

	if (!global.bss.loop) return 0;

	var collected = 0;
	for (var gy = 0; gy < BSS_H; gy++)
	{
		for (var gx = 0; gx < BSS_W; gx++) {
			if ((global.bss.pf[(gx * 32) + gy] & 0x7F) == C_BLUE) collected += bss_chained_count(gx, gy) ? 1 : 0;
		}
	}
	if (collected <= 0) { global.bss.loop = false; return 0; }

	// Trim cells not actually enclosed ("the hell pit")
	for (var gy = 0; gy < BSS_H; gy++)
	{
		for (var gx = 0; gx < BSS_W; gx++)
		{
			var p = gx * 32;
			var y1 = (gy - 1) & 31;
			var y2 = (gy + 1) & 31;
			var x1 = 32 * ((gx - 1) & 31);
			var x2 = 32 * ((gx + 1) & 31);
			if (global.bss.coll[p + gy] == C_BLUE)
			{
				if ((global.bss.pf[p + y1] & 0x7F) != C_BLUE && (global.bss.pf[p + y2] & 0x7F) != C_BLUE && (global.bss.pf[x1 + gy] & 0x7F) != C_BLUE)
				{
					if ((global.bss.pf[x2 + gy] & 0x7F) != C_BLUE && (global.bss.pf[x1 + y1] & 0x7F) != C_BLUE
						&& (global.bss.pf[x2 + y1] & 0x7F) != C_BLUE && (global.bss.pf[x1 + y2] & 0x7F) != C_BLUE) {
						if ((global.bss.pf[x2 + y2] & 0x7F) != C_BLUE) global.bss.coll[(gx * 32) + gy] = C_NONE;
					}
				}
			}
		}
	}

	for (var gy = 0; gy < BSS_H; gy++)
	{
		for (var gx = 0; gx < BSS_W; gx++) {
			if (global.bss.coll[(gx * 32) + gy] != C_NONE) global.bss.pf[(gx * 32) + gy] = C_RING;
		}
	}

	// Play ringloss sound
	play_sound(sfx_ringloss);
	return collected;
}

// Draw one projected cell at screen (_x,_y), scale frame _f (0..31, 31 = closest).
// Sphere/bumper subimages are pre-scaled, rings/medals scale a full-size sprite
function draw_bss_cell(_t, _x, _y, _f, _spin, _medal, _spark) {
	switch (_t)
	{
		case C_BLUE:   draw_sprite(spr_bss_sphere_blue,   _f div 2, _x, _y); break;
		case C_RED:    draw_sprite(spr_bss_sphere_red,    _f div 2, _x, _y); break;
		case C_BUMPER: draw_sprite(spr_bss_bumper,        _f div 2, _x, _y); break;
		case C_YELLOW: draw_sprite(spr_bss_sphere_yellow, _f div 2, _x, _y); break;
		case C_GREEN:  draw_sprite(spr_bss_sphere_green,  _f div 2, _x, _y); break;
		case C_PINK:   draw_sprite(spr_bss_sphere_pink,   _f div 2, _x, _y); break;

		case C_RING:
			var spin = floor(_spin) mod sprite_get_number(spr_bss_ring);
			draw_sprite_ext(spr_bss_ring, spin,
				_x, _y - (global.bss.ringScreenY[_f] / 65536),
				global.bss.ringScaleX[_f] / 512, global.bss.ringScaleY[_f] / 512, 0, c_white, 1);
			break;

		case C_MEDAL_SILVER:
		case C_MEDAL_GOLD:
			var ms = global.bss.medalScale[_f] / 512;
			var mspr = (_t == C_MEDAL_GOLD) ? spr_bss_medal_gold : spr_bss_medal_silver;
			draw_sprite_ext(mspr, _medal mod sprite_get_number(mspr),
				_x, _y - (global.bss.ringScreenY[_f] / 65536), ms, ms, 0, c_white, 1);
			break;

		case C_BLUE_STOOD:  draw_sprite_ext(spr_bss_sphere_blue,  _f div 2, _x, _y, 1, 1, 0, c_white, 0.5); break;
		case C_GREEN_STOOD: draw_sprite_ext(spr_bss_sphere_green, _f div 2, _x, _y, 1, 1, 0, c_white, 0.5); break;
		case C_PINK_STOOD:  draw_sprite_ext(spr_bss_sphere_pink,  _f div 2, _x, _y, 1, 1, 0, c_white, 0.5); break;

		case C_SPARKLE: draw_sprite(spr_bss_ring_sparkle, _spark, _x, _y); break;
		default: break;
	}
}
