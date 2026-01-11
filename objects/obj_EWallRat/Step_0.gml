

var checkBelow = collision_point(x, y+1, obj_wall, 0, 0);
var checkAbove = collision_point(x, y-1, obj_wall, 0, 0);
var checkRight = collision_point(x+1, y, obj_wall, 0, 0);
var checkLeft  = collision_point(x-1, y, obj_wall, 0, 0);

var nothing = noone;

if(checkBelow != nothing) state = "Down"
if(checkAbove != nothing) state = "Up"
if(checkRight != nothing) state = "Right"
if(checkLeft != nothing) state = "Left"
else state = "Air"




switch (state){
	case "Down":
		image_angle = 0;
		break;
	
	case "Up":
		image_angle = 180;
		break;
		
	case "Right":
		image_angle = 90;
		break;
		
	case "Left":
		image_angle = -90;
		break;
		
	case "Air":
		y += 0.5;
		speed = 0;
		break;
}

direction = image_angle;
