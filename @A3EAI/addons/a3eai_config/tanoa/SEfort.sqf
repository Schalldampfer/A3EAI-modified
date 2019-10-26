private ["_grp","_crate_weapons","_crate_magazines","_crate_items","_num_weapons","_num_magazines","_num_items"];

//Static Weapons
_grp = ["static",true] call A3EAI_createGroup;
//manned
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
}
forEach [
	//[["B_static_AT_F",[12035.1,2431.72,-2.38419e-006],[],0,"CAN_COLLIDE"], [[-0.853766,-0.520652,0.00226419],[0.00265199,0,0.999996]]],
	//[["B_static_AT_F",[12186.5,2535.48,0],[],0,"CAN_COLLIDE"], [[0.964527,-0.263986,0],[0,0,1]]],
	//[["B_static_AT_F",[12016.3,2575.15,0],[],0,"CAN_COLLIDE"], [[-0.795794,0.605568,0],[0,0,1]]],
	//[["B_static_AA_F",[12135.6,2507.06,0],[],0,"CAN_COLLIDE"], [[0.522174,0.852839,0],[0,0,1]]],
	//[["B_static_AA_F",[12128.6,2516.4,0],[],0,"CAN_COLLIDE"], [[0.999747,0.022503,0],[0,0,1]]],
	//[["B_static_AA_F",[12112.4,2504.06,0],[],0,"CAN_COLLIDE"], [[-0.573876,0.818942,0],[0,0,1]]],
	//[["B_static_AA_F",[12036.6,2465.73,0],[],0,"CAN_COLLIDE"], [[-0.992997,0.118142,0],[0,0,1]]],
	//[["B_static_AA_F",[12049.9,2437.2,0],[],0,"CAN_COLLIDE"], [[-0.787191,-0.616709,0],[0,0,1]]],
	[["B_GMG_01_high_F",[12055.1,2426.89,4.76837e-007],[],0,"CAN_COLLIDE"], [[-0.189876,-0.981808,0],[0,0,1]]],
	[["B_GMG_01_high_F",[12032.9,2465.56,4.76837e-007],[],0,"CAN_COLLIDE"], [[-0.956382,0.292119,0],[0,0,1]]],
	[["B_GMG_01_high_F",[12146.9,2518.64,4.76837e-007],[],0,"CAN_COLLIDE"], [[0.630638,0.776077,0],[0,0,1]]],
	[["B_GMG_01_high_F",[12145.9,2497.08,0.00842953],[],0,"CAN_COLLIDE"], [[0.492774,-0.869336,0.0378034],[0.0627533,0.0788351,0.994911]]],
	[["B_GMG_01_high_F",[12125.1,2473.99,4.76837e-007],[],0,"CAN_COLLIDE"], [[0.333662,0.942693,0],[0,0,1]]],
	[["B_HMG_01_high_F",[12201.3,2449.99,0],[],0,"CAN_COLLIDE"], [[0.918129,-0.396281,0],[0,0,1]]],
	[["B_HMG_01_high_F",[12184.1,2490.07,0],[],0,"CAN_COLLIDE"], [[0.526247,0.850332,0],[0,0,1]]],
	[["B_HMG_01_high_F",[12144.1,2573.21,0],[],0,"CAN_COLLIDE"], [[-0.794685,0.607023,0],[0,0,1]]],
	[["B_HMG_01_high_F",[12070.6,2559.3,0],[],0,"CAN_COLLIDE"], [[0.821772,0.569817,0],[0,0,1]]],
	[["B_HMG_01_high_F",[12035.3,2519.48,0],[],0,"CAN_COLLIDE"], [[-0.482777,-0.875743,0],[0,0,1]]],
	[["B_HMG_01_high_F",[11997.4,2478.19,0],[],0,"CAN_COLLIDE"], [[-0.927001,0.375058,0],[0,0,1]]],
	[["B_HMG_01_high_F",[12043.2,2392.39,-0.00235534],[],0,"CAN_COLLIDE"], [[-0.2171,-0.974795,-0.0514073],[0.0026744,-0.0532572,0.998577]]],
	[["B_HMG_01_high_F",[12158.5,2441.5,0],[],0,"CAN_COLLIDE"], [[-0.494033,-0.869443,0],[0,0,1]]]
];
{_x setSkill 1;} forEach (units _grp);//set skill

//units
{
	[format["%1%2",SEfort,_forEachIndex],_x,10,ceil(random 4) + 2,round(random 2) + 1,true,1800] call A3EAI_createCustomInfantryQueue;
} forEach [
	[12055.1,2426.89,0],
	[12032.9,2465.56,0],
	[12146.9,2518.64,0],
	[12145.9,2497.08,0],
	[12125.1,2473.99,0]
];

//crate
_crate_weapons = A3EAI_sniperList + ["arifle_Katiba_GL_F","arifle_MX_GL_F","arifle_MXM_khk_F","arifle_ARX_ghex_F","a2_dmr_epoch","srifle_GM6_F","srifle_DMR_04_F","srifle_DMR_05_tan_f","MultiGun"];
_crate_magazines = A3EAI_MiscLoot1 + A3EAI_MiscLoot2 + ["1Rnd_HE_Grenade_shell","3Rnd_HE_Grenade_shell","5Rnd_127x108_Mag","10Rnd_127x54_Mag","10Rnd_93x64_DMR_05_Mag","SatchelCharge_Remote_Mag","Laserbatteries"];
_crate_items = A3EAI_weaponOpticsList + ["optic_NVS","optic_Nightstalker","optic_LRPS","Repair_EPOCH","Heal_EPOCH","ItemGeigerCounter_EPOCH","radiation_mask_epoch"];
_num_weapons = 4;
_num_magazines = 10;
_num_items = 6;

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
	["I_supplyCrate_F",[12064.069,2457.625,4.3198032],[[6.2618566,4.2429647,0.0053377044],[0,0,1]]]
];

