
function scr_update_theme() {
	switch(level_theme)
		{
		default:
		surface_free(ent_display_surface);
		case THEME.NULL: tileset=spr_null; break;
		case THEME.SKY: tileset=sky_tiles; break; 
		case THEME.ICE: tileset=crag_tiles; break; 
		case THEME.HILLS: tileset=isle_tiles; break; 
		case THEME.ISLAND: tileset=hills_tiles; break; 
		case THEME.DESERT: tileset=desert_tiles; break; 
		case THEME.SWAMP: tileset=marsh_tiles; break; 
		case THEME.MOUNTAIN: tileset=mountain_tiles; break; 
		case THEME.CAVE: tileset=cave_tiles; break; 
		case THEME.WOODS: tileset=woods_tiles; break; 
		case THEME.CITY: tileset=city_tiles; break; 
		}
		
	return tileset;


}
