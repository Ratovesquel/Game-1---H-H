if(instance_exists(follow)){
	x = follow.x;
	y = follow.y + 6;
}
else instance_destroy();



//if (obj_player.controller == 0){
image_angle = point_direction(x, y, mouse_x, mouse_y);	
//}

//else{
//	var controllerh = gamepad_axis_value(0, gp_axisrh);
//	var controllerv = gamepad_axis_value(0, gp_axisrv);
//	if (abs(controllerh) > global.deadZone || abs(controllerv) > global.deadZone ){
//		controllerAngle = point_direction(0, 0, controllerh, controllerv);
//	}
//	image_angle = controllerAngle;
//}

#region SHOOTING
firingDelay = firingDelay - 1;
recoil = max(0, recoil - 1);

if(mouse_check_button(mb_left) && firingDelay < 0){
	firingDelay = attacksp;
	recoil = 3;
//	ScreenShake(2.1, 10);
//	audio_play_sound(snd_shoot,5,false);
	
	var b = instance_create_layer(x, y, "Bullets", obj_HbasicGunBullet);
	b.speed = 4;
	b.direction = image_angle + random_range(-3, 3);
	b.image_angle = b.direction;
	b.bulletTeam = gunTeam;

	
}

x = x - lengthdir_x(recoil, image_angle);
y = y - lengthdir_y(recoil, image_angle);
#endregion

if (image_angle > 90 && image_angle < 270) image_yscale = -1;
else image_yscale = 1;