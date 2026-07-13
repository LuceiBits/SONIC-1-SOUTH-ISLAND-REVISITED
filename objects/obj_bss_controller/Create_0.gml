/// @description Blue Spheres controller

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

bss_special_stage_start();
