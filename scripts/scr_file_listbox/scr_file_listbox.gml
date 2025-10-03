/// @function scr_file_listbox(x, y, list, visible_rows, row_width, row_height, scrollbar_id, title, draw_window)
/// @desc Draws a scrollable list of items and handles selection
/// @param {real} x             Left X position
/// @param {real} y             Top Y position
/// @param {ds_list} list       List of strings to display
/// @param {real} visible_rows  How many rows visible at once
/// @param {real} row_width     Width of each row
/// @param {real} row_height    Height of each row
/// @param {real} scrollbar_id  The scrollbar controlling this list
/// @param {string} title       Title text
/// @param {bool} draw_window   Draw a window background
///
/// @returns {struct|undefined} A struct { text, index } if clicked, otherwise undefined
function scr_file_listbox(x, y, list, visible_rows, row_width, row_height, scrollbar_id, title, draw_window) {
    
    var result = undefined;

    var first_index = get_scrollbarvalue(scrollbar_id); // where scrolling starts
    var mx = device_mouse_x_to_gui(0);
    var my = device_mouse_y_to_gui(0);

    // Draw optional window background
    if (draw_window) {
        scr_create_window(x - 8, y - 24, false);
    }

    // Draw title bar
    draw_set_color(c_black);
    draw_rectangle(x, y - row_height, x + row_width, y, false);
    draw_set_color(c_white);
    draw_text(x + 2, y - row_height + 2, title);

    // Background
    draw_set_color(make_color_rgb(109, 51, 13));
    draw_set_alpha(0.3);
    draw_rectangle(x, y, x + row_width, y + (visible_rows * row_height) - 1, false);
    draw_set_alpha(1);

    // Scrollbar
    scrollbar_draw_ext(scrollbar_id, x + row_width + 2, y, 10, visible_rows, ds_list_size(list));

    // Figure out hover row
    var hover_index = -1;
    if (point_in_rectangle(mx, my, x, y, x + row_width, y + visible_rows * row_height)) {
        hover_index = floor((my - y) / row_height);
    }

    // Draw items
    for (var i = 0; i < visible_rows; i++) {
        var index = first_index + i;
        if (index >= ds_list_size(list)) break;

        var item_text = ds_list_find_value(list, index);
        var row_y = y + i * row_height;

        // Hover highlight
        if (i == hover_index) {
            draw_set_color(c_yellow);
            draw_set_alpha(0.3);
            draw_rectangle(x, row_y, x + row_width, row_y + row_height, false);
            draw_set_alpha(1);

            if (mouse_check_button_pressed(mb_left)) {
                result = {
                    text: item_text,
                    index: index
                };
            }
        }

        draw_set_color(c_white);
        draw_text(x + 4, row_y + 2, item_text);
    }

    return result;
}