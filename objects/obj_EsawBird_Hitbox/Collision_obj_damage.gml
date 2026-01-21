if(team != other.team){
	DealDamage(other, damage, 6);
	follow.attack_spawned = false;
	instance_destroy();
	
	
}
