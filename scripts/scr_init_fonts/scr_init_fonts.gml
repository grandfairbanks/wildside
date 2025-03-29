function scr_init_fonts() {
	gml_pragma("global", "scr_init_fonts()");

	///SET SPRITE FONTS
	global.font=font_add_sprite(spr_font,ord("!"),true,1);
	draw_set_font(global.font)



}
