// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scrollbar_create(type,sprite,mousewheel){
/*
    CALL:           scrollbar_create(type,sprite,mousewheel)

    INFO:           Creates a new scrollbar and returns with the ID of it.

    ARGUMENTS:      type        =   0 if horizontal,
                                    1 if vertical.
                    sprite      =   The sprite of the scrollbar.
                    mousewheel  =   If you should be able to scroll with the mouse wheel.

    WRITTEN BY:     Davve

*/
var _type,_spr,_mw;
_type=type;
_spr=sprite;
_mw=mousewheel;

global.___sb[global.___sbcount,0]=_type
global.___sb[global.___sbcount,1]=0
global.___sb[global.___sbcount,2]=_spr
global.___sb[global.___sbcount,3]=_mw
global.___sbcount+=1

return global.___sbcount-1
}