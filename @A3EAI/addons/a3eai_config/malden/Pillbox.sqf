private ["_crate_type","_crate_weapons","_crate_magazines","_crate_items","_num_weapons","_num_magazines","_num_items"];

diag_log "[AI city] Pillbox spawn points & crates";

//crate
_crate_type = "Box_Syndicate_Ammo_F";
_crate_weapons = A3EAI_sniperList + A3EAI_machinegunList;
_crate_magazines = A3EAI_MiscLoot1 + A3EAI_MiscLoot2;
_crate_items = A3EAI_weaponOpticsList + ["optic_NVS","optic_Nightstalker","optic_LRPS","Repair_EPOCH","Heal_EPOCH","ItemGeigerCounter_EPOCH","radiation_mask_epoch"];
_num_weapons = 2;
_num_magazines = 6;
_num_items = 2;


//Forts
{
	private ["_type","_poss"];
	_type = _x;
	{
		//AI
		[format["%1%2",_type,_forEachIndex],getPos _x,50,ceil(random 3),round(random 2),true,3600] call A3EAI_createCustomInfantryQueue;
		//Crate
		_poss = [_x] call BIS_fnc_buildingPositions;
		if ((count _poss > 0) && (random 1 > 0.5)) then {
			[_crate_type, selectRandom ([_x] call BIS_fnc_buildingPositions) , [[random 1,random 1,0],[0,0,1]], [_crate_weapons, _num_weapons], [_crate_magazines, _num_magazines], [_crate_items, _num_items]] call AIcity_spawn_crate;
		};
	} forEach ([worldSize/2,worldSize/2,0] nearObjects [_type,worldSize]);
} forEach ["Land_Bunker_01_HQ_F","Land_Bunker_01_small_F","Land_Bunker_01_tall_F","Land_Bunker_01_big_F"];//"Cargo_House_base_F"

