fire_buffer = 0
underwater = false

on_reset = function()
{
fire_buffer = 0
}

instance_register_culling([-64, -64, 64, 64], on_reset, CULL_FLAG.CHECK_ENTITY_START | CULL_FLAG.CHECK_ENTITY_POS);