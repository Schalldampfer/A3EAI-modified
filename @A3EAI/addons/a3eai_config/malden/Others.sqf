private ["_object"];
diag_log "Loading Malden Objects";

{
	_object = (_x select 0) createVehicle (_x select 1);
	_object setPos (_x select 1);
	_object setDir (_x select 2);
	_object setVectorUp surfaceNormal (_x select 1);
	_object lock 3;
	_object setVehicleAmmo 0;
	_object allowdamage false;
	_object enableSimulation false;
} forEach [
	["B_Radar_System_01_F",[5547.73,7912.75,0],130.230],
	["CUP_B_M119_US",[5430.44,8442.12,0],48.765]
];

["NEMB_Patrol",[7435.89,10586.9,0],"CUP_O_BTR40_MG_TKM",250,[4,1],1,false,0] call A3EAI_createCustomVehicleQueue;

[] spawn {
	waitUntil {!isNil "blck_locationBlackList"};

	//Forts
	{
		{
			blck_locationBlackList pushback [getPos _x,300];
		} forEach ([worldSize/2,worldSize/2,0] nearObjects [_x,worldSize]);
	} forEach ["Land_Bunker_01_HQ_F","Land_Bunker_01_small_F","Land_Bunker_01_tall_F","Land_Bunker_01_big_F"];
};
