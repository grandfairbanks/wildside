// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scrollbar_draw_ext(_id,_x,_y,size,slots,maxslots)
{
/*
    CALL:           scrollbar_draw_ext(id,x,y,slotw/h,slots,maxslots)

    INFO:           Draws the selected scrollbar. The value is measured in slots.

    ARGUMENTS:      id          =   The ID of the scrollbar to draw.
                    x           =   The x starting position of the scrollbar.
                    y           =   The y starting position of the scrollbar.
                    slotw/h     =   The width or height of a slot.
                    slots       =   The number of slots to show.
                    maxslots    =   The maximum number of slots.

    WRITTEN BY:     Davve

*/
var sb,xx,yy,swh,s,ms,wh,mwh,spr,sw,sh,sel,sel2,a,sp,ep,tp;
sb=_id
xx=_x
yy=_y
swh=size
s=slots
ms=maxslots
wh=s*swh
mwh=ms*swh
spr=global.___sb[sb,2]
sw=sprite_get_width(spr)/2
sh=sprite_get_height(spr)/2
tp=global.___sb[sb,0]

if (global.___sbcurrent=sb) 
    {
    global.___sbtimer=max(0,(global.___sbtimer-1)*mouse_check_button(mb_left))
    }

///draw scrollbar background
for (a=((xx+sw)*(tp=0))+((yy+sh)*(tp>0)); a<((xx+wh+sw)*(tp=0))+((yy+wh+sh)*(tp>0)); a+=2) 
    {
    draw_sprite_ext(spr,(15*(tp=0))+(19*(tp>0)),(a*(tp=0))+(xx*(tp>0)),(yy*(tp=0))+(a*(tp>0)),0.5,1,0,c_white,1)
    }
    
if (!mouse_check_button(mb_left) && global.___sbdrag>-1) 
    {
    global.___sbdrag=-1
    }
    
if (mwh>wh && wh>0) 
    {
    sp=(((xx+sw)*(tp=0))+((yy+sh)*(tp>0)))+(global.___sb[sb,1]*((s/ms)*swh))
    ep=sp+max((wh*(wh/mwh)),4)
    
    if (global.___sbdrag=sb && ((device_mouse_x_to_gui(0)*(tp=0))+(device_mouse_y_to_gui(0)*(tp>0)))>=((xx+sw)*(tp=0))+((yy+sh)*(tp>0)) && ((device_mouse_x_to_gui(0)*(tp=0))+(device_mouse_y_to_gui(0)*(tp>0)))<((xx+(sw*2)+wh)*(tp=0))+((yy+(sh*2)+wh)*(tp>0))) 
        {
        global.___sb[sb,1]+=((((device_mouse_x_to_gui(0)*(tp=0))+(device_mouse_y_to_gui(0)*(tp>0)))-((global.___mxprev*(tp=0))+(global.___myprev*(tp>0)))))/(wh/ms)
        global.___mxprev=device_mouse_x_to_gui(0)
        global.___myprev=device_mouse_y_to_gui(0)
        }
    
    if (global.___sbcurrent=sb && global.___sb[sb,3]>0) 
        {
        global.___sb[sb,1]+=((-1*mouse_wheel_up())+(1*mouse_wheel_down()))
        }
        
    sel=(global.___sbdrag=-1 && (device_mouse_x_to_gui(0)*(tp=0))+(device_mouse_y_to_gui(0)*(tp>0))>=((xx+sw)*(tp=0))+((yy+sh)*(tp>0)) && (device_mouse_x_to_gui(0)*(tp=0))+(device_mouse_y_to_gui(0)*(tp>0))<sp && mouse_check_button(mb_left) && (device_mouse_y_to_gui(0)*(tp=0))+(device_mouse_x_to_gui(0)*(tp>0))>(yy*(tp=0))+(xx*(tp>0)) && (device_mouse_y_to_gui(0)*(tp=0))+(device_mouse_x_to_gui(0)*(tp>0))<((yy+sh)*(tp=0))+((xx+sh)*(tp>0)))
    sel+=2*(global.___sbdrag=-1 && (device_mouse_x_to_gui(0)*(tp=0))+(device_mouse_y_to_gui(0)*(tp>0))>ep && (device_mouse_x_to_gui(0)*(tp=0))+(device_mouse_y_to_gui(0)*(tp>0))<((xx+sw+wh)*(tp=0))+((yy+sh+wh)*(tp>0)) && mouse_check_button(mb_left) && (device_mouse_y_to_gui(0)*(tp=0))+(device_mouse_x_to_gui(0)*(tp>0))>(yy*(tp=0))+(xx*(tp>0)) && (device_mouse_y_to_gui(0)*(tp=0))+(device_mouse_x_to_gui(0)*(tp>0))<((yy+sh)*(tp=0))+((xx+sh)*(tp>0)))
    
    if (sel>0 && global.___sbtimer=0) 
        {
        global.___sb[sb,1]+=(-1*(sel=1))+(1*(sel=2))
        global.___sb[sb,1]=max(0,min(ms-s,global.___sb[sb,1]))
        global.___sbtimer=ceil(fps/(15-(12*mouse_check_button_pressed(mb_left))))
        global.___sbcurrent=sb
        }
    
    global.___sb[sb,1]=min(ms-s,max(0,global.___sb[sb,1]))
    
    if (global.___sbdrag<>sb) 
        {
        global.___sb[sb,1]=round(global.___sb[sb,1])
        }
    
    sp=(((xx+sw)*(tp=0))+((yy+sh)*(tp>0)))+(global.___sb[sb,1]*((s/ms)*swh))
    ep=sp+max((wh*(wh/mwh)),4)
    
    for (a=floor(sp+1); a<=ceil(ep-2); a+=1) 
        {
        draw_sprite_ext(spr,(13*(tp=0))+(17*(tp>0)),(a*(tp=0))+(xx*(tp>0)),(yy*(tp=0))+(a*(tp>0)),0.5,0.5,0,c_white,1)
        }
    
    draw_sprite_ext(spr,(12*(tp=0))+(16*(tp>0)),(floor(sp)*(tp=0))+(xx*(tp>0)),(floor(sp)*(tp>0))+(yy*(tp=0)),0.5,0.5,0,c_white,1)
    draw_sprite_ext(spr,(14*(tp=0))+(18*(tp>0)),((ceil(ep)-2)*(tp=0))+(xx*(tp>0)),((ceil(ep)-2)*(tp>0))+(yy*(tp=0)),0.5,0.5,0,c_white,1)
    
    sel=(((device_mouse_x_to_gui(0)*(tp=0))+(device_mouse_y_to_gui(0)*(tp>0)))>=sp && ((device_mouse_x_to_gui(0)*(tp=0))+(device_mouse_y_to_gui(0)*(tp>0)))<ep && ((device_mouse_y_to_gui(0)*(tp=0))+(device_mouse_x_to_gui(0)*(tp>0)))>=(yy*(tp=0))+(xx*(tp>0)) && ((device_mouse_y_to_gui(0)*(tp=0))+(device_mouse_x_to_gui(0)*(tp>0)))<((yy+sh)*(tp=0))+((xx+sw)*(tp>0)) && mouse_check_button_pressed(mb_left))
    
    if (sel=1 && global.___sbdrag=-1) 
        {
        global.___sbcurrent=sb
        global.___sbdrag=sb
        global.___mxprev=device_mouse_x_to_gui(0)
        global.___myprev=device_mouse_y_to_gui(0)
        }
    }

else if (global.___sbdrag=sb) 
    {
    global.___sbdrag=-1
    }

sel=(((device_mouse_x_to_gui(0)*(tp=0))+(device_mouse_y_to_gui(0)*(tp>0)))>=(xx*(tp=0))+(yy*(tp>0)) && ((device_mouse_x_to_gui(0)*(tp=0))+(device_mouse_y_to_gui(0)*(tp>0)))<((xx+sw)*(tp=0))+((yy+sh)*(tp>0)) && ((device_mouse_y_to_gui(0)*(tp=0))+(device_mouse_x_to_gui(0)*(tp>0)))>=(yy*(tp=0))+(xx*(tp>0)) && ((device_mouse_y_to_gui(0)*(tp=0))+(device_mouse_x_to_gui(0)*(tp>0)))<((yy+sh)*(tp=0))+((xx+sw)*(tp>0)) && mouse_check_button(mb_left) && global.___sbdrag=-1 && mwh>wh)
sel2=(((device_mouse_x_to_gui(0)*(tp=0))+(device_mouse_y_to_gui(0)*(tp>0)))>=((xx+wh+sw)*(tp=0))+((yy+wh+sh)*(tp>0)) && ((device_mouse_x_to_gui(0)*(tp=0))+(device_mouse_y_to_gui(0)*(tp>0)))<((xx+(sw*2)+wh)*(tp=0))+((yy+(sh*2)+wh)*(tp>0)) && ((device_mouse_y_to_gui(0)*(tp=0))+(device_mouse_x_to_gui(0)*(tp>0)))>=(yy*(tp=0))+(xx*(tp>0)) && ((device_mouse_y_to_gui(0)*(tp=0))+(device_mouse_x_to_gui(0)*(tp>0)))<((yy+sh)*(tp=0))+((xx+sw)*(tp>0)) && mouse_check_button(mb_left) && global.___sbdrag=-1 && mwh>wh)

if (sel+sel2>0 && global.___sbtimer=0) 
    {
    global.___sb[sb,1]+=(-1*(sel=1))+(1*(sel2=1))
    global.___sb[sb,1]=max(0,min(ms-s,global.___sb[sb,1]))
    global.___sbtimer=ceil(fps/(15-(12*mouse_check_button_pressed(mb_left))))
    global.___sbcurrent=sb
    }

draw_sprite_ext(spr,(0*(tp=0))+(6*(tp>0))+(sel>0 || mwh<=wh)+(mwh<=wh),xx,yy,0.5,0.5,0,c_white,1)
draw_sprite_ext(spr,(3*(tp=0))+(9*(tp>0))+(sel2>0 || mwh<=wh)+(mwh<=wh),((xx+wh+sw)*(tp=0))+(xx*(tp>0)),(yy*(tp=0))+((yy+wh+sh)*(tp>0)),0.5,0.5,0,c_white,1)

}