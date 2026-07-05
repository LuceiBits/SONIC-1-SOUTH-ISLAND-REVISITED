function dust_effect(t = 0)
{
	//Setup the effect
	var obj = instance_create_depth(x, y, depth, obj_dust_effect, {sprite_index : other.sprite_index});
	obj.frm = image_index;
	obj.type = t;
	
	//Destroy the object
	instance_destroy();	
}