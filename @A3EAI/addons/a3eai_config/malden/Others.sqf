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
	["CUP_B_M119_US",[5430.44,8442.12,0],48.765]
];
