depth = obj_player.depth + 1
with instance_create_depth(x, y, obj_player.depth - 1, obj_blank)
{
	sprite_index = other.sprite_index
	image_index = 1
	image_xscale = other.image_xscale
}