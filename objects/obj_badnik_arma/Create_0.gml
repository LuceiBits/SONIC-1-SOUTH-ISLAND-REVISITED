// Inherit the parent event
event_inherited();



// ACTUAL BADNIK STATES


enum ARMA_STATE {
TUCKED,
VULNERABLE,
IDLE,
}

arma_attack = false
arma_attack_timer = 50
arma_state = ARMA_STATE.IDLE
inv_timer = 0
has_shell = true
idle_timer = 0
press_action = false



// FUCK SHIT SONIC CODE DUPLICATED


tails = noone
jump_lock = false
control_lock = 0
collision_allow = true;				// Flag used to allow solid collision or not
gravity_allow = true;				// Flag used to allow gravity on player
force_roll = false;					// Flag used to set the player into forced roll state, which is used for S-Tubes
input_disable = false;				// Flag used for disabling player input
hitbox_allow = true;				// Flag used for allowing hitbox collision between player and other objects
flag_override = true;				// This is used to prevent flags from being override in player state list script when false
disable_death = false;				// If true, disables the ability to die via pits or other means 
water_run = false;					// Flag used of player is water running
semi_solid_condition = false		// A condition flag used to see if semi solids can be collided with or not
speed_allow = true
speed_shoes_flag = false
underwater = false
character = CHAR_SONIC
super = false
state = player_state_roll;	
x_speed = 0
y_speed = 0
mode = COLLISION_MODE.FLOOR
x_dir = 0
y_dir = 0
ground_angle = 0
visual_angle = 0;					// Used for rotation of the player's sprite
direction_allow = true
player_animation_list();			//Initilize the animation list
// SONIC CREATE VALUE CLONE
x_speed = 0;						// Horizontal speed movement
y_speed = 0;						// Vertical speed movement
ground_speed = 0;					// Speed for ground movement
ground_angle = 0;					// Value for floor angle
mode = COLLISION_MODE.FLOOR;					// Floor mode value for ground movement
x_dir = 0;							// Multiplier for horizontal ground movement
y_dir = 1;							// Multiplier for vertical ground movement
steps = 1;							// Variable used for precise collision
ceiling_landing = 0;				// Ceiling landing state machine
plane = PLANE.A;					// Collision planes/layers
floor_delay = 0;					// Delay timer for when player changes floor mode, hacky fix for jittery mode changes
reach_range = 16;					// Range of how much angle sensors can go below floor checks
ceiling_lock = 0;					// Timer used for locking ceiling landing, hacky fix for collision bugs
facing = 1;							// Player's facing direction
movement_allow = true;		
shield_obj = SHIELD.NONE
shield = -1
//Physics values					   
x_accel = 0.046875;					// Value used for player's horizontal acceleration
x_deaccel = 0.5;					   
y_accel = 0.21875;					// Value used for player's vertical acceleration, specifically gravirt
friction_speed = 0.8;			// Value used for player's friction when input is not being held
top_speed = 6;						// Value used for player's top running speed
max_speed = 24;						// Player's horizontal speed cap
jump_strength = 6.5;				// Value used for player's jump strength 
jump_release = 4;					// Value used for speed when player releases the jump button
roll_friction = 0.0234375;			   
roll_influence_up = 0.078125;		// Value that influences rolling up slopes
roll_influence_down = 0.3125;		// Value that influences rolling down slopes
roll_speed_cap = 18;				// Value for rolling's maximum speed

ground = true;						// Check used to check if player is on ground or not
debug = false;						// Check if player is in debug mode or not
on_object = false;					// Check for if player is on object
last_on_object = on_object;
on_object_count = 0;
on_terrain = false;
touching_ceiling = false;			// Check if player is inside of a ceiling
skid_timer = 0

//Hitbox values:					   
hitbox_w = 9;						// Hitbox width variable
hitbox_h = 19;						// Hitbox height variable
wall_w = 10;						// Horizontal wall radius
wall_h = 0;							// Vertical wall radius

//Hitbox variables
hitbox_top_offset = 0;				// Hitbox offset of the top side
hitbox_left_offset = 0;				// Hitbox offset of the left side
hitbox_bottom_offset = 0;			// Hitbox offset of the bottom side
hitbox_right_offset = 0;			// Hitbox offset of the right side
	
//Normal hitbox unique to each character
hitbox_normal =
[
	[9, 19],	// Sonic's hitbox
	[9, 15],	// Tails' hitbox
	[9, 19]		// Knuckles' hitbox
]
	
//Rolling hitbox unique to each character
hitbox_rolling =
[
	[7, 14],	// Sonic's hitbox
	[7, 14],	// Tails' hitbox
	[7, 14]		// Knuckles' hitbox
]

collision_allow = true;				// Flag used to allow solid collision or not
gravity_allow = true;				// Flag used to allow gravity on player
force_roll = false;					// Flag used to set the player into forced roll state, which is used for S-Tubes
input_disable = false;				// Flag used for disabling player input
hitbox_allow = true;				// Flag used for allowing hitbox collision between player and other objects
flag_override = true;				// This is used to prevent flags from being override in player state list script when false
disable_death = false;				// If true, disables the ability to die via pits or other means 
water_run = false;					// Flag used of player is water running
semi_solid_condition = false		// A condition flag used to see if semi solids can be collided with or not
speed_allow = true;



arma_animator = new animator_create();

animation_add(0,spr_arma_idle,0,0,true)
animation_add(1,spr_arma_roll,0.2,0,true,true)
animation_add(2,spr_arma_idle_no_shell,0,0,true)
animation_add(3,spr_arma_roll_no_shell,0.2,0,true,true)
animation_play(arma_animator,0,true)

	//animator = new animator_create();
	
	//		animation_add(ANIM.STAND, spr_sonic_idle, 0.2)
	//		animation_add(ANIM.WAIT, spr_sonic_wait, 5, 0, false, true);
	//		animation_add(ANIM.WALK, spr_sonic_walk, 3, 0, true, true);
	//		animation_add(ANIM.WALKWATER, spr_sonic_walk_water, 3, 0, true, true);
	//		animation_add(ANIM.RUN, spr_sonic_run, 2, 0, true, true);
	//		animation_add(ANIM.MAXRUN, spr_sonic_peelout, 0, 0, true, true);
	//		animation_add(ANIM.LOOKDOWN, spr_sonic_lookdown, 0.4, 0, false, false);
	//		animation_add(ANIM.LOOKUP, spr_sonic_lookup, 0.4, 0, false, false);
	//		animation_add(ANIM.PUSH, spr_sonic_push, 0.1, 0, true, false);
	//		animation_add(ANIM.ROLL, spr_sonic_roll, 0, 0, true, true);
	//		animation_add(ANIM.SPINDASH, spr_sonic_spindash, 0.6, 0, true, false);
	//		animation_add(ANIM.SPRING, spr_sonic_spring, 0.4, 0, true, false);
	//		animation_add(ANIM.SKID, spr_sonic_skid, 0.4, 0, false, false);
	//		animation_add(ANIM.SKIDTURN, spr_sonic_skidturn, 0.3, 0, false, false);
	//		animation_add(ANIM.HURT, spr_sonic_hurt, 0.3, 0, false, false);
	//		animation_add(ANIM.DIE, spr_sonic_death, 0.3, 0, false, false);
	//		animation_add(ANIM.DROWN, spr_sonic_drown, 0.3, 0, false, false);
	//		animation_add(ANIM.BREATHE, spr_sonic_breathe, 16, 0, false, true);
	//		animation_add(ANIM.LEDGE1, spr_sonic_ledge1, 0.1, 0, true, false);
	//		animation_add(ANIM.LEDGE2, spr_sonic_ledge2, 0.1, 0, true, false);
	//		animation_add(ANIM.VICTORY, spr_sonic_victory, 0.1, 1, true, false);
	//		animation_add(ANIM.TRANSFORM, spr_sonic_transform, 0.4, 3, true, false);
	//		animation_add(ANIM.CORKSCREW, spr_sonic_corkscrew, 0.2, 0, true, false);
	//		animation_add(ANIM.DROPDASH, spr_sonic_dropdash, 0.5, 1, true, false);
	//		animation_add(ANIM.POLESWING, spr_sonic_poleswing, 0.2, 0, true, true);
	//		animation_add(ANIM.WATER_TUNNEL, spr_sonic_tunnel, 4, 0, true, true);
	//animation_play(animator, 0, true);
	
	player_get_input();					//Setup player inputs
	
	on_reset = function()
	{
		if arma_state != ARMA_STATE.TUCKED
		{
		animation_play(arma_animator, 0, true);
		x_speed = 0;
		y_speed = 0;
		ground = true
		ground_angle = 0
		on_terrain = false
		touching_ceiling = false;
		plane = PLANE.A;
		mode = COLLISION_MODE.FLOOR
		x = xstart;
		y = ystart;
		visual_angle = 0;	
		arma_state = ARMA_STATE.IDLE
		has_shell = true
		}
		// Used for rotation of the player's sprite
	}
	
if start_rolling = true
{
arma_state = ARMA_STATE.TUCKED
animation_play(arma_animator,1,true)
}
	
instance_register_culling([-32, -32, 32, 32], on_reset, CULL_FLAG.CHECK_ENTITY_START | CULL_FLAG.CHECK_ENTITY_POS);
