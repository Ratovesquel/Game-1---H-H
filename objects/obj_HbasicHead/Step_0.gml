// Position
if(instance_exists(follow)){
	x = follow.x;
	y = follow.y + yposMod;
	image_xscale = follow.image_xscale;


#region ANIMATION

sprMod = 0;

switch (follow.sprite_index){
	case spr_Hbasic_idle:
		sprite_index = spr_Hbasic_head;
		// Y modifier
		if(follow.image_index >= 1 && follow.image_index <= 3) yposMod = -1;
		else yposMod = 0;
		
		break;
		
	case spr_Hbasic_running:
		// sprite N 2 - 5 - 6 GML 1 - 4
		sprite_index = spr_Hbasic_head;
		
		// Y modifier
		if((follow.image_index >= 1 && follow.image_index <= 2) || (follow.image_index >= 4 && follow.image_index <= 5)) yposMod = 1;
		else yposMod = 0;
		
		// Spr modifier
		if(follow.image_index >= 2 && follow.image_index <= 5) sprMod = 1;
		
		break;
		
	case spr_Hbasic_air:
		sprite_index = spr_Hbasic_head;
		
		// Y modifier
		if(follow.image_index <= 1) yposMod = - 1;
		else yposMod = 0;

		break;
	
	case spr_Hbasic_squat:
		sprite_index = spr_no_sprite;
		break;

	case spr_Hbasic_squatWalk:
		sprite_index = spr_no_sprite;
		break;
		
	case spr_Hbasic_rolling:
		sprite_index = spr_no_sprite;
		break;
		
	default:
		sprite_index = spr_Hbasic_head;
		break;
}

// Spr modifier
// 0 - mid; 1 - midR; 2 - down; 3 - downR; 4 - up; 5 - upR
if(device_mouse_y_to_gui(0) < display_get_gui_height()/3) image_index = 4 + sprMod;
else if(device_mouse_y_to_gui(0) > display_get_gui_height()/3*2) image_index = 2 + sprMod;
else image_index = 0 + sprMod;



#endregion

}
else{
	image_index = 0;
	
	
	#region COLISION
// Horizontal colision
if (place_meeting(x+hsp, y, obj_wall)){
	while(!place_meeting(x+sign(hsp), y, obj_wall)){
		x = x + sign(hsp);
	}
	hsp = 0;
}

x = x + hsp;


// Vertical colision
if (place_meeting(x, y+vsp, obj_wall)){
	while(!place_meeting(x, y+sign(vsp), obj_wall)){
		y = y + sign(vsp);
	}
	vsp = 0;
}

y = y + vsp;
#endregion

vsp = vsp + gvt;

}