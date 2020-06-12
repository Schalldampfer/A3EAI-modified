/*
	A3EAI Custom Spawn Definitions File
	
	Instructions: 
	
		Generate custom spawns and blacklist areas using the included A3EAI Editor Tool (Inside the "Editor Tool" folder of the A3EAI download package).
		
		Instructions on how to use the Editor Tool are located on the A3EAI Wikia page: http://a3eai.wikia.com/wiki/A3EAI_Editor_Tool
		
		In order for A3EAI to load this file on startup, you must set in @A3EAI/A3EAI_config/config.cpp under the "A3EAI Settings" section:
		
			loadCustomFile = 1;

//----------------------------Add your custom spawn and dynamic area blacklist definitions below this line ----------------------------*/
diag_log "[A3EAI] Loading a3eai_cusom_defs.sqf";


//{
//	A3EAI_locationsAir pushBack [name _x,getPos _x,"namelocal"];
//} forEach EPOCH_Traders;

//["TuvanakaIsland", [2619.81,12397.6,0],2500] call A3EAI_createBlacklistAreaQueue;
//["IpotaIsland",    [12763.2,14185.7,0],1000] call A3EAI_createBlacklistAreaQueue;
//["BalavuIsland",   [2206.04,7215.88,0],2500] call A3EAI_createBlacklistAreaQueue;
//["KatkoulaIsland", [4362.27,2703.15,0],3500] call A3EAI_createBlacklistAreaQueue;
//["LijnhavenIsland",[10792.6,2876.93,0],3000] call A3EAI_createBlacklistAreaQueue;
//["AreaName1",[2332.78,13324.5,2.47004],100,2,1,true,600] call A3EAI_createCustomInfantryQueue;
//["AreaName2",[2332.78,13324.5,2.47004],"VehicleType",100,[1,1],1,true,600] call A3EAI_createCustomVehicleQueue;

//AI cities
waitUntil {!isNil "EPOCH_server_setVToken"};
call compile preprocessFileLineNumbers "A3EAI_config\init_aicity.sqf";
switch(toLower worldName)do{
	case "tanoa":{
		call compile preprocessFileLineNumbers "A3EAI_config\tanoa\Pillbox.sqf";
		call compile preprocessFileLineNumbers "A3EAI_config\tanoa\SEfort.sqf";
		call compile preprocessFileLineNumbers "A3EAI_config\tanoa\Others.sqf";
	};
	case "malden":{
		call compile preprocessFileLineNumbers "A3EAI_config\malden\Pillbox.sqf";
		call compile preprocessFileLineNumbers "A3EAI_config\malden\SEIsland.sqf";
		call compile preprocessFileLineNumbers "A3EAI_config\malden\TreasureHunting.sqf";
		//[8000,10050,0] execVM "A3EAI_config\maze\maze.sqf";
	};
	default {};
};
call compile preprocessFileLineNumbers format["A3EAI_config\%1\Others.sqf",toLower worldName];
