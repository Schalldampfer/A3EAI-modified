private ["_crate_type","_crate_weapons","_crate_magazines","_crate_items","_num_weapons","_num_magazines","_num_items"];

diag_log "[AI city] Pillbox spawn points & crates";

//Forts
{
	private ["_type","_poss"];
	_type = _x;
	{
		_poss = [_x] call BIS_fnc_buildingPositions;
		if (count _poss > 0) then {
			//AI
			[format["%1%2",_type,_forEachIndex],getPos _x,50,round(random 3) + 2,round(random 2),true,3600] call A3EAI_createCustomInfantryQueue;
		};
	} forEach ([worldSize/2,worldSize/2,0] nearObjects [_type,worldSize]);
} forEach ["Land_Bunker_01_HQ_F","Land_Bunker_01_small_F","Land_Bunker_01_tall_F","Land_Bunker_01_big_F"];//"Cargo_House_base_F"

//Mines
{
	[selectRandom ["APERSMine","APERSBoundingMine","APERSMineDispenser_Mine_F"],_x] call AIcity_spawn_mine;
} forEach [
	[5879.13,10783.3,0],
	[6299.43,10705.8,0],
	[5846.91,10812.5,0],
	[5880.80,10834.3,0],
	[6331.28,10691.8,0],
	[6240.82,10746.4,0],
	[6206.53,10765.0,0],
	[6249.13,10806.0,0],
	[6202.31,10794.8,0],
	[6276.14,10703.4,0],
	[6302.85,10745.6,0]
];
