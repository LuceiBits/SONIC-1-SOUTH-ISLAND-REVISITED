// Inherit the parent event
event_inherited();

extended = 0
toggle_timer = 100
parryTimer = 0


on_reset = function()
{
toggle_timer = 100
extended = 0
}

instance_register_culling([-32, -32, 32, 32], on_reset, CULL_FLAG.CHECK_ENTITY_START | CULL_FLAG.CHECK_ENTITY_POS);