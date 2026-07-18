	// Draw chain
	for (var i = 0; i <= chain_amt; ++i)
	{
	    draw_sprite(i == chain_amt ? spr_aaz_spikeball : spr_aaz_spikeball_chains, max(1-i, 0),
		x + cos_angle * (i*16), y + sin_angle * (i*16));
	}