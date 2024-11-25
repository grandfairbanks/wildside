var base_width = 320;
var base_height = 224;

var screen_width = display_get_width();
var screen_height = display_get_height();

var scale_x = screen_width / base_width;
var scale_y = screen_height / base_height;

var scale = min(scale_x, scale_y); // Use the smaller scale factor to fit screen

// Resize the application surface
surface_resize(application_surface, base_width * scale, base_height * scale);

// Center the game
var offset_x = (screen_width - (base_width * scale)) / 2;
var offset_y = (screen_height - (base_height * scale)) / 2;
camera_set_biew_position(offset_x, offset_y);