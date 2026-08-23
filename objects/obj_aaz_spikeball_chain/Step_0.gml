
// Oscillate
angle = (((obj_level.platform_oscillate_timer * angle_speed) + angle_offset) % 256 + 256) % 256;
sin_angle = sin256(angle)/256;
cos_angle = cos256(angle)/256;


player_spike_parry(x + cos_angle * (chain_amt*16), y + sin_angle * (chain_amt*16))
	
// Hurt the player
var collide = instance_position_hitbox(x + cos_angle * (chain_amt*16), y + sin_angle * (chain_amt*16), [-8, -8, 8, 8]);
if(player_collide_object(collide))
{
	player_hurt();
}