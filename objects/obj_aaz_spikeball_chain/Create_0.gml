
// Setup
if(instance_exists(obj_player)) 
	if(layer == obj_player.layer) depth = obj_player.depth + 1;
		
angle = 0;
chain_amt = (sprite_height div 16) - 2;
parryTimer = 0
	
	
// Register the object for culling
instance_register_culling([-chain_amt * 16 - 24, -chain_amt * 16 - 24, chain_amt * 16 + 24, chain_amt * 16 + 24]);

// GMS scaling sucks ass
y += 8;
ystart = y;
image_yscale = 1;