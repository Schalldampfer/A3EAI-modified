/*
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

L3G0 SQF Maze Generator  https://epochmod.com/forum/topic/30393-sqf-maze-generator/
*/

private ["_mazeWidth","_mazeHeight","_mazeCurWidth","_mazeCurHeight","_mazeDir","_position","_mazeNewWidth","_mazeNewHeight","_mazeNewDir","_mazeDirArray"];
_mazeWidth = _this select 0;
_mazeHeight = _this select 1;

/* cleanup for another run */
mazeGlobalVisitArray = [];
mazeGlobalChamberArray = [];
mazeGlobalDistance = 0;
mazeGlobalMaxDistance = 0;
mazeGlobalMaxEndPoint = [];

/* don't run twice because this solution is not idempotent */
if (count mazeGlobalVisitArray > 0) exitWith { [[0,0],[0,0],[]] };

/* BEGIN Initialize */
mazeGlobalDistance = 0;
mazeGlobalMaxDistance = 0;

/* init arrays */
for [{_i=0},{_i<_mazeHeight*_mazeWidth},{_i=_i+1}] do {
	mazeGlobalVisitArray set [_i,0];
	mazeGlobalChamberArray set [_i,9];
};

/* find start on top or bottom */
if ((random 1) < 0.5) then {
	_mazeCurWidth = floor(random _mazeWidth);
	if ((random 1) < 0.5) then {
		_mazeCurHeight = 0;
		/* _mazeDir = 1; */
	} else {
		_mazeCurHeight = _mazeHeight - 1;
		/* _mazeDir = 4; */
	};
/* find start left or right */
} else {
	_mazeCurHeight = floor(random _mazeHeight);
	if ((random 1) < 0.5) then {
		_mazeCurWidth = 0;
		/* _mazeDir = 8; */
	} else {
		_mazeCurWidth = _mazeWidth - 1;
		/* _mazeDir = 2; */
	};
};
/* END Initialize */

_recurse = {
	private ["_mazeWidth","_mazeHeight","_mazeCurWidth","_mazeCurHeight","_mazeDir","_position","_mazeNewWidth","_mazeNewHeight","_mazeNewDir","_mazeDirArray"];
	_mazeWidth = _this select 0;
	_mazeHeight = _this select 1;
	_mazeCurWidth = _this select 2;
	_mazeCurHeight = _this select 3;
	_mazeDir = _this select 4;
	
	/* this should never happen */
	if (_mazeCurWidth < 0 || _mazeCurHeight < 0) exitWith { 
		diag_log format["negative position!!! %1 x %2", _mazeCurWidth, _mazeCurHeight];
		[[0,0],[0,0],[]]
	};

	_position = _mazeCurWidth + (_mazeWidth * _mazeCurHeight);
	mazeGlobalVisitArray set [_position,1];
	mazeGlobalDistance = mazeGlobalDistance + 1;

	/* remove entry walls */
	if (_mazeDir == 0) then {
		if (_mazeCurHeight == 0) then {
			mazeGlobalChamberArray set [_position,(mazeGlobalChamberArray select _position) - 1];
		};
		if (_mazeCurWidth == 0) then {
			mazeGlobalChamberArray set [_position,(mazeGlobalChamberArray select _position) - 8];
		};
	} else {
		if (_mazeDir == 4) then {
			mazeGlobalChamberArray set [_position,(mazeGlobalChamberArray select _position) - 1];
		};
		if (_mazeDir == 2) then {
			mazeGlobalChamberArray set [_position,(mazeGlobalChamberArray select _position) - 8];
		};
	};
	_mazeDirArray = [1,2,4,8];

	while {count _mazeDirArray > 0} do {
		/* diag_log format["%1 position loop %2", _position, count _mazeDirArray];*/
		_mazeNewWidth = _mazeCurWidth;
		_mazeNewHeight = _mazeCurHeight;
		
		/*
		_random = floor (random count _mazeDirArray);
		_mazeNewDir = _mazeDirArray select _random;
		_mazeDirArray set [_random, _mazeDirArray select ((count _mazeDirArray) - 1)];
		_mazeDirArray resize ((count _mazeDirArray) - 1);
		*/
		_mazeNewDir = _mazeDirArray call BIS_fnc_selectRandom;
		_mazeDirArray = _mazeDirArray - [_mazeNewDir];

		switch(_mazeNewDir) do {
			case 1: { _mazeNewHeight = _mazeNewHeight - 1; };
			case 2: { _mazeNewWidth = _mazeNewWidth + 1; };
			case 4: { _mazeNewHeight = _mazeNewHeight + 1; };
			case 8: { _mazeNewWidth = _mazeNewWidth - 1; };
		};

		/* invalid positions */
		if (_mazeNewWidth >= _mazeWidth || _mazeNewHeight >= _mazeHeight || _mazeNewWidth < 0 || _mazeNewHeight < 0) then {
			/* don't create wall if it is the start */
			if (_mazeDir != 0) then {
				/* add right line */
				if (_mazeNewWidth == _mazeWidth) then {
					mazeGlobalChamberArray set [_position,(mazeGlobalChamberArray select _position) + 2];
				};
				/* add bottom line */
				if (_mazeNewHeight == _mazeHeight) then {
					mazeGlobalChamberArray set [_position,(mazeGlobalChamberArray select _position) + 4];
				};
			} else {
				diag_log "prevent entrywall creation";
			};
		} else {
			/* diag_log format["%1 position %2", _position, _mazeNewDir]; */
			_mazeNewPosition = _mazeNewWidth + (_mazeWidth * _mazeNewHeight);
			/* diag_log format["new position %1 x %2 = %3", _mazeNewWidth, _mazeNewHeight, _mazeNewPosition]; */
			if ((mazeGlobalVisitArray select _mazeNewPosition) == 0) then {
				switch(_mazeNewDir) do {
					case 1: { mazeGlobalChamberArray set [_position,(mazeGlobalChamberArray select _position) - 1]; };
					case 8: { mazeGlobalChamberArray set [_position,(mazeGlobalChamberArray select _position) - 8]; };
				};
				[_mazeWidth,_mazeHeight,_mazeNewWidth,_mazeNewHeight,_mazeNewDir] call _recurse;
			};
		};
	};

	if (mazeGlobalDistance > mazeGlobalMaxDistance) then {
		mazeGlobalMaxEndPoint = [_mazeCurWidth,_mazeCurHeight];
		mazeGlobalMaxDistance = mazeGlobalDistance;
	};

	mazeGlobalDistance = mazeGlobalDistance -1;

	/* diag_log format["%1 reached end distance: %2", _position, mazeGlobalDistance]; */
};

[_mazeWidth,_mazeHeight,_mazeCurWidth,_mazeCurHeight,0] call _recurse;
/* generate return array */
_mazeReturnArray = [[_mazeCurWidth,_mazeCurHeight],mazeGlobalMaxEndPoint,mazeGlobalChamberArray];

/* cleanup for another run */
mazeGlobalVisitArray = [];
mazeGlobalChamberArray = [];
mazeGlobalDistance = 0;
mazeGlobalMaxDistance = 0;
mazeGlobalMaxEndPoint = [];

_mazeReturnArray
