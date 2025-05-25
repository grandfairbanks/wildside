function scr_init_scrollbars(){
gml_pragma("global", "scr_init_scrollbars()");
//set up initial scrollbar variables
    global.___sbcount=0
    global.___sbtimer=0
    global.___sbdrag=-1
    global.___mxprev=mouse_x
    global.___myprev=mouse_y
    global.___sbcurrent=-1
}