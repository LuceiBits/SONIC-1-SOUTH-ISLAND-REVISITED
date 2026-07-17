var player = player_find(0);

if(instance_place(x, y, player))
{
	if(!triggered)
	{
		if(script_to_execute != undefined) script_execute(script_to_execute);
		show_debug_message("Executed script " + string(script_to_execute));
	}
	triggered = true;
}
else if (!trigger_once)
{
	triggered = false;
}

