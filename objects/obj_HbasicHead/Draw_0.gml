draw_self();
if(instance_exists(follow)){
	
	if(follow.flash > 0){
		shader_set(sha_white);
		draw_self();
		shader_reset();
	}
}
