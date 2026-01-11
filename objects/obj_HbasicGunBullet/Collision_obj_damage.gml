if(bulletTeam != other.team){
	if(other.canDamage){
		other.flash = 4;
		other.hp -= 8;
		instance_destroy();
	}
	else instance_destroy();
	
}
