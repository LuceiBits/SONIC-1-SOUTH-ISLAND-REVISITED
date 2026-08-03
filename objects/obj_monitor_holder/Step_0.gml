if !in_camera()
	exit


monitorID = instance_place(x,y,obj_monitor)

var _monitorTouched = false
if instance_exists(monitorID)
	_monitorTouched = monitorID.touched

if (
		!instance_exists(monitorID) || 
		monitorID = noone ||
		_monitorTouched
	) && !crumbling
{
	alarm[0] = 1
	crumbling = true
}

if instance_exists(monitorID)
	depth = monitorID.depth + 1