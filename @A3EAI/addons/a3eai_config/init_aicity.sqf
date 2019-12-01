AIcity_groups = [];

AIcity_spawn_manStatic = {
	_grp = ["static",true] call A3EAI_createGroup;
	{
		private ["_create","_object"];
		_create = _x select 0;
		
		//create empty obj
		_object = createVehicle _create;
		
		//initialize
		_object setPos (_create select 1);
		_object setVectorDirAndUp  (_x select 1);
		_object call A3EAI_protectObject;
		_object call A3EAI_secureVehicle;
		_object call A3EAI_clearVehicleCargo;
		_object addEventHandler ["GetOut",{
			_unit = _this select 2;
			_object = _this select 0;
			if (alive _unit) then {_unit moveInGunner _object};
		}];
		
		//create crew
		_gunnersAdded = [_grp,round(random 2),_object,10] call A3EAI_addVehicleGunners;
	} forEach _this;
	{_x setSkill 1;} forEach (units _grp);//set skill
	AIcity_groups pushBack _grp;
	diag_log format["[AIcity] group %1 spawned",_grp];
	_grp
};

AIcity_spawn_autoStatic = {
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
	} forEach _this;
	{_x setSkill 1;} forEach (units _grp);//set skill
	AIcity_groups pushBack _grp;
	diag_log format["[AIcity] group %1 spawned",_grp];
	_grp
};

AIcity_spawn_crate = {
	private ["_crate","_type","_pos","_dirAndUp","_weapon","_ammo","_crate_weapons","_crate_magazines","_crate_items","_num_weapons","_num_magazines","_num_items"];
	_type = _this select 0;
	_pos = _this select 1;
	_dirAndUp = _this select 2;
	_crate_weapons = (_this select 3) select 0;
	_num_weapons = (_this select 3) select 1;
	_crate_magazines = (_this select 4) select 0;
	_num_magazines = (_this select 4) select 1;
	_crate_items = (_this select 5) select 0;
	_num_items = (_this select 5) select 1;
	
	//spawn
	_crate = _type createVehicle _pos;
	
	//initialize
	_crate setVariable ["LAST_CHECK", 100000 + diag_tickTime, true];
	_crate allowDamage false;
	_crate enableRopeAttach false;
	
	//place
	_crate setPosWorld _pos;
	_crate setVectorDirAndUp _dirAndUp;
	
	//empty
	clearWeaponCargoGlobal _crate;
	clearMagazineCargoGlobal _crate;
	clearBackpackCargoGlobal _crate;
	clearItemCargoGlobal _crate;
	
	//fill
	if (count _crate_weapons > 0) then {
		private ["_weapon","_ammo"];
		for "_i" from 1 to _num_weapons do {
			_weapon = _crate_weapons select (floor (random (count _crate_weapons)));
			_ammo = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines") select 0;
			_crate addWeaponCargoGlobal [_weapon,1];
			_crate addMagazineCargoGlobal [_ammo, ceil(random 4)];
		};
	};
	if (count _crate_magazines > 0) then {
		for "_i" from 1 to _num_magazines do {
			_ammo = _crate_magazines select (floor (random (count _crate_magazines)));
			_crate addMagazineCargoGlobal [_ammo, 1];
		};
	};
	if (count _crate_items > 0) then {
		for "_i" from 1 to _num_items do {
			_ammo = _crate_items select (floor (random (count _crate_items)));
			_crate addItemCargoGlobal [_ammo, 1];
		};
	};
	
	//Marker
	["Container",_pos] call EPOCH_server_createGlobalMarkerSet;
	
	_crate
};

AIcity_spawn_mine = {
	_mine = createMine [_this select 0, _this select 1,[],0];
	_mine setVectorUp (surfaceNormal (_this select 1));
	_mine
};

AIcity_marker = {
	private["_mName","_mShape","_mType","_mColor","_mAlpha","_mSize","_mDir","_mText","_marker"];
	params [ 
		["_mPos",[0,0,0]],
		["_mShape","ICON"],
		["_mType","hd_dot"],
		["_mColor","ColorBlack"],
		["_mAlpha",1],
		["_mSize",[0.8,0.8]],
		["_mDir",0],
		["_mText",""]
	];

	if(isNil {AEpoch_markerCounterGlobal})then{AEpoch_markerCounterGlobal = 0};

	_mName = format["AEPOCH_globalMarker_%1", AEpoch_markerCounterGlobal];
	_marker = createMarker [_mName, _mPos];
	_mName setMarkerShape _mShape;
	if!(_mShape isEqualTo "ICON")then{
		if!(_mType in (getArray('CfgMarkerSets' call EPOCH_returnConfig >> "brushes")))exitWith{
			diag_log "AIcity: createGlobalMarkerSet -5- Shape is Ellipse or Rectangle and needs a Brush Type";
		};
	};
	_mName setMarkerType _mType; 
	_mName setMarkerAlpha _mAlpha;
	_mName setMarkerSize _mSize;
	_mName setMarkerDir _mDir;
	
	if!(_mText isEqualTo "")then{
		_mName setMarkerText _mText;
	};
	
	if!(_mColor isEqualTo "")then{
		_mName setMarkerColor _mColor
	};

	//missionNameSpace setVariable[_mName, _mSize, true];
	AEpoch_markerCounterGlobal = AEpoch_markerCounterGlobal + 1;
	_marker
};

//monitor
[] spawn {
	while {true} do{
		private _cnt = count AIcity_groups;
		{
			{(vehicle _x) setVehicleAmmo 1;} forEach (units _x);
			sleep 60*(15 / _cnt);
			diag_log format["[AIcity] rearming group %1",_x];
		} forEach AIcity_groups;
		sleep 60;
	};
};
