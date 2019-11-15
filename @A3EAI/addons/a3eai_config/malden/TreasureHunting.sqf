if (!isServer) exitWith {};
private ["_center","_radius","_numVeins","_Veins","_numBoats","_Boats","_numCrypto","_Crypto","_minvalue","_maxvalue"];

///////// Settings /////////
_center = selectRandom [[9615.45,3719.38,0],[11426.7,4419.3,0]];
_radius = 500;
_numVeins = 8;
_Veins = getArray(configFile >> "CfgEpoch" >> worldname >> "availableMinerals");
_numBoats = 2 + floor(random 8);
_Boats = ["Land_UWreck_FishingBoat_F","Land_RowBoat_V1_F","Land_RowBoat_V2_F","Land_RowBoat_V3_F","Land_Boat_01_abandoned_blue_F","Land_Boat_01_abandoned_red_F","Land_Boat_02_abandoned_F","Land_Boat_03_abandoned_F","Land_Boat_03_abandoned_cover_F","Land_Boat_04_wreck_F","Land_Boat_05_wreck_F","Land_Boat_06_wreck_F"];
_numCrypto = 10;
_Crypto = [200,1000];

///////// Run /////////
diag_log "[Treasure Hunting] Loading...";

//Marker
[_center,"ELLIPSE","Solid","ColorBlue",0.3,[_radius,_radius],0,"Treasure Hunting"] call AIcity_marker;

//Spawn veins and mass graves
{
	private ["_pos","_veh"];
	_pos = _x select 0;
	if (isOnRoad _pos) exitWith {};
	_veh = (selectRandom _Veins) createVehicle _pos;
	_veh setDir (random 360);
	_veh setVectorUp surfaceNormal _pos;
	_veh enableSimulation false;
} forEach (selectBestPlaces [_center, _radius, "forest * 0.9 + trees - houses", 10, _numVeins]);

//Spawn shore objcts
for "_x" from 1 to _numBoats do {
	private ["_pos","_veh"];
	_pos = [_center, 0, _radius, 4, 0, 2000, 1] call BIS_fnc_findSafePos;
	_veh = (selectRandom _Boats) createVehicle _pos;
	_veh setDir round(random 360);
	_veh setVectorUp surfaceNormal _pos;
	_veh enableSimulation false;
};

//Spawn money
_Crypto params ["_minvalue","_maxvalue"];
{
	private ["_pos","_item"];
	_pos = _x select 0;
	if (isOnRoad _pos) exitWith {};
	_item = createVehicle ["Land_Money_F", _pos, [], 10, "NONE"];
	_item setVariable ["Crypto",round (_minvalue + random (_maxvalue-_minvalue)),true];
	_item setVariable ["RemoveOnTake",true];
} forEach (selectBestPlaces [_center, _radius, "forest * 0.9 + trees - houses", 10, _numCrypto]);
