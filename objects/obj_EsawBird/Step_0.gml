 
switch(state){
	
	#region IDLE
	case "idle":
	    sprite_index = spr_EsawBird_idle;
    
	    target = instance_nearest(x, y, obj_damage);

	    if(target != noone && target.id != id){
	        if (target.team != team){
	            if (point_distance(x, y, target.x, target.y) < range) {
	                if (!collision_line(x, y, target.x, target.y, obj_wall, false, true)) {            
	                    attack_dir = point_direction(x, y, target.x, target.y);
	                    state = "prepare";
	                }
	            }
	        }
	    }
		break;

	#endregion
	
	#region PREPARE
	case "prepare":
		prepareTime--;
		if(prepareTime <= 0){
			prepareTime = Seconds(2);
			state = "attack";
		}
		break;
	#endregion
	
	#region ATTACK	
	case "attack":
		attack_time--;
		
		var hsp = lengthdir_x(attack_speed, attack_dir);
        var vsp = lengthdir_y(attack_speed, attack_dir);
		
		if(attack_time > 0){
			sprite_index = spr_EsawBird_attack;
			
			// Horizontal colizion
	        if(place_meeting(x + hsp, y, obj_wall) || place_meeting(x + hsp, y, obj_damage)){
	            attack_dir = 180 - attack_dir;
	        } 
			else{
	            x += hsp;
	        }
			
			// Vertical colision
	        if(place_meeting(x, y + vsp, obj_wall) || place_meeting(x, y + vsp, obj_damage)){
	            attack_dir = -attack_dir;
	        } 
			else{
	            y += vsp;
	        }
			
		}
		else {
			attack_time = Seconds(5);
			state = "idle"
		}
		if (!attack_spawned) {
		    with (instance_create_layer(x, y, "Bullets", obj_EsawBird_Hitbox)) {
		        team = other.team;
		        damage = 40;
			}
		attack_spawned = true;
		}
		attack_spawned = false;
		
		break;
	#endregion
}


