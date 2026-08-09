if sprite_index = spr_pike_retract || sprite_index = spr_pike_idle_retracted 
{
sprite_index = spr_pike_idle_retracted 
show_debug_message("IDLE RETRACTED")
}
if sprite_index = spr_pike_extend || sprite_index = spr_pike_idle_extended
{
sprite_index = spr_pike_idle_extended
show_debug_message("IDLE EXTENSION")
}

