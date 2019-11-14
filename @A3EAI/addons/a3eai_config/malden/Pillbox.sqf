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
		[format["%1%2",_type,_forEachIndex],getPos _x,50,round(random 4) + 2,round(random 2),true,3600] call A3EAI_createCustomInfantryQueue;
		//Crate
		_poss = [_x] call BIS_fnc_buildingPositions;
		if ((count _poss > 0) && (random 1 > 0.5)) then {
			[_crate_type, selectRandom ([_x] call BIS_fnc_buildingPositions) , [[random 1,random 1,0],[0,0,1]], [_crate_weapons, _num_weapons], [_crate_magazines, _num_magazines], [_crate_items, _num_items]] call AIcity_spawn_crate;
		};
	} forEach ([worldSize/2,worldSize/2,0] nearObjects [_type,worldSize]);
} forEach ["Land_Bunker_01_HQ_F","Land_Bunker_01_small_F","Land_Bunker_01_tall_F","Land_Bunker_01_big_F"];//"Cargo_House_base_F"


//crate
_num_weapons = 3;
_num_magazines = 8;
_num_items = 4;

["Box_Syndicate_Ammo_F", [6237.35,10781.1,131.281], [[0.391608,-0.92013,0],[0,0,1]], [_crate_weapons, _num_weapons], [_crate_magazines, _num_magazines], [_crate_items, _num_items]] call AIcity_spawn_crate;
["Box_Syndicate_Wps_F", [5876.09,10791.8,115.652], [[0.999909,0.013505,0],[0,0,1]], [_crate_weapons, _num_weapons], [_crate_magazines, _num_magazines], [_crate_items, _num_items]] call AIcity_spawn_crate;
["Box_Syndicate_WpsLaunch_F", [6304.21,10704.7,112.492], [[0.705498,0.708712,0],[0,0,1]], [_crate_weapons, _num_weapons], [_crate_magazines, _num_magazines], [_crate_items, _num_items]] call AIcity_spawn_crate;

//Static Weapons
[
	//Trader
	[["B_Radar_System_01_F",[5548.41,7912.73,0],[],0,"CAN_COLLIDE"], [[0.763111,-0.646266,-0.00149637],[0.0303859,0.0335666,0.998974]]],
	//MBase
	[["B_Ship_MRLS_01_F",[6989.59,10113.1,0],[],0,"CAN_COLLIDE"], [[0.741029,-0.671402,-0.00978397],[0.02479,0.012794,0.999611]]],
	//North
	[["I_HMG_01_A_F",[6238.41,10778.2,20.4844],[],0,"FLY"], [[-0.431063,-0.902322,0],[0,0,1]]],
	[["I_HMG_01_A_F",[5918.24,10728.9,0],[],0,"CAN_COLLIDE"], [[0.0168475,0.999858,0],[0,0,1]]],
	[["I_E_Radar_System_01_F",[7137.29,12231.5,0],[],0,"CAN_COLLIDE"], [[0.0394039,0.997611,0.0567503],[-0.0223958,-0.0558984,0.998185]]],
	[["I_E_SAM_System_03_F",[6272.07,10839.8,0],[],0,"CAN_COLLIDE"], [[0.470723,0.881945,0.0243571],[0.0112037,-0.03358,0.999373]]]
] call AIcity_spawn_autoStatic;

//Additional AIs
["A3EAI_North_1",[6341.47,10733.4,0],50,round(random 3)+3,round(random 2)+1,false] call A3EAI_createCustomInfantryQueue;
["A3EAI_North_2",[6093.38,10761.8,0],50,round(random 3)+3,round(random 2)+1,false] call A3EAI_createCustomInfantryQueue;

createMine ["ATMine",[5765.65,10752.7,0],[],0];
createMine ["ATMine",[5846.91,10812.5,0],[],0];
createMine ["ATMine",[5880.80,10834.3,0],[],0];
createMine ["ATMine",[6331.28,10691.8,0],[],0];
createMine ["ATMine",[6240.82,10746.4,0],[],0];
createMine ["ATMine",[6206.53,10765.0,0],[],0];
createMine ["ATMine",[6249.13,10806.0,0],[],0];
createMine ["ATMine",[6202.31,10794.8,0],[],0];
createMine ["ATMine",[6276.14,10703.4,0],[],0];
createMine ["ATMine",[6302.85,10745.6,0],[],0];

_mine = createMine ["APERSMineDispenser_Mine_F",[5879.13,10783.3,0],[],0];
_mine setVectorDirAndUp [[0.942806,0.329627,0.0496252],[-0.0503351,-0.0063863,0.998712]];
_mine = createMine ["APERSMineDispenser_Mine_F",[6299.43,10705.8,0],[],0];
_mine setVectorDirAndUp [[-0.409188,-0.912433,-0.005485],[0.0080009,-0.009599,0.999922]];
_mine = createMine ["APERSTripMine",[6234.45,10780.9,17.8477],[],0];
_mine setVectorDirAndUp [[-0,-1,-0],[0,0,1]];
