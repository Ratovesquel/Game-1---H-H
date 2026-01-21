// Basic attack creation
var gun = instance_create_layer(x, y, "Weapons", obj_HbasicGun);
gun.follow = id;
gun.gunTeam = team;

// Head creation
var head = instance_create_layer(x, y, "Characters", obj_HbasicHead);
head.follow = id;

// Class n' Classification
class = Classes.Defalt;
classif = Classification.Defalt


window_set_cursor(cr_none)
cursor_sprite = spr_cursor_rat;

enum State{
	IDLE,
	AIR,
	RUN,
	ROLL,
	SQUAT,
	SQUATWALK,
	DEAD
}

playerState = State.IDLE;
lastState = State.IDLE;