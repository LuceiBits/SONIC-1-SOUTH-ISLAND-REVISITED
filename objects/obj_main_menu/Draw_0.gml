	// Draw the menu background
	// Affecting fonts lol
	draw_state_push();
	
	// Draw rotating gradient using vertices!
	draw_primitive_begin(pr_trianglestrip);
	var xs = dcos(timer);
	var ys = dsin(timer);
	
	var xo = WINDOW_WIDTH div 2;
	var yo = WINDOW_HEIGHT div 2;
	var ybuffer = WINDOW_WIDTH - yo + 128;
	
	var xtarget = [(-xo - 128), -xo, 0, xo, xo + 128];
	var ytarget = [-ybuffer, ybuffer];
	
	for (var i = 0; i < 10; ++i) {
		var xoff = xtarget[i div 2];
		var yoff = ytarget[i mod 2];
		
		var r, g, b;
		r = lerp(colour_get_red(colors_light[i div 2]), colour_get_red(colors_dark[i div 2]), different_bg_fade);
		g = lerp(colour_get_green(colors_light[i div 2]), colour_get_green(colors_dark[i div 2]), different_bg_fade);
		b = lerp(colour_get_blue(colors_light[i div 2]), colour_get_blue(colors_dark[i div 2]), different_bg_fade);
		var color_current = make_colour_rgb(r, g, b);
		
	    draw_vertex_colour(floor((ys * xoff) - (xs * yoff) + xo), floor((xs * xoff) + (ys * yoff) + xo), color_current, 1);
	}
	
	draw_primitive_end();
	
	// Draw the rest of the owl
	draw_set_color(#ff7700)
	draw_triangle(0, 0, 256, 0, 0, CAMERA_VIEW_H, false);
	draw_set_color(c_black)
	
	var fixY = CAMERA_VIEW_H - floor(bg_rect_y);
	
	draw_triangle(CAMERA_VIEW_W, floor(bg_rect_y), CAMERA_VIEW_W, floor(bg_rect_y) + 64, 0, floor(bg_rect_y), false);
	draw_triangle(0, fixY - 64, CAMERA_VIEW_W, fixY, 0, fixY, false);
	draw_rectangle(0, 0, CAMERA_VIEW_W, floor(bg_rect_y), false);
	draw_rectangle(0, CAMERA_VIEW_H, CAMERA_VIEW_W, fixY, false);
	draw_set_color(c_white)
	
	draw_set_font(global.font_titlecard);
	draw_set_halign(fa_left);
	draw_set_valign(fa_center);
	
	var trueY = (CAMERA_VIEW_H / 2) - cursor_y;
	
	draw_set_colour(c_black);
	draw_rectangle(0, trueY + 2, rect_x, trueY + 16 + 2, false);
	
	draw_set_colour(#e00000);
	draw_rectangle(0, trueY, rect_x, trueY + 16, false);
	
	draw_set_colour(c_white);
	
	for (var i = 0; i < array_length(selections); ++i) 
	{
		draw_set_colour(c_black);
		draw_text(32 + text_x[i], ((CAMERA_VIEW_H / 2) + 48 * (i - 1)) + text_y[i] + 2, selections[i])
		draw_set_colour(c_white);
		
		draw_text(32 + text_x[i], ((CAMERA_VIEW_H / 2) + 48 * (i - 1)) + text_y[i], selections[i])
	}
	
	draw_state_pop();