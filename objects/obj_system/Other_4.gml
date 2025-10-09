if (reSize) {
    // resume resize logic
    resize_room(); // this will handle restore
	show_debug_message("ROOM WIDTH: " + string(level_x*SCREEN_WIDTH))
	show_debug_message("ROOM HEIGHT: " + string(level_y*SCREEN_HEIGHT))
} else if (load == 1) {
    // normal fresh level load
    load_level(filename);
}

//turn on views
view_enabled=true;
//make view visible
view_visible[0]=true;