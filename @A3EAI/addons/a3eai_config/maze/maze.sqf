/*
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
    
    L3G0 SQF Maze Generator  https://epochmod.com/forum/topic/30393-sqf-maze-generator/?do=findComment&comment=191592
*/

private ["_startPosition","_halfMetalFloorSize","_mazeHeight","_mazeWidth","_maze","_mazeStart","_mazeEnd","_mazeWalls","_mazeStartFloor","_x","_y","_object","_chamberConfig","_t1","_crate","_mazeBotGroup","_mazeBot_x","_mazeBot_y","_unit"];
diag_log "[Maze]: starting maze spawn waiting for generateMaze";

_halfMetalFloorSize = 2.64;
_mazeObjects = [];
_mazeWidth = 16;
_mazeHeight = 16;

_startPosition = _this;

diag_log format["[Maze] StartPos %1",_startPosition];
waitUntil {!isNil "blck_pvs_version"};

diag_log "[Maze] Start generator";
_t1 = diag_tickTime;
_maze = [_mazeWidth,_mazeHeight] call compile preprocessFileLineNumbers "A3EAI_config\maze\mazegen.sqf";
diag_log format["[Maze]: creating Maze of size %1 x %2 took %3 ms", _mazeWidth, _mazeHeight, (diag_tickTime - _t1)];

_mazeStart = _maze select 0;
_mazeEnd = _maze select 1;
_mazeWalls = _maze select 2;
//diag_log format["[Maze]: %1", _maze];

/* _mazeStartFloor = objNull;*/
/* attachTo needs enableSimulation true; :/
if (isNull _mazeStartFloor) then {
	_object setPos _startPosition;
	_mazeStartFloor = _object;
} else {
	_object attachTo [_mazeStartFloor, [_x * 2 * _halfMetalFloorSize, _y * 2 * _halfMetalFloorSize, 0]];
};
*/

for [{_y=0},{_y<_mazeHeight},{_y=_y+1}] do {
	for [{_x=0},{_x<_mazeWidth},{_x=_x+1}] do {
		_position = [(_startPosition select 0) + _x * 2 * _halfMetalFloorSize, (_startPosition select 1) + _y * 2 * _halfMetalFloorSize];
		/* create floor */
		if (surfaceIsWater _position) then {
			_object = createVehicle ["MetalFloor_EPOCH", [0, 0], [], 0, "CAN_COLLIDE"];
		} else {
			_object = createVehicle ["VR_Area_01_square_4x4_yellow_F", [0, 0], [], 0, "CAN_COLLIDE"];
		};
		_object addEventHandler ["HandleDamage", {false}];
		_object enableSimulation false;
		_object setPos _position;
		_mazeObjects set [count _mazeObjects,_object];
		
		/* create roof */
		_object = createVehicle ["MetalFloor_EPOCH", [0, 0], [], 0, "CAN_COLLIDE"];
		_object addEventHandler ["HandleDamage", {false}];
		_object enableSimulation false;
		_object setPos (_position + [3.0]);
		_mazeObjects set [count _mazeObjects,_object];
		
		/* create walls */
		_chamberConfig = _mazeWalls select (_x + _mazeWidth * _y);
		for [{_dir=1},{_dir<=8},{_dir=_dir*2}] do {
			_wallDir = 0;
			_wallPosition = [];

			switch (_dir) do { 
				case 1: { _wallPosition = [(_position select 0), (_position select 1) - _halfMetalFloorSize]; }; 
				case 2: { _wallPosition = [(_position select 0) + _halfMetalFloorSize, (_position select 1)]; _wallDir = 90;}; 
				case 4: { _wallPosition = [(_position select 0), (_position select 1) + _halfMetalFloorSize]; }; 
				case 8: { _wallPosition = [(_position select 0) - _halfMetalFloorSize, (_position select 1)]; _wallDir = 90;}; 
			};

			if (_chamberConfig % 2 == 1) then {
				_object = createVehicle ["CinderWall_EPOCH", [0,0], [], 0, "CAN_COLLIDE"];
				_object addEventHandler ["HandleDamage", {false}];
				_object enableSimulation false;
				_object setPos _wallPosition;
				_object setDir _wallDir;
				_mazeObjects set [count _mazeObjects,_object];
			};

			_chamberConfig = floor(_chamberConfig / 2);
		};
	};
};

/* BEGIN create start platform */
_mazeStartPlattformCenter_x = (_mazeStart select 0);
_mazeStartPlattformCenter_y = (_mazeStart select 1);

if (_mazeStartPlattformCenter_x <= 0 && _mazeStartPlattformCenter_y <= 0) then {
	_mazeStartPlattformCenter_x = _mazeStartPlattformCenter_x - 2;
	_mazeStartPlattformCenter_y = _mazeStartPlattformCenter_y - 2;
} else {
	if (_mazeStartPlattformCenter_x <= 0) then {
		_mazeStartPlattformCenter_x = _mazeStartPlattformCenter_x - 3;
	};
	if (_mazeStartPlattformCenter_y <= 0) then {
		_mazeStartPlattformCenter_y = _mazeStartPlattformCenter_y - 3;
	};
};

if (_mazeStartPlattformCenter_x >= (_mazeWidth - 1) && _mazeStartPlattformCenter_y >= (_mazeHeight - 1)) then {
	_mazeStartPlattformCenter_x = _mazeStartPlattformCenter_x + 2;
	_mazeStartPlattformCenter_y = _mazeStartPlattformCenter_y + 2;
} else {
	if (_mazeStartPlattformCenter_x >= (_mazeWidth - 1)) then {
		_mazeStartPlattformCenter_x = _mazeStartPlattformCenter_x + 3;
	};
	if (_mazeStartPlattformCenter_y >= (_mazeHeight - 1)) then {
		_mazeStartPlattformCenter_y = _mazeStartPlattformCenter_y + 3;
	};
};

for [{_y=-2},{_y<=2},{_y=_y+1}] do {
	for [{_x=-2},{_x<=2},{_x=_x+1}] do {
		_mazeStartPlattform_x = _mazeStartPlattformCenter_x + _x;
		_mazeStartPlattform_y = _mazeStartPlattformCenter_y + _y;
		if (_mazeStartPlattform_x >= _mazeWidth || _mazeStartPlattform_y >= _mazeHeight || _mazeStartPlattform_x < 0 || _mazeStartPlattform_y < 0) then {
			_position = [(_startPosition select 0) + _mazeStartPlattform_x * 2 * _halfMetalFloorSize, (_startPosition select 1) + _mazeStartPlattform_y * 2 * _halfMetalFloorSize];
			if (surfaceIsWater _position) then {
				_object = createVehicle ["MetalFloor_EPOCH", [0, 0], [], 0, "CAN_COLLIDE"];
			} else {
				_object = createVehicle ["VR_Area_01_square_4x4_yellow_F", [0, 0], [], 0, "CAN_COLLIDE"];
			};
			_object allowDammage false;
			_object enableSimulation false;
			_object setPos _position;
			//_mazeObjects set [count _mazeObjects,_object];
		};
	};
};
{ _x setVectorUp surfaceNormal position _x; } count _mazeObjects;
/* END create start platform */

/* BEGIN create safe */
_position = [(_startPosition select 0) + (_mazeEnd select 0) * 2 * _halfMetalFloorSize, (_startPosition select 1) + (_mazeEnd select 1) * 2 * _halfMetalFloorSize, 0];
_crate = [_position, "Box_IDAP_Equip_F"] call blck_fnc_spawnCrate;
[_crate, blck_BoxLoot_Green,blck_lootCountsOrange] call blck_fnc_fillBoxes;
_crate setVariable ["Crypto",200 + round(random 1000),true];
/* END create safe */

/* BEGIN spawn wai bots */
_mazeBotGroup = [] call blck_fnc_createGroup;
for "_i" from 1 to (_mazeWidth max _mazeHeight) do {
	_mazeBot_x = floor(random (_mazeWidth - 2)) + 1;
	_mazeBot_y = floor(random (_mazeHeight - 2)) + 1;
	_position = [(_startPosition select 0) + _mazeBot_x * 2 * _halfMetalFloorSize, (_startPosition select 1) + _mazeBot_y * 2 * _halfMetalFloorSize, 0.2];
	_unit = [_position,_mazeBotGroup,"red",[],format["H_%1_EPOCH",62 + round(random 7)],format["V_%1",ceil(random 5)],"","none", blck_Pistols, [], false] call blck_fnc_spawnUnit;
	_unit setPos _position;
	_unit forceSpeed 0;
	doStop _unit;
	_unit setUnitPos "UP";
	_unit disableAI "MOVE";
};
/* END spawn wai bots */


//wait for players
_position = [(_startPosition select 0) + _mazeWidth / 2 * _halfMetalFloorSize, (_startPosition select 1) + _mazeHeight / 2 * _halfMetalFloorSize];
_area = createMarker ["maze", _position];
_area setMarkerColor "ColorOrange";
_area setMarkerShape "RECTANGLE";
_area setMarkerBrush "Horizontal";
_area setMarkerSize [(_mazeWidth * _halfMetalFloorSize), (_mazeHeight * _halfMetalFloorSize)];
_dots = createMarker ["maze_dot", _position];
_dots setMarkerText "Maze";
_dots setMarkerType "mil_dot";
_dots setMarkerColor "ColorRed";

while { ({(alive _x) && (_x distance _crate <= (_mazeWidth * _halfMetalFloorSize * 1.42) )} count playableUnits) < 1 } do {
	sleep 7;
};

//activate AIs
{
	_x enableAI "MOVE";
	doStop _x;
	[_x] join grpNull;
} forEach (units _mazeBotGroup);
diag_log "[Maze]: someone in maze";

/* BEGIN spawn vehicle */
_position = [(_startPosition select 0) + _mazeStartPlattformCenter_x * 2 * _halfMetalFloorSize, (_startPosition select 1) + _mazeStartPlattformCenter_y * 2 * _halfMetalFloorSize, 0.2];
/* END spawn vehicle */
