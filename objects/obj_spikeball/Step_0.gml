y_speed += grav

y += y_speed

player_spike_parry(x,y)

if player_collide_object() 
player_hurt()