function game_macros()
{
	// Developer mode macro
	#macro DEVMODE false
	#macro Dev:DEVMODE true
	
	// Easy to access global variable macros
	#macro WINDOW_WIDTH global.window_width
	#macro WINDOW_HEIGHT global.window_height
	#macro FRAME_TIMER global.object_timer

	// Collision macros			[MAKE IT ENUM]
	#macro PLANE_A 0
	#macro PLANE_B 1
	
	// Collision side macros	[MAKE IT ENUM]
	#macro C_MAIN 0
	#macro C_BOTTOM 1
	#macro C_TOP 2
	#macro C_LEFT 3
	#macro C_RIGHT 4
	
	// Collision mode macros	[MAKE IT ENUM]
	#macro CMODE_FLOOR 0
	#macro CMODE_LWALL 1
	#macro CMODE_RWALL 3
	#macro CMODE_CEILING 2
	
	// Culling region size
	#macro CULL_REGION_W 128
	#macro CULL_REGION_H 128
}