/// @description Randomized bridge segements

// Inherit the parent event
event_inherited();

// Randomized bridge segment example
for (var i = 0; i < bridge_size; ++i) {
	frame[i] = irandom(sprite_get_number(sprite_index));
}
