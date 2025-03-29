/// @description Insert description here
// You can write your code in this editor
dir = 1;
p_pal=0;
sprite_index=spr_kid_stand;

//universal movement states
jumping=false;
falling=true;
on_ground=false;
walking=false;
crawling=false;
skidding=false;

//states specific to kid form
flipping=false;

//states specific to iron knight
climbing=false;

//states specific to red stealth
swinging=false;

///Variables for Movement
image_speed = 0;//
mspd = 0.5;       // maximum movement speed
avx = 0;        // actual velocity x - is used for saving uneven number remainder!
avy = 0;        // actual velocity y - is used for saving uneven number remainder!
grav = 0.4;      // gravity