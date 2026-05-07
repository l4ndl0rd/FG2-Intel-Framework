/*
    FG2 - Completion Effects
    SERVER ONLY

    Purpose:
        Registers server-side completion effect handlers.

    Device variables:
        fg2_onCompleteEvent = "EVENT_NAME";
        fg2_onCompleteArgs  = [];

    Handler payload:
        [_device, _jobId, _args]
*/

if (!isServer) exitWith {};

if (missionNamespace getVariable ["fg2_completionEffectsInitialized", false]) exitWith {
    ["WARN", "Completion effects already initialized"] call fg2_fnc_log;
};

missionNamespace setVariable ["fg2_completionEffectsInitialized", true, true];

/*
    Deletes an object globally.

    If no target object is passed in fg2_onCompleteArgs,
    the device itself will be deleted.

    fg2_onCompleteArgs format:
        []
        OR
        [targetObject]

    Example - delete the device itself:
        this setVariable ["fg2_onCompleteEvent", "fg2_completion_deleteObject", true];
        this setVariable ["fg2_onCompleteArgs", [], true];

    Example - delete another object:
        this setVariable ["fg2_onCompleteEvent", "fg2_completion_deleteObject", true];
        this setVariable ["fg2_onCompleteArgs", [fg2_target_vehicle_1], true];
*/
["fg2_completion_deleteObject", {
    params ["_device", "_jobId", ["_args", []]];

    private _target = _args param [0, _device];

    if (isNull _target) exitWith {
        ["WARN", "Completion effect deleteObject ignored. Target is null. Device: %1. Job: %2. Args: %3", [_device, _jobId, _args]] call fg2_fnc_log;
    };

    ["INFO", "Completion effect deleteObject executed. Device: %1. Target: %2. Job: %3", [_device, _target, _jobId]] call fg2_fnc_log;

    deleteVehicle _target;

}] call CBA_fnc_addEventHandler;

/*
    Destroys an object by setting damage to 1.

    If no target object is passed in fg2_onCompleteArgs,
    the device itself will be destroyed.

    fg2_onCompleteArgs format:
        []
        OR
        [targetObject]

    Example - destroy the device itself:
        this setVariable ["fg2_onCompleteEvent", "fg2_completion_destroyObject", true];
        this setVariable ["fg2_onCompleteArgs", [], true];

    Example - destroy another object:
        this setVariable ["fg2_onCompleteEvent", "fg2_completion_destroyObject", true];
        this setVariable ["fg2_onCompleteArgs", [fg2_target_vehicle_1], true];
*/
["fg2_completion_destroyObject", {
    params ["_device", "_jobId", ["_args", []]];

    private _target = _args param [0, _device];

    if (isNull _target) exitWith {
        ["WARN", "Completion effect destroyObject ignored. Target is null. Device: %1. Job: %2. Args: %3", [_device, _jobId, _args]] call fg2_fnc_log;
    };

    ["INFO", "Completion effect destroyObject executed. Device: %1. Target: %2. Job: %3", [_device, _target, _jobId]] call fg2_fnc_log;

    _target setDamage 1;

}] call CBA_fnc_addEventHandler;

/*
    Hides an object globally and disables its simulation.

    If no target object is passed in fg2_onCompleteArgs,
    the device itself will be hidden.

    fg2_onCompleteArgs format:
        []
        OR
        [targetObject]

    Example - hide the device itself:
        this setVariable ["fg2_onCompleteEvent", "fg2_completion_hideObjectGlobal", true];
        this setVariable ["fg2_onCompleteArgs", [], true];

    Example - hide another object:
        this setVariable ["fg2_onCompleteEvent", "fg2_completion_hideObjectGlobal", true];
        this setVariable ["fg2_onCompleteArgs", [fg2_target_vehicle_1], true];
*/
["fg2_completion_hideObjectGlobal", {
    params ["_device", "_jobId", ["_args", []]];

    private _target = _args param [0, _device];

    if (isNull _target) exitWith {
        ["WARN", "Completion effect hideObjectGlobal ignored. Target is null. Device: %1. Job: %2. Args: %3", [_device, _jobId, _args]] call fg2_fnc_log;
    };

    ["INFO", "Completion effect hideObjectGlobal executed. Device: %1. Target: %2. Job: %3", [_device, _target, _jobId]] call fg2_fnc_log;

    _target hideObjectGlobal true;
    _target enableSimulationGlobal false;

}] call CBA_fnc_addEventHandler;

/*
    Sets a variable on an object.

    If no target object is passed, the variable will be set on the device itself.

    fg2_onCompleteArgs format:
        ["variableName", value, public]
        OR
        [targetObject, "variableName", value, public]

    Example - set variable on the device itself:
        this setVariable ["fg2_onCompleteEvent", "fg2_completion_setVariable", true];
        this setVariable ["fg2_onCompleteArgs", ["fg2_terminalCompleted", true, true], true];

    Example - set variable on another object:
        this setVariable ["fg2_onCompleteEvent", "fg2_completion_setVariable", true];
        this setVariable ["fg2_onCompleteArgs", [fg2_target_vehicle_1, "fg2_unlockedByIntel", true, true], true];
*/
["fg2_completion_setVariable", {
    params ["_device", "_jobId", ["_args", []]];

    private _target = _device;
    private _offset = 0;

    private _firstArg = _args param [0, objNull];

    if (_firstArg isEqualType objNull) then {
        _target = _firstArg;
        _offset = 1;
    };

    if (isNull _target) exitWith {
        ["WARN", "Completion effect setVariable ignored. Target is null. Device: %1. Job: %2. Args: %3", [_device, _jobId, _args]] call fg2_fnc_log;
    };

    private _varName = _args param [_offset, "", [""]];
    private _varValue = _args param [_offset + 1, nil];
    private _public = _args param [_offset + 2, true, [true]];

    if (_varName isEqualTo "") exitWith {
        ["ERROR", "Completion effect setVariable failed. Missing variable name. Device: %1. Target: %2. Job: %3. Args: %4", [_device, _target, _jobId, _args]] call fg2_fnc_log;
    };

    _target setVariable [_varName, _varValue, _public];

    ["INFO", "Completion effect setVariable executed. Device: %1. Target: %2. Job: %3. Variable: %4", [_device, _target, _jobId, _varName]] call fg2_fnc_log;

}] call CBA_fnc_addEventHandler;

/*
    Reveals a marker globally by changing its alpha.

    fg2_onCompleteArgs format:
        ["markerName"]
        OR
        ["markerName", alpha]

    Example - reveal marker fully:
        this setVariable ["fg2_onCompleteEvent", "fg2_completion_revealMarker", true];
        this setVariable ["fg2_onCompleteArgs", ["fg2_marker_intelCache_1"], true];

    Example - reveal marker with custom alpha:
        this setVariable ["fg2_onCompleteEvent", "fg2_completion_revealMarker", true];
        this setVariable ["fg2_onCompleteArgs", ["fg2_marker_intelCache_1", 0.75], true];

    Editor setup:
        Create marker and set Alpha to 0.
*/
["fg2_completion_revealMarker", {
    params ["_device", "_jobId", ["_args", []]];

    private _markerName = _args param [0, "", [""]];
    private _alpha = _args param [1, 1, [0]];

    if (_markerName isEqualTo "") exitWith {
        ["ERROR", "Completion effect revealMarker failed. Missing marker name. Device: %1. Job: %2. Args: %3", [_device, _jobId, _args]] call fg2_fnc_log;
    };

    if ((getMarkerColor _markerName) isEqualTo "") exitWith {
        ["ERROR", "Completion effect revealMarker failed. Marker does not exist: %1. Device: %2. Job: %3", [_markerName, _device, _jobId]] call fg2_fnc_log;
    };

    _alpha = _alpha max 0 min 1;

    _markerName setMarkerAlpha _alpha;

    ["INFO", "Completion effect revealMarker executed. Device: %1. Marker: %2. Alpha: %3. Job: %4", [_device, _markerName, _alpha, _jobId]] call fg2_fnc_log;

}] call CBA_fnc_addEventHandler;

/*
    Executes a custom SQF script.

    Script executes SERVER-SIDE.

    fg2_onCompleteArgs format:
        ["pathToScript"]
        OR
        ["pathToScript", customArgs]

    Script receives:
        [_device, _jobId, customArgs]

    Example - execute simple script:
        this setVariable ["fg2_onCompleteEvent", "fg2_completion_executeScript", true];
        this setVariable ["fg2_onCompleteArgs", ["scripts\myScript.sqf"], true];

    Example - execute script with arguments:
        this setVariable ["fg2_onCompleteEvent", "fg2_completion_executeScript", true];
        this setVariable [
            "fg2_onCompleteArgs",
            [
                "scripts\unlockObjective.sqf",
                [fg2_target_vehicle_1, true]
            ],
            true
        ];
*/
["fg2_completion_executeScript", {
    params ["_device", "_jobId", ["_args", []], ["_player", objNull], ["_playerUID", ""]];

    private _scriptPath = _args param [0, "", [""]];
    private _customArgs = _args param [1, [], [[]]];

    if (_scriptPath isEqualTo "") exitWith {
        ["ERROR", "Completion effect executeScript failed. Missing script path. Device: %1. Job: %2. Args: %3", [_device, _jobId, _args]] call fg2_fnc_log;
    };

    if !(fileExists _scriptPath) exitWith {
        ["ERROR", "Completion effect executeScript failed. Script does not exist: %1. Device: %2. Job: %3", [_scriptPath, _device, _jobId]] call fg2_fnc_log;
    };

    ["INFO", "Completion effect executeScript executed. Script: %1. Device: %2. Job: %3", [_scriptPath, _device, _jobId]] call fg2_fnc_log;

    [_device, _jobId, _customArgs, _player, _playerUID] execVM _scriptPath;

}] call CBA_fnc_addEventHandler;

/*
    Unlocks a door on a building/object.

    Target can be:
        - object
        - marker name
        - position array

    fg2_onCompleteArgs format:
        [targetObject, doorIndex]
        OR
        [targetObject, doorIndex, animateDoor]
        OR
        ["markerName", doorIndex]
        OR
        ["markerName", doorIndex, animateDoor]
        OR
        [[x,y,z], doorIndex]
        OR
        [[x,y,z], doorIndex, animateDoor]

    If no valid target is passed, nearestBuilding _device is used.

    doorIndex:
        1 = Door_1
        2 = Door_2
        etc.

    animateDoor:
        true  - unlock and open the door
        false - only unlock the door

    Example - unlock Door_1 of nearest building to marker:
        this setVariable ["fg2_onCompleteEvent", "fg2_completion_unlockDoor", true];
        this setVariable ["fg2_onCompleteArgs", ["fg2_marker_targetBuilding_1", 1], true];

    Example - unlock and open Door_2 of nearest building to marker:
        this setVariable ["fg2_onCompleteEvent", "fg2_completion_unlockDoor", true];
        this setVariable ["fg2_onCompleteArgs", ["fg2_marker_targetBuilding_1", 2, true], true];

    Example - unlock Door_1 of nearest building to the device:
        this setVariable ["fg2_onCompleteEvent", "fg2_completion_unlockDoor", true];
        this setVariable ["fg2_onCompleteArgs", [], true];
*/
["fg2_completion_unlockDoor", {
    params ["_device", "_jobId", ["_args", []]];

    private _targetArg = _args param [0, objNull];
    private _doorIndex = _args param [1, 1, [0]];
    private _animateDoor = _args param [2, false, [true]];

    private _target = objNull;

    if (_targetArg isEqualType objNull) then {
        _target = _targetArg;
    };

    if (_targetArg isEqualType "") then {
        if ((getMarkerColor _targetArg) isEqualTo "") exitWith {
            ["ERROR", "Completion effect unlockDoor failed. Marker does not exist: %1. Device: %2. Job: %3", [_targetArg, _device, _jobId]] call fg2_fnc_log;
        };

        _target = nearestBuilding (getMarkerPos _targetArg);
    };

    if (_targetArg isEqualType []) then {
        _target = nearestBuilding _targetArg;
    };

    if (isNull _target) then {
        _target = nearestBuilding _device;
    };

    if (isNull _target) exitWith {
        ["WARN", "Completion effect unlockDoor ignored. No target building found. Device: %1. Job: %2. Args: %3", [_device, _jobId, _args]] call fg2_fnc_log;
    };

    if (_doorIndex < 1) exitWith {
        ["ERROR", "Completion effect unlockDoor failed. Invalid door index: %1. Device: %2. Target: %3. Job: %4", [_doorIndex, _device, _target, _jobId]] call fg2_fnc_log;
    };

    private _doorVar = format ["bis_disabled_Door_%1", _doorIndex];
    private _doorAnim = format ["Door_%1_rot", _doorIndex];

    _target setVariable [_doorVar, 0, true];

    if (_animateDoor) then {
        _target animateSource [_doorAnim, 1, true];
    };

    ["INFO", "Completion effect unlockDoor executed. Device: %1. Target: %2. Door: %3. Opened: %4. Job: %5", [_device, _target, _doorIndex, _animateDoor, _jobId]] call fg2_fnc_log;

}] call CBA_fnc_addEventHandler;

/*
    Triggers another CBA global event.

    fg2_onCompleteArgs format:
        ["eventName", eventArgs]

    Example - trigger a custom mission event:
        this setVariable ["fg2_onCompleteEvent", "fg2_completion_globalEvent", true];
        this setVariable ["fg2_onCompleteArgs", ["fg2_mission_intelDownloaded", []], true];

    Example - pass target object and state:
        this setVariable ["fg2_onCompleteEvent", "fg2_completion_globalEvent", true];
        this setVariable ["fg2_onCompleteArgs", ["fg2_unlockVehicle", [fg2_target_vehicle_1, true]], true];

    Matching receiver example:
        ["fg2_unlockVehicle", {
            params ["_vehicle", "_unlocked"];

            if (isNull _vehicle) exitWith {};

            _vehicle lock 0;
        }] call CBA_fnc_addEventHandler;
*/
["fg2_completion_globalEvent", {
    params ["_device", "_jobId", ["_args", []]];

    private _eventName = _args param [0, "", [""]];
    private _eventArgs = _args param [1, [], [[]]];

    if (_eventName isEqualTo "") exitWith {
        ["ERROR", "Completion effect globalEvent failed. Missing event name. Device: %1. Job: %2. Args: %3", [_device, _jobId, _args]] call fg2_fnc_log;
    };

    ["INFO", "Completion effect globalEvent executed. Event: %1. Device: %2. Job: %3", [_eventName, _device, _jobId]] call fg2_fnc_log;

    [_eventName, _eventArgs] call CBA_fnc_globalEvent;

}] call CBA_fnc_addEventHandler;

["INFO", "Completion effects initialized"] call fg2_fnc_log;