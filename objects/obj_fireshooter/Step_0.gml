var col = player_act_solid();

if y > obj_water.bbox_top
	underwater = true
else
	underwater = false

if underwater
	sprite_index = spr_fire_shooter_inactive
else
	sprite_index = spr_fire_shooter_active

if fire_buffer <= 0 && !underwater
{
	with instance_create_bullet(spr_fire_shooter_projectile,0.35,x + (8 * image_xscale),y + 24,depth + 100,2 * image_xscale,0,0)
	{
		water_kill = true
		solid_kill = true
		image_xscale = other.image_xscale	
	}
	fire_buffer = 80
}

if fire_buffer > 0 && !underwater
	fire_buffer -= 1