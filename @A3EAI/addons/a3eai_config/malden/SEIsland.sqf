private ["_crate_weapons","_crate_magazines","_crate_items","_num_weapons","_num_magazines","_num_items"];

diag_log "[AI city] SE Island spawn points & crates";

//crate
_crate_weapons = A3EAI_sniperList + A3EAI_machinegunList;
_crate_magazines = A3EAI_MiscLoot1 + A3EAI_MiscLoot2 + ["SatchelCharge_Remote_Mag","Laserbatteries"];
_crate_items = A3EAI_weaponOpticsList + ["CUP_optic_GOSHAWK","CUP_optic_NSPU","CUP_optic_PSO_3","CUP_optic_AN_PVS_4_M16","CUP_optic_AN_PVS_4_M14","CUP_optic_LeupoldMk4","CUP_optic_SB_11_4x20_PM","CUP_optic_SB_3_12x50_PMII","CUP_optic_LeupoldMk4_25x50_LRT","Repair_EPOCH","Heal_EPOCH","ItemGeigerCounter_EPOCH","Repair_EPOCH","Heal_EPOCH","radiation_mask_epoch"];
_num_weapons = 4;
_num_magazines = 10;
_num_items = 4;

["Box_FIA_Support_F", [9753.2,3902.57,0], [[0,1,0],[0,0,1]], [_crate_weapons, _num_weapons], [_crate_magazines, _num_magazines], [_crate_items, _num_items]] call AIcity_spawn_crate;
["Box_FIA_Wps_F", [11612.2,4448.66,0], [[-0.621138,0.783701,0],[0,0,1]], [_crate_weapons, _num_weapons], [_crate_magazines, _num_magazines], [_crate_items, _num_items]] call AIcity_spawn_crate;

//Static Weapons
[
	[["CUP_I_DSHKM_TK_GUE",[10523,4105.63,3.68015],[],0,"CAN_COLLIDE"], [[-0.396122,-0.918198,0],[0,0,1]]],
	[["CUP_I_DSHKM_TK_GUE",[11651.3,4436.62,3.68],[],0,"CAN_COLLIDE"], [[-0.124353,0.992238,0],[0,0,1]]]
] call AIcity_spawn_manStatic;

[
	//SE Island Center
	[["I_E_Radar_System_01_F",[10532.2,4053.03,0],[],0,"CAN_COLLIDE"], [[-0.321554,-0.946871,0.00617332],[0.0191948,0,0.999816]]]
] call AIcity_spawn_autoStatic;

//Vehicle patrol
["SEI_eastPatrol",[11682.1,4484.98,0],"CUP_I_Hilux_armored_BTR60_TK",100,[2,1],2,false,0] call A3EAI_createCustomVehicleQueue;
["SEI_westPatrol",[10092.4,3997.26,0],"CUP_I_Hilux_btr60_TK",200,[2,1],2,false,0] call A3EAI_createCustomVehicleQueue;
["SEI_aaPatrol",[10122.8,3999.33,0],"CUP_I_Datsun_AA_Random",200,[0,1],2,false,0] call A3EAI_createCustomVehicleQueue;

//Infantry patrol
["SEI_east1",[11602,4443.6,3.93753],20,round(random 3)+6,round(random 2),false,0] call A3EAI_createCustomInfantryQueue;
["SEI_east2",[11648.3,4437.79,0.185],20,round(random 3)+6,round(random 2),false,0] call A3EAI_createCustomInfantryQueue;
["SEI_east3",[11607.6,4484.26,0],20,round(random 3)+2,round(random 2)+1,false,0] call A3EAI_createCustomInfantryQueue;
["SEI_west1",[9785.1,3896.06,3.93763],20,round(random 3)+6,round(random 2),false,0] call A3EAI_createCustomInfantryQueue;
["SEI_west2",[9771.53,3869.09,3.938],20,round(random 3)+6,round(random 2),false,0] call A3EAI_createCustomInfantryQueue;
["SEI_west3",[9782.53,3929.55,0.320999],20,round(random 3)+2,round(random 2)+1,false,0] call A3EAI_createCustomInfantryQueue;
