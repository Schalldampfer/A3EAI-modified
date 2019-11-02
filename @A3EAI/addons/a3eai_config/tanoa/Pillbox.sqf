private ["_crate_type","_crate_weapons","_crate_magazines","_crate_items","_num_weapons","_num_magazines","_num_items"];

diag_log "[AI city] Pillbox spawn points & crates";

//Pillboxes
{
	[format["%1%2",typeOf _x,_forEachIndex],getPos _x,50,ceil(random 3),round(random 2),true,3600] call A3EAI_createCustomInfantryQueue;
} forEach ([worldSize/2,worldSize/2,0] nearObjects ["BagBunker_base_F",worldSize]);//"Cargo_House_base_F"


//crate
_crate_type = "Box_Syndicate_Ammo_F";
_crate_weapons = A3EAI_sniperList + A3EAI_machinegunList;
_crate_magazines = A3EAI_MiscLoot1 + A3EAI_MiscLoot2;
_crate_items = A3EAI_weaponOpticsList + ["optic_NVS","optic_Nightstalker","optic_LRPS","Repair_EPOCH","Heal_EPOCH","ItemGeigerCounter_EPOCH","radiation_mask_epoch"];
_num_weapons = 3;
_num_magazines = 8;
_num_items = 4;

[_crate_type, [11341.7,6606.06,121.637], [[-0.7639,0.645335,0],[0,0,1]], [_crate_weapons, _num_weapons], [_crate_magazines, _num_magazines], [_crate_items, _num_items]] call AIcity_spawn_crate;
[_crate_type, [7303.16,12817.9,123.234], [[-0.758337,-0.463238,-0.458623],[-0.529389,0.0271321,0.847945]], [_crate_weapons, _num_weapons], [_crate_magazines, _num_magazines], [_crate_items, _num_items]] call AIcity_spawn_crate;
[_crate_type, [2910.36,7166.65,44.6568], [[0.672971,0.684074,-0.281341],[0.113159,0.280666,0.953111]], [_crate_weapons, _num_weapons], [_crate_magazines, _num_magazines], [_crate_items, _num_items]] call AIcity_spawn_crate;

