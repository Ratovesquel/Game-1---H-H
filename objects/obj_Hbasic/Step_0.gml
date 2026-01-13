if(hasControl){	
#region KEYBOARD IMPUT
key_left = keyboard_check(vk_left) || keyboard_check(ord("A"));
key_spaceight = keyboard_check(vk_right) || keyboard_check(ord("D"));
key_up = keyboard_check(vk_up) || keyboard_check(ord("W"));
key_down = keyboard_check(vk_down) || keyboard_check(ord("S"));
#endregion

#region CONTROLLER
if ((key_left) || (key_spaceight) || (key_up)){
	controller = false;
}

if ((abs(gamepad_axis_value(0, gp_axislh)) > global.deadZone) || (gamepad_button_check(0, gp_padl)) || (gamepad_button_check(0, gp_padr))){
	key_left = abs(min(gamepad_axis_value(0, gp_axislh), 0)) || gamepad_button_check(0, gp_padl);
	key_spaceight = max(gamepad_axis_value(0, gp_axislh), 0) || gamepad_button_check(0, gp_padr);
	controller = true;
}

if (gamepad_button_check(0, gp_face1)){
	key_up = 1;
	controller = true;
}
#endregion
}else{
	key_left = 0;
	key_spaceight = 0;
	key_up = 0;
}

#region MOVIMENTATION

#region HORIZONTAL MOVIMENTATION
var move = key_spaceight - key_left; 

if (key_left && key_spaceight) move = 0;

// Acelereation
if(move != 0){
    hsp += move * accel;
} 
else{
    if (hsp > 0){
        hsp = max(0, hsp - decel);
    } 
	else if (hsp < 0){
        hsp = min(0, hsp + decel);
    }
}

// Limit max speed
if(spd_mod != spd_mod_aux){
	spd_mod_aux = spd_mod;
	max_spd = 4.2 * spd_mod;
}
hsp = clamp(hsp, -max_spd, max_spd);



#endregion

#region JUMPING
// jumping

vsp = vsp + gvt;

canJump--;

if ((canJump > 0) && (key_up)){
    vsp = -8.25;
    canJump = 0;
}

// if vsp is up beside jumping, it will afect  - bug
if (!key_up && vsp < 0) {
        vsp *= 0.9;
}
#endregion

#endregion

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

#region ANIMATION

// Xscale -----------
//change normaly
//if (hsp != 0) image_xscale = sign(hsp);
//var position_mouse_player = mouse_x - x;

//  XSCALE
if(abs(mouse_x - x) < 15){
	if (hsp != 0) image_xscale = sign(hsp);
} 
else image_xscale = sign(mouse_x - x);

//DEATH
//if(hp <= 0){
//	image_speed = 1;
//	sprite_index = spr_Hbasic_corpse;
//	hasControl = false;
//	if(image_index >= 6) image_index = 6;
//	playerState = State.DEAD;
//}

// On skill 2 -----------
if(verifier_skl2){
	playerState = State.ROLL
}

// On air -----------
else if(!place_meeting(x, y+1, obj_wall)){
	
	gvt = 0.3;
	if(key_down) gvt = 0.6;
	
	image_speed = 0;
	sprite_index = spr_Hbasic_air;
	if(vsp < 0) image_index = 0;
	else image_index = 1;
}

// On ground -----------
else{
	canJump = 10;
	image_speed = 1;
	
	if(sprite_index == spr_Hbasic_air){
		audio_sound_pitch(snd_landing, random_range(0.7, 1.3));
		audio_play_sound(snd_landing, 5, false);
	}	
	
	
	if(key_down){
		
		if(hsp == 0){
			sprite_index = spr_Hbasic_squat;
			if(image_index > 1) image_index = 1.1;
		}
		else{
			sprite_index = spr_Hbasic_squatWalk;
			if(image_xscale == sign(hsp)) spd_mod = 0.5;
			else{
				spd_mod = 0.35;
				image_speed = -1;
			}
		}
	}
	
	else{
		
		if(image_xscale == sign(hsp)) spd_mod = 1;
		else {
			spd_mod = 0.75;
			image_speed = -1;
		}
		
		if(hsp == 0) sprite_index = spr_Hbasic_idle;
		else sprite_index = spr_Hbasic_running;
	}
	
}



#endregion

#region SKILL 1 - Space

// Basic hero skill 1: heal, heal 30 hp of himself
var key_space = keyboard_check_released(vk_space);
var testButton = keyboard_check_released(ord("F"));
if(testButton){
	DealDamage(id, 50);
	//ActivateCurse(id);
}

cooldown_skl1--;
if(key_space && cooldown_skl1 <= 0){
	hp += 30;
	cooldown_skl1 = cooldown_skl1MAX
} 
if(hp > hp_max) hp = hp_max;

#endregion

#region SKILL 2 - Right Click

// Basic hero skill 2: rolling, dont take damage while rolling
var key_mouseR = mouse_check_button_released(mb_right);

cooldown_skl2--;
if(key_mouseR && cooldown_skl2 <= 0){
	verifier_skl2 = true;
	cooldown_skl2= cooldown_skl2MAX;
	canDamage = false
}


#endregion

#region TEST
var attackTest = keyboard_check_released(ord("T"));

#endregion

#region SM
switch (playerState){
	case State.AIR:
		break;
		
	case State.DEAD:
		break;
		
	case State.IDLE:
		break;
		
		
	case State.ROLL:
		image_speed = 1
		if(hsp != 0){
			hsp = 4.5 * sign(hsp);
			image_xscale = sign(hsp);
		}
		else{
			hsp = 4.5 * sign(image_xscale);
		}
	
		sprite_index = spr_Hbasic_rolling;
	
		if(image_index >= 9.6){
			verifier_skl2 = false;
			canDamage = true;
			playerState = State.IDLE;
		}
		break;
		
		
	case State.RUN:
		break;
		
	case State.SQUAT:
		break;
		
	case State.SQUATWALK:
		break;
}
#endregion

//if (sprite_index == spr_HbasicRunning){
//    show_debug_message("RUNNING | image_index: " + string(image_index) + " | image_speed: " + string(image_speed));
//}

