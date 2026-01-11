draw_self();
if(follow.flash > 0){
	shader_set(sha_white);
	draw_self();
	shader_reset();
}