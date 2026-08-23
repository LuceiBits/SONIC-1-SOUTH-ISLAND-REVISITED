
// Setup
if(instance_exists(obj_player)) 
	if(layer == obj_player.layer) depth = obj_player.depth + 1;
		
angle = 0;
chain_amt = (sprite_height div 16) - 2;
parryTimer = 0
	
	
// Register the object for culling
instance_register_culling([-chain_amt * 16 - 24, -chain_amt * 16 - 24, chain_amt * 16 + 24, chain_amt * 16 + 24]);

// GMS scaling sucks ass
if image_angle = 0
{
y += 8;
ystart = y;
image_yscale = 1;
}


if image_angle != 0 //bananabird math trickery KADABRA!
{
angle_offset = (256/360)*image_angle

if abs(image_angle) = 180
	{
	y -= 8;
	ystart = y;
	image_yscale = 1;
	}
	
	if image_angle = 90
	{
	x += 8;
	xstart = x;
	image_yscale = 1;
	}
	
		if image_angle = 270 
	{
	x -= 8;
	xstart = x;
	image_yscale = 1;
	}
	
	image_angle = 0
}