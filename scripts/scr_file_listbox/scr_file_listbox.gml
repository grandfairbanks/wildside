/// @function scr_file_listbox(x, y, list, visible_rows, row_width, row_height, scrollbar_id, title)
/// @desc Draws a scrollable list of items with a title and scrollbar.
/// @returns {struct|undefined} A struct { text, index } if clicked, otherwise undefined.
function scr_file_listbox(xx, yy, list, visible_rows, row_width, row_height, scrollbar_id, title)
{
	
	if argument0=="CLEAR"
	selected_index
	
    // --- Persistent selected indices per list ---
    static selected_map = undefined;
    if (is_undefined(selected_map)) selected_map = ds_map_create();

    var list_id = string(scrollbar_id) + "_" + string(title); // unique key per list
    if (!ds_map_exists(selected_map, list_id)) selected_map[? list_id] = -1;
    var selected_index = selected_map[? list_id];

    var result = undefined;
    var total_items = ds_list_size(list);
    var first_index = get_scrollbarvalue(scrollbar_id); // topmost visible item
    var mx = device_mouse_x_to_gui(0);
    var my = device_mouse_y_to_gui(0);

    // --- Title bar ---
    var title_height = row_height;
    var strw = string_width(title);
    draw_set_color(c_black);
    draw_rectangle(xx, yy, xx + row_width, yy + title_height, false);
    draw_set_color(c_white);
    draw_text(xx + row_width/2 - strw/2, yy + 2, title);

    // --- List background ---
    var list_y_start = yy + title_height + 2;
    var list_area_height = visible_rows * row_height;
    draw_set_color(make_color_rgb(32, 32, 32));
    draw_rectangle(xx, list_y_start, xx + row_width - 1, list_y_start + list_area_height, false);

    // --- Scrollbar ---
    scrollbar_draw_ext(scrollbar_id, xx + row_width - 7, list_y_start, 10, visible_rows, total_items);

    // --- Calculate hover item index in list-space ---
    var hover_item_index = -1;
    if (point_in_rectangle(mx, my, xx, list_y_start, xx + row_width - 8, list_y_start + list_area_height)) {
        hover_item_index = first_index + floor((my - list_y_start) / row_height);
        if (hover_item_index >= total_items) hover_item_index = -1; // clamp
    }

    // --- Draw list items ---
    for (var i = 0; i < visible_rows; i++) {
        var index = first_index + i;
        if (index >= total_items) break;

        var item_text = ds_list_find_value(list, index);
        var row_y = list_y_start + i * row_height;

        var is_hovered = (index == hover_item_index);

        // --- Detect click ---
        if (mouse_check_button_pressed(mb_left) && is_hovered) {
            selected_index = index;
            selected_map[? list_id] = index;
            result = { text: item_text, index: index };
            show_debug_message(result);
        }

        // --- Set text color ---
        if (index == selected_index) {
            draw_set_color(c_yellow); // selected
        } else if (is_hovered) {
            draw_set_color(c_lime);   // hovered
        } else {
            draw_set_color(c_white);  // normal
        }

        draw_text(xx + 4, row_y + 2, item_text);
    }

    return result;
}
