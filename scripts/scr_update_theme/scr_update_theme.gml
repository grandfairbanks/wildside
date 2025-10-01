
function scr_update_theme() {
	
	var eds=obj_system.ent_display_surface
	var tds=obj_system.tile_theme_surface
	
	if surface_exists(eds)
	surface_free(eds);
	if surface_exists(tds)
	surface_free(tds);
	
	switch(level_theme)
		{
		default:
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
		
	tilemap_tileset(terrain_back_layer,tileset);
	tilemap_tileset(terrain_front_layer,tileset);
	
	return tileset;


}
