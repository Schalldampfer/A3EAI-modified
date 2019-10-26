private ["_crate_weapons","_crate_magazines","_crate_items","_num_weapons","_num_magazines","_num_items"];

diag_log "[AI city] Pillbox spawn points & crates";

//Pillboxes
{
	[format["%1%2",typeOf _x,_forEachIndex],getPos _x,50,ceil(random 3),round(random 2),true,3600] call A3EAI_createCustomInfantryQueue;
} forEach ([worldSize/2,worldSize/2,0] nearObjects ["BagBunker_base_F",worldSize]);


//crate
_crate_weapons = A3EAI_sniperList + A3EAI_machinegunList;
_crate_magazines = A3EAI_MiscLoot1 + A3EAI_MiscLoot2;
_crate_items = A3EAI_weaponOpticsList + ["optic_NVS","optic_Nightstalker","optic_LRPS","Repair_EPOCH","Heal_EPOCH","ItemGeigerCounter_EPOCH","radiation_mask_epoch"];
_num_weapons = 3;
_num_magazines = 8;
_num_items = 4;

{
	private ["_crate","_pos","_weapon","_ammo"];
	_pos = _x select 1;
	
	//spawn
	_crate = (_x select 0) createVehicle _pos;
	
	//initialize
	_crate setVariable ["LAST_CHECK", 100000];
	_crate allowDamage false;
	_crate enableRopeAttach false;
	
	//place
	_crate setPosWorld _pos;
	if (count _x > 2) then {
		_crate setVectorDirAndUp (_x select 2);
	} else {
		_crate setVectorUp surfaceNormal position _crate;
	};
	
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
} forEach [
	["Box_Syndicate_Ammo_F",[11341.7,6606.06,121.637],[[-0.7639,0.645335,0],[0,0,1]]],
	["Box_Syndicate_Ammo_F",[7303.16,12817.9,123.234],[[-0.758337,-0.463238,-0.458623],[-0.529389,0.0271321,0.847945]]],
	["Box_Syndicate_Ammo_F",[2910.36,7166.65,44.6568],[[0.672971,0.684074,-0.281341],[0.113159,0.280666,0.953111]]]
];

