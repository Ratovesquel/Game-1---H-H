 
switch(state){
	
//criar um actualRange, em que cada frame, vai olhar todos do team1, escolher o que 
// estiver mais próximo e dentro do critério depois fazer o mesmo mas usando o actualRange
// como range, se atualizar o target, no final só restartar o actualRange e rlx
	
	#region IDLE
	case "idle":
	    sprite_index = spr_EsawBird_idle;
    
	    target = obj_Hbasic

	    
	       
	            if (point_distance(x, y, target.x, target.y) < range) {
	                if (!collision_line(x, y, target.x, target.y, obj_wall, false, true)) {            
	                    attack_dir = point_direction(x, y, target.x, target.y);
	                    state = "prepare";
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
		
		break;
	#endregion
}


#region HITBOX
if (!hitbox_spawned && hitbox_timer <=0){
	with(instance_create_layer(x, y, "Bullets", obj_EsawBird_Hitbox)){
		team = other.team;
	}
	attack_spawned = true;
	hitbox_timer = hitbox_timer_max;
}
else if(attack_spawned == false) hitbox_timer--;
#endregion





