decay_timer -= 1
if decay_timer = 0 || !place_meeting(x,y,obj_water_current) || y < obj_water.y || !instance_on_screen()
instance_destroy()

x += x_speed
y += y_speed