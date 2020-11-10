/*/
File: fn_clientInteractSecure.sqf
Author:

	Quiksilver
	
Last modified:

	8/05/2017 A3 1.68 by Quiksilver
	
Description:

	Action Secure
__________________________________________________/*/

(_this select 3) params [
	'_cursorTarget',
	'_cursorObject'
];

if ((cameraOn distance _cursorObject) > 25) exitWith {
	50 cutText ['Занадто далеко','PLAIN DOWN',0.25];
};
if (((!isNil {_cursorTarget getVariable 'QS_secured'}) && (_cursorTarget getVariable 'QS_secured')) || ((!isNil {_cursorObject getVariable 'QS_secured'}) && (_cursorObject getVariable 'QS_secured'))) exitWith {
	50 cutText ['Вже знешкоджено','PLAIN DOWN',0.75];
};
if (!isNil {_cursorTarget getVariable 'QS_secureable'}) then {
	for '_x' from 0 to 2 step 1 do {
		_cursorTarget setVariable ['QS_secured',TRUE,TRUE];
		_cursorTarget setVariable ['QS_secureable',FALSE,TRUE];
	};
};
if (!isNil {_cursorObject getVariable 'QS_secureable'}) then {
	for '_x' from 0 to 2 step 1 do {
		_cursorObject setVariable ['QS_secured',TRUE,TRUE];
		_cursorObject setVariable ['QS_secureable',FALSE,TRUE];
	};
};
if (!isNil {_cursorTarget getVariable 'QS_isExplosion'}) then {
	_soundPath = [(str missionConfigFile),0,-15] call (missionNamespace getVariable 'BIS_fnc_trimString');
	_soundToPlay = _soundPath + 'media\audio\activate_mine.wss';
	playSound3D [_soundToPlay,player,FALSE,(getPosASL _cursorTarget),5,1,75];
};
if (!isNil {_cursorTarget getVariable 'QS_object_GT_0'}) exitWith {
	player playAction 'PutDown';
	50 cutText ['Мiсце розмiщення iнформацiї додано на мапу','PLAIN DOWN',0.75];
	['sideChat',[WEST,'BLU'],(format ['%1 встановив пристрiй вiдслiжування в %2 (перевiрте мапу)!',(groupID (group player)),(['Kavala','Georgetown'] select (worldName isEqualTo 'Tanoa'))])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
	[71,_cursorTarget,TRUE] remoteExecCall ['QS_fnc_remoteExec',2,FALSE];
};
if (!isNil {_cursorObject getVariable 'QS_object_GT_0'}) exitWith {
	player playAction 'PutDown';
	50 cutText ['Мiсце розмiщення iнформацiї додано на мапу','PLAIN DOWN',0.75];
	['sideChat',[WEST,'BLU'],(format ['%1 встановив пристрiй вiдслiжування в %2 (перевiрте мапу)!',(groupID (group player)),(['Kavala','Georgetown'] select (worldName isEqualTo 'Tanoa'))])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
	[71,_cursorObject,TRUE] remoteExecCall ['QS_fnc_remoteExec',2,FALSE];
};
if (!isNil {_cursorTarget getVariable 'QS_object_GT_1'}) exitWith {
	player playAction 'PutDown';
	50 cutText ['Информацiю захоплено','PLAIN DOWN',0.75];
	['systemChat',(format ['%1 захопив планшет з iнформацiєю в %2',(groupID (group player)),(['Kavala','Georgetown'] select (worldName isEqualTo 'Tanoa'))])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
	[71,_cursorTarget,TRUE] remoteExecCall ['QS_fnc_remoteExec',2,FALSE];
};
if (!isNil {_cursorObject getVariable 'QS_object_GT_1'}) exitWith {
	player playAction 'PutDown';
	50 cutText ['Intel secured','PLAIN DOWN',0.75];
	['systemChat',(format ['%1 захопив планшет з iнформацiєю в %2',(groupID (group player)),(['Kavala','Georgetown'] select (worldName isEqualTo 'Tanoa'))])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
	[71,_cursorObject,TRUE] remoteExecCall ['QS_fnc_remoteExec',2,FALSE];
};
if (!isNil {_cursorTarget getVariable 'QS_sc_subObj_1'}) exitWith {
	player playAction 'PutDown';
	50 cutText ['Додатковй об’єкт зачищено','PLAIN DOWN',0.75];
	['sideChat',[WEST,'BLU'],(format ['%1 зачистив ворожий Центр зв’зку',(groupID (group player))])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
	[73,1] remoteExec ['QS_fnc_remoteExec',2,FALSE];
};
if (!isNil {_cursorObject getVariable 'QS_sc_subObj_1'}) exitWith {
	player playAction 'PutDown';
	50 cutText ['Додатковй об’єкт зачищено','PLAIN DOWN',0.75];
	['sideChat',[WEST,'BLU'],(format ['%1 зачистив ворожий Центр зв’зку',(groupID (group player))])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
	[73,1] remoteExec ['QS_fnc_remoteExec',2,FALSE];
};
if (!isNil {_cursorTarget getVariable 'QS_sc_subObj_3'}) exitWith {
	player playAction 'PutDown';
	50 cutText ['Додатковй об’єкт зачищено','PLAIN DOWN',0.75];
	['sideChat',[WEST,'BLU'],(format ['%1 зачистив ворожий склад постачання',(groupID (group player))])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
	[73,3] remoteExec ['QS_fnc_remoteExec',2,FALSE];
};
if (!isNil {_cursorObject getVariable 'QS_sc_subObj_3'}) exitWith {
	player playAction 'PutDown';
	50 cutText ['Додатковй об’єкт зачищено','PLAIN DOWN',0.75];
	['sideChat',[WEST,'BLU'],(format ['%1 зачистив ворожий склад постачання',(groupID (group player))])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
	[73,3] remoteExec ['QS_fnc_remoteExec',2,FALSE];
};
player playAction 'PutDown';
['sideChat',[WEST,'BLU'],(format ['%1 зачистив об’єкт!',(groupID (group player))])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
50 cutText ['Захоплено','PLAIN DOWN',0.75];
missionNamespace setVariable ['QS_smSuccess',TRUE,TRUE];
TRUE;
