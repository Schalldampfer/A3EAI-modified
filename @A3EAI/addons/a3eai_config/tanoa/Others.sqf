private ["_grp"];

//Static Weapons
_grp = ["static",true] call A3EAI_createGroup;
{
	private ["_create","_object"];
	_create = _x select 0;
	
	//create empty obj
	_object = createVehicle _create;
	
	//create crew
	createVehicleCrew _object;
	[crew _object] joinsilent _grp;
	
	//set pos
	_object setPos (_create select 1);
	_object setVectorDirAndUp  (_x select 1);
	_object call A3EAI_protectObject;
	_object call A3EAI_secureVehicle;
	_object call A3EAI_clearVehicleCargo;
	
	//initialize (SAMs,AAAs)
	_object setVehicleReportRemoteTargets true;
	_object setVehicleReceiveRemoteTargets true;
	_object setVehicleReportOwnPosition true;
	_object setVehicleRadar 1;
}
forEach [
	[["B_Radar_System_01_F",[2663.02,12311.8,0],[],0,"CAN_COLLIDE"], [[0.827972,0.556193,0.0714951],[-0.0718156,-0.021275,0.997191]]], 
	[["B_Radar_System_01_F",[2060.1,4235.44,0],[],0,"CAN_COLLIDE"], [[0.835344,-0.548824,-0.0315078],[0.00267442,-0.0532573,0.998577]]], 
	[["B_SAM_System_01_F",[2694.83,12342.5,0],[],0,"CAN_COLLIDE"], [[-0.478474,0.873233,-0.092337],[-0.00800834,0.100811,0.994873]]], 
	[["B_SAM_System_01_F",[2882.19,3420.58,0],[],0,"CAN_COLLIDE"], [[-0.0404775,0.996898,-0.067496],[0.0399685,0.0691127,0.996808]]], 
	[["B_AAA_System_01_F",[2332.45,13324.5,0],[],0,"CAN_COLLIDE"], [[0.793416,0.608671,0.00324213],[0,-0.0053265,0.999986]]], 
	[["B_AAA_System_01_F",[1887.44,3873.06,1.90735e-006],[],0,"CAN_COLLIDE"], [[-0.25163,0.967723,0.0139319],[-0.0266571,-0.0213197,0.999417]]]
];
{_x setSkill 1;} forEach (units _grp);
_grp spawn {
	private _grp = _this;
	while {true} do{
		{(vehicle _x) setVehicleAmmo 1;} forEach (units _grp);
		sleep 60*15;
	};
};
