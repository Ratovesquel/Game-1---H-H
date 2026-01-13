if(hp <= 0){
	instance_destroy();
	instance_create_layer(x, y, "Characters", obj_HbasicCorpse);
} 