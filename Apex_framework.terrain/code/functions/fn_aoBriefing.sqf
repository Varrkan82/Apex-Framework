/*
File: fn_aoBriefing.sqf
Author: 

	Quiksilver

Last modified: 

	9/06/2016 A3 1.61 by Quiksilver

Description:

	De-brief players and clear AO
______________________________________________*/

_type = _this select 0;
_ao = _this select 1;
_QS_AOpos = _this select 2;

diag_log str _ao;

if (_type isEqualTo 'BRIEF') then {
	missionNamespace setVariable ['QS_enemiesCaptured_AO',0,FALSE];
	{
		_x setMarkerPos _QS_AOpos;
	} forEach [
		'QS_marker_aoCircle',
		'QS_marker_aoMarker'
	];
	if (!((missionNamespace getVariable ['QS_missionConfig_playableOPFOR',0]) isEqualTo 0)) then {
		[objNull,_QS_AOpos] remoteExec ['QS_fnc_respawnOPFOR',[EAST,RESISTANCE],FALSE];
	};
	'QS_marker_aoMarker' setMarkerText (format ['%1Захопити %2',(toString [32,32,32]),_ao]);
	_targetStartText = parseText format [
		"<t align='center' size='2.2'>Нова цiль</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>Ми добре попрацювали на останнiй мiсiї. Я хочу знову побачити це. Рухайся до %1 та вбий їх всiх!<br/><br/>Не забудьте знищити радiовежу щоб припинити виклик пiдтримки з повiтря.",
		_ao
	];
	if (!(missionNamespace getVariable 'QS_mainao_firstRun')) then {
		//['hint',_targetStartText] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		['NewMain',[_ao]] remoteExec ['QS_fnc_showNotification',-2,FALSE];
		['NewSub',['Знищити радiовежу']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
	} else {
		missionNamespace setVariable ['QS_mainao_firstRun',FALSE,FALSE];
	};
	{
		_x setMarkerColor 'ColorOPFOR';
		_x setMarkerAlpha 0.8;
	} forEach [
		'QS_marker_hqCircle',
		'QS_marker_hqMarker',
		'QS_marker_aoCircle',
		'QS_marker_aoMarker',
		'QS_marker_radioCircle',
		'QS_marker_radioMarker'
	];
	if (!((missionNamespace getVariable 'QS_ao_aaMarkers') isEqualTo [])) then {
		{
			_x setMarkerColor 'ColorOPFOR';
			_x setMarkerAlpha 0.8;
		} count (missionNamespace getVariable 'QS_ao_aaMarkers');
	};
	if (!((missionNamespace getVariable 'QS_virtualSectors_sub_1_markers') isEqualTo [])) then {
		{
			_x setMarkerColor 'ColorOPFOR';
			_x setMarkerAlpha 0.5;
		} forEach (missionNamespace getVariable 'QS_virtualSectors_sub_1_markers');
	};
	if (!((missionNamespace getVariable 'QS_virtualSectors_sub_2_markers') isEqualTo [])) then {
		{
			_x setMarkerColor 'ColorOPFOR';
			_x setMarkerAlpha 0.5;
		} forEach (missionNamespace getVariable 'QS_virtualSectors_sub_2_markers');
	};
	if (!((missionNamespace getVariable 'QS_virtualSectors_sub_3_markers') isEqualTo [])) then {
		{
			_x setMarkerColor 'ColorOPFOR';
			_x setMarkerAlpha 0.5;
		} forEach (missionNamespace getVariable 'QS_virtualSectors_sub_3_markers');
	};	
	{
		_x call (missionNamespace getVariable 'BIS_fnc_setTask');
	} forEach [
		[
			'QS_IA_TASK_AO_2',
			TRUE,
			[
				'Взяти пiд контроль ворожий штаб, щоб погiршити координацiю противника. Завдання буде виконано коли ворожого командира буде вбито. Вiн, зазвичай, знаходиться в безпосереднiй близькостi вiд штабу. Завдання не є обов’язковим для завершення мiсiї, проте може бути корисним.',
				'Ворожий Штаб',
				'Захопити ворожий штаб'
			],
			(markerPos 'QS_marker_hqMarker'),
			'CREATED',
			5,
			FALSE,
			TRUE,
			'Attack',
			TRUE
		],
		[
			'QS_IA_TASK_AO_1',
			TRUE,
			[
				'Знищити ворожу радiо антену. Знищення радiо антени призведе до погiршення комунiкацiї противника, також ворог не зможе викликати повiтряну пiдтримку.',
				'Знищити радiо антену',
				'Знищити радiо антену'
			],
			(markerPos 'QS_marker_radioMarker'),
			'CREATED',
			5,
			FALSE,
			TRUE,
			'Destroy',
			TRUE
		],
		[
			'QS_IA_TASK_AO_0',
			TRUE,
			[
				'Очистити зазначену зону. Пiсля того, як в цiй областi залишиться менше 10 ворогiв i бiльше не буде додаткових завдань, це завдання буде закiнчено.',
				(format ['Захопити %1',_ao]),
				(format ['Захопити %1',_ao])
			],
			_QS_AOpos,
			'ASSIGNED',
			5,
			FALSE,
			TRUE,
			'X',
			TRUE
		]
	];	
};
if (_type isEqualTo 'DEBRIEF') then {
	['QS_IA_TASK_AO_0'] call (missionNamespace getVariable 'BIS_fnc_deleteTask');
	_targetCompleteText = parseText format ["<t align='center' size='2.2'>Цiль захоплено</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/><t align='left'>Гарне захоплення %1, солдати!<br/><br/>Вороги ув’язненi: %2</t>",(_ao select 0),(missionNamespace getVariable 'QS_enemiesCaptured_AO')];
	//['hint',_targetCompleteText] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
	missionNamespace setVariable ['QS_evacPosition_1',_QS_AOpos,TRUE];
	{
		_x setMarkerAlpha 0;
	} forEach [
		'QS_marker_aoCircle',
		'QS_marker_aoMarker',
		'QS_marker_radioCircle',
		'QS_marker_radioMarker'
	];
	'QS_marker_aoMarker' setMarkerText (format ['%1',(toString [32,32,32])]);
	{
		_x setMarkerAlpha 0;
		_x setMarkerColor 'ColorOPFOR';
	} forEach [
		'QS_marker_hqMarker',
		'QS_marker_hqCircle'
	];
	if (!((missionNamespace getVariable 'QS_virtualSectors_sub_1_markers') isEqualTo [])) then {
		{
			_x setMarkerAlpha 0;
		} forEach (missionNamespace getVariable 'QS_virtualSectors_sub_1_markers');
	};
	if (!((missionNamespace getVariable 'QS_virtualSectors_sub_2_markers') isEqualTo [])) then {
		{
			_x setMarkerAlpha 0;
		} forEach (missionNamespace getVariable 'QS_virtualSectors_sub_2_markers');
	};
	if (!((missionNamespace getVariable 'QS_virtualSectors_sub_3_markers') isEqualTo [])) then {
		{
			_x setMarkerAlpha 0;
		} forEach (missionNamespace getVariable 'QS_virtualSectors_sub_3_markers');
	};
	['CompletedMain',[(_ao select 0)]] remoteExec ['QS_fnc_showNotification',-2,FALSE];
};
