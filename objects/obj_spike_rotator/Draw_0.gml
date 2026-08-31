live_auto_call

/*
	FUCKED UP COLLISIONS
	THE LOOP FUCKS SOMETHING UP???? IDK WHAT
	
	everything else is fine though
			-myke
*/

angle = obj_level.platform_oscillate_timer
sin_angle = sin256(angle)/256;
cos_angle = cos256(angle)/256;
var _length = abs(round(image_yscale))




for (var i = 0; i < _length; i++)
{
	var _lengthPos = i * 16
	var _x = x + lengthdir_x(_lengthPos, angle)
	var _yOffset = (bbox_bottom - y)
	var _y = y + lengthdir_y(_lengthPos, angle) + _yOffset
	
	draw_sprite(sprite_index, 0, _x, _y)
	
	player_spike_parry(_x,_y)
	
	if collision_point(_x,_y,obj_player,true,true)
	player_hurt();
	
	/*
	// Hurt the player
	var _hitbox = [-4, -4, 4, 4]
	
	var collide = instance_position_hitbox(_x, _y, _hitbox, id);
	
	draw_set_alpha(1)
	draw_rectangle(_x + _hitbox[0], _y + _hitbox[1], _x + _hitbox[2], _y + _hitbox[3], true)
	
	var _solid = player_act_solid(collide) //test
	*/
	/*
	if(player_collide_object(collide))
	{
		player_hurt();
	}*/
}

/*
global.rings = 10

if keyboard_check_pressed(ord("I"))
	y -= 16
if keyboard_check_pressed(ord("K"))
	y += 16
*/