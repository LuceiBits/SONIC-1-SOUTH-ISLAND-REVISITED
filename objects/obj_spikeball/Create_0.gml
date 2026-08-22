y_speed = 0
x_speed = 0
grav = 0.21875 * 1

on_reset = function()
{
x = xstart
y = ystart
x_speed = 0
y_speed = 0
}

instance_register_culling([-32, -32, 32, 32], on_reset, CULL_FLAG.CHECK_ENTITY_START | CULL_FLAG.CHECK_ENTITY_POS);