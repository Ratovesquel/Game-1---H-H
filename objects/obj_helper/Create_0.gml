global.deadZone = 0.2;

enum Classes{
	Defalt,
	Warrior,
	Mage,
	Engineer,
	Prayer
}

enum Classification{
	Defalt,
	Fighter,
	Shooter,
	Tank,
	Curser,
	Suport
}


global.teamList = ds_map_create();

global.teamList[? "Team1"]   = ds_list_create();
global.teamList[? "Team2"]   = ds_list_create();
global.teamList[? "Neutral"] = ds_list_create();
global.teamList[? "Monster"] = ds_list_create();
