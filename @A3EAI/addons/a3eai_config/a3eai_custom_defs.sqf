/*
	A3EAI Custom Spawn Definitions File
	
	Instructions: 
	
		Generate custom spawns and blacklist areas using the included A3EAI Editor Tool (Inside the "Editor Tool" folder of the A3EAI download package).
		
		Instructions on how to use the Editor Tool are located on the A3EAI Wikia page: http://a3eai.wikia.com/wiki/A3EAI_Editor_Tool
		
		In order for A3EAI to load this file on startup, you must set in @A3EAI/A3EAI_config/config.cpp under the "A3EAI Settings" section:
		
			loadCustomFile = 1;

//----------------------------Add your custom spawn and dynamic area blacklist definitions below this line ----------------------------*/
private ["_grp"];
diag_log "[A3EAI] Loading a3eai_cusom_defs.sqf";

//["TuvanakaIsland", [2619.81,12397.6,0],2500] call A3EAI_createBlacklistAreaQueue;
//["IpotaIsland",    [12763.2,14185.7,0],1000] call A3EAI_createBlacklistAreaQueue;
//["BalavuIsland",   [2206.04,7215.88,0],2500] call A3EAI_createBlacklistAreaQueue;
//["KatkoulaIsland", [4362.27,2703.15,0],3500] call A3EAI_createBlacklistAreaQueue;
//["LijnhavenIsland",[10792.6,2876.93,0],3000] call A3EAI_createBlacklistAreaQueue;

//Static Weapons
_grp = ["static",true] call A3EAI_createGroup;
{
	private ["_create","_object"];
	_create = _x select 0;
	
	//create empty obj
	_object = createVehicle _create;
	
	//create crew
	createVehicleCrew _object;
	(crew _object) joinsilent _grp;
	
	//set pos
	_object setPos (_create select 1);
	_object setVectorDirAndUp  (_x select 1);
	
	//initialize (SAMs,AAAs)
	_object setVehicleReportRemoteTargets true;
	_object setVehicleReceiveRemoteTargets true;
	_object setVehicleReportOwnPosition true;
	_object setVehicleRadar 1;
}
forEach [
	[["B_Radar_System_01_F",[11018.6,4219.49,0],[],0,"CAN_COLLIDE"], [[-0.354481,0.935063,0],[0,0,1]]], 
	[["B_Radar_System_01_F",[2663.02,12311.8,0],[],0,"CAN_COLLIDE"], [[0.827972,0.556193,0.0714951],[-0.0718156,-0.021275,0.997191]]], 
	[["B_SAM_System_01_F",[12019,2572.1,0],[],0,"CAN_COLLIDE"], [[0.403751,-0.914869,0],[0,0,1]]], 
	[["B_SAM_System_01_F",[2694.83,12342.5,0],[],0,"CAN_COLLIDE"], [[-0.478474,0.873233,-0.092337],[-0.00800834,0.100811,0.994873]]], 
	[["B_AAA_System_01_F",[12142.5,2510.66,0],[],0,"CAN_COLLIDE"], [[0.998514,-0.0544978,0],[0,0,1]]], 
	[["B_AAA_System_01_F",[2332.45,13324.5,0],[],0,"CAN_COLLIDE"], [[0.793416,0.608671,0.00324213],[0,-0.0053265,0.999986]]], 
	[["B_Ship_Gun_01_F",[12184,2573.03,2.38419e-007],[],0,"CAN_COLLIDE"], [[-0.0267386,0.999642,0],[0,0,1]]]
];
{_x setSkill 1;} forEach (units _grp);
_grp spawn {
	private _grp = _this;
	while {true} do{
		{(vehicle _x) setVehicleAmmo 1;} forEach (units _grp);
		sleep 60*15;
	};
}


//{
//	A3EAI_locationsAir pushBack [name _x,getPos _x,"namelocal"];
//} forEach EPOCH_Traders;

//["AreaName1",[2332.78,13324.5,2.47004],100,2,1,true,600] call A3EAI_createCustomInfantryQueue;
//["AreaName2",[2332.78,13324.5,2.47004],"VehicleType",100,[1,1],1,true,600] call A3EAI_createCustomVehicleQueue;


//Pillboxes
{
	[format["%1%2",typeOf _x,_forEachIndex],getPos _x,50,ceil(random 3),round(random 2),true,3600] call A3EAI_createCustomInfantryQueue;
} forEach ([worldSize/2,worldSize/2,0] nearObjects ["BagBunker_base_F",worldSize]);


