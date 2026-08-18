// EVIL FUCKED UP MATH TO SET ORIGIN IF IT'S STRETCHED
var current_xscale = image_xscale
var width = 128
var target_xscale = 1
var target_x = x
show_debug_message(target_x)
var value_hold = 0

if image_xscale != 1
{
	
value_hold = (((abs(target_xscale - current_xscale) * width) / 2)) // divide by 2 to account for middle center
show_debug_message(value_hold)
target_x -= value_hold
show_debug_message(target_x)
}

sprite_index = spr_water_level_set
image_speed = 0
image_index = 0
image_xscale = 1

x = target_x
activated = false
depth = obj_player.depth + 200