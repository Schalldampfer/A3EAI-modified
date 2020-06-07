private ["_grp","_crate_type","_crate_pos","_crate_dirAndUp","_crate_weapons","_crate_magazines","_crate_items","_num_weapons","_num_magazines","_num_items"];

//Static Weapons
[
	//[["B_static_AT_F",[12035.1,2431.72,-2.38419e-006],[],0,"CAN_COLLIDE"], [[-0.853766,-0.520652,0.00226419],[0.00265199,0,0.999996]]],
	//[["B_static_AT_F",[12186.5,2535.48,0],[],0,"CAN_COLLIDE"], [[0.964527,-0.263986,0],[0,0,1]]],
	//[["B_static_AT_F",[12016.3,2575.15,0],[],0,"CAN_COLLIDE"], [[-0.795794,0.605568,0],[0,0,1]]],
	//[["B_static_AA_F",[12135.6,2507.06,0],[],0,"CAN_COLLIDE"], [[0.522174,0.852839,0],[0,0,1]]],
	//[["B_static_AA_F",[12128.6,2516.4,0],[],0,"CAN_COLLIDE"], [[0.999747,0.022503,0],[0,0,1]]],
	//[["B_static_AA_F",[12112.4,2504.06,0],[],0,"CAN_COLLIDE"], [[-0.573876,0.818942,0],[0,0,1]]],
	//[["B_static_AA_F",[12036.6,2465.73,0],[],0,"CAN_COLLIDE"], [[-0.992997,0.118142,0],[0,0,1]]],
	//[["B_static_AA_F",[12049.9,2437.2,0],[],0,"CAN_COLLIDE"], [[-0.787191,-0.616709,0],[0,0,1]]],
	[["I_GMG_01_high_F",[12055.1,2426.89,4.76837e-007],[],0,"CAN_COLLIDE"], [[-0.189876,-0.981808,0],[0,0,1]]],
	[["I_GMG_01_high_F",[12032.9,2465.56,4.76837e-007],[],0,"CAN_COLLIDE"], [[-0.956382,0.292119,0],[0,0,1]]],
	[["I_GMG_01_high_F",[12146.9,2518.64,4.76837e-007],[],0,"CAN_COLLIDE"], [[0.630638,0.776077,0],[0,0,1]]],
	[["I_GMG_01_high_F",[12145.9,2497.08,0.00842953],[],0,"CAN_COLLIDE"], [[0.492774,-0.869336,0.0378034],[0.0627533,0.0788351,0.994911]]],
	[["I_GMG_01_high_F",[12125.1,2473.99,4.76837e-007],[],0,"CAN_COLLIDE"], [[0.333662,0.942693,0],[0,0,1]]],
	[["I_HMG_02_high_F",[12201.3,2449.99,0],[],0,"CAN_COLLIDE"], [[0.918129,-0.396281,0],[0,0,1]]],
	[["I_HMG_02_high_F",[12184.1,2490.07,0],[],0,"CAN_COLLIDE"], [[0.526247,0.850332,0],[0,0,1]]],
	[["I_HMG_02_high_F",[12144.1,2573.21,0],[],0,"CAN_COLLIDE"], [[-0.794685,0.607023,0],[0,0,1]]],
	[["I_HMG_02_high_F",[12070.6,2559.3,0],[],0,"CAN_COLLIDE"], [[0.821772,0.569817,0],[0,0,1]]],
	[["I_HMG_02_high_F",[12035.3,2519.48,0],[],0,"CAN_COLLIDE"], [[-0.482777,-0.875743,0],[0,0,1]]],
	[["I_HMG_02_high_F",[11997.4,2478.19,0],[],0,"CAN_COLLIDE"], [[-0.927001,0.375058,0],[0,0,1]]],
	[["I_HMG_02_high_F",[12043.2,2392.39,-0.00235534],[],0,"CAN_COLLIDE"], [[-0.2171,-0.974795,-0.0514073],[0.0026744,-0.0532572,0.998577]]],
	[["I_HMG_02_high_F",[12158.5,2441.5,0],[],0,"CAN_COLLIDE"], [[-0.494033,-0.869443,0],[0,0,1]]]
] call AIcity_spawn_manStatic;

//units
{
	[format["%1%2","SEfort",_forEachIndex],_x,10,ceil(random 4) + 2,round(random 2) + 1,true,1800] call A3EAI_createCustomInfantryQueue;
} forEach [
	[12085.781,2426.626],
	[12072.609,2461.878],
	[12061.500,2515.066],
	[12105.750,2458.587],
	[12098.734,2503.298],
	[12136.812,2486.683],
	[12124.234,2533.441],
	[12158.625,2458.618]
];

//crate
_crate_type = "I_supplyCrate_F";
_crate_pos = [12063.9,2457.53,4.3205];
_crate_dirAndUp = [[6.2618566,4.2429647,0.0053377044],[0,0,1]];
_crate_weapons = A3EAI_sniperList;
_crate_magazines = A3EAI_MiscLoot1 + A3EAI_MiscLoot2 + ["SatchelCharge_Remote_Mag","Laserbatteries"];
_crate_items = A3EAI_weaponOpticsList + ["CUP_optic_CWS","CUP_optic_GOSHAWK","CUP_optic_AN_PVS_10_black","CUP_optic_AN_PAS_13c1","CUP_optic_AN_PAS_13c2","Repair_EPOCH","Heal_EPOCH","ItemGeigerCounter_EPOCH","radiation_mask_epoch"];
_num_weapons = 4;
_num_magazines = 10;
_num_items = 6;

[_crate_type, _crate_pos, _crate_dirAndUp, [_crate_weapons, _num_weapons], [_crate_magazines, _num_magazines], [_crate_items, _num_items]] call AIcity_spawn_crate;

["APERSMineDispenser_Mine_F",[12065.1,2458.16,0]] call AIcity_spawn_mine;
