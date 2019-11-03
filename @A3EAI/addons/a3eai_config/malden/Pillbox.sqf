private ["_crate_type","_crate_weapons","_crate_magazines","_crate_items","_num_weapons","_num_magazines","_num_items"];

diag_log "[AI city] Pillbox spawn points & crates";

//Forts
{
	private ["_type"];
	_type = _x;
	{
		[format["%1%2",_type,_forEachIndex],getPos _x,50,ceil(random 3),round(random 2),true,3600] call A3EAI_createCustomInfantryQueue;
	} forEach ([worldSize/2,worldSize/2,0] nearObjects [_type,worldSize]);
} forEach ["Cargo_House_base_F","Land_Bunker_01_HQ_F","Land_Bunker_01_small_F","Land_Bunker_01_tall_F","Land_Bunker_01_big_F"];

