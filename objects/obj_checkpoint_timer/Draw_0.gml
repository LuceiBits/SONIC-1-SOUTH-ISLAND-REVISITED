//Set font numbers
draw_set_font(global.font_small);
draw_set_halign(fa_right);
draw_set_valign(fa_top);

//Draw number
draw_text(x, y, string(minute)+"'"+(sec > 9 ? "" : "0") + string(sec)+"'"+(milsec > 9 ? "" : "0") + string(milsec));