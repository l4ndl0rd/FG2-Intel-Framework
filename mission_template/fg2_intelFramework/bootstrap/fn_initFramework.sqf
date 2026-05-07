/*
    FG2 - Framework Initialization
    File: fn_initFramework.sqf

    Purpose:
        Initializes the FG2 intel framework on server start.
        - Registers devices
        - Sets up server event handlers
        - Prepares global state

    Runs:
        SERVER ONLY
*/

if (!isServer) exitWith {};

missionNamespace setVariable ["fg2_debugEnabled", true, true];
missionNamespace setVariable ["fg2_debugIngame", false, true];

["INFO", "Framework initialization started"] call fg2_fnc_log;

missionNamespace setVariable ["fg2_frameworkReady", false, true];
missionNamespace setVariable ["fg2_allDevices", [], true];

[] call fg2_fnc_initCompletionEffects;
[] call fg2_fnc_autoRegisterDevices;

["fg2_request_startJob", {
    params ["_netId", "_playerUID"];

    private _device = objectFromNetId _netId;

    if (isNull _device) exitWith {
        ["ERROR", "StartJob failed. Invalid device. UID: %1", [_playerUID]] call fg2_fnc_log;
    };

    private _deviceClass = _device getVariable ["fg2_deviceClass", ""];
    private _deviceCfg = missionConfigFile >> "CfgFG2IntelFramework" >> "Devices" >> _deviceClass;

    if (_deviceClass isEqualTo "" || {!isClass _deviceCfg}) exitWith {
        ["ERROR", "StartJob failed. Invalid or missing device class: %1 on %2. UID: %3", [_deviceClass, _device, _playerUID]] call fg2_fnc_log;
    };

    private _availableJobs = getArray (_deviceCfg >> "availableJobs");

    if (_availableJobs isEqualTo []) exitWith {
        ["ERROR", "StartJob failed. No availableJobs configured for device class: %1 on %2. UID: %3", [_deviceClass, _device, _playerUID]] call fg2_fnc_log;
    };

    private _jobId = _availableJobs select 0;

    [_device, _jobId, _playerUID] call fg2_fnc_addIntelJob;

}] call CBA_fnc_addEventHandler;

["fg2_request_pauseJob", {
    params ["_netId", "_playerUID"];

    private _device = objectFromNetId _netId;

    if (isNull _device) exitWith {
        ["ERROR", "PauseJob failed. Invalid device. UID: %1", [_playerUID]] call fg2_fnc_log;
    };

    [_device, _playerUID] call fg2_fnc_pauseJob;

}] call CBA_fnc_addEventHandler;

["fg2_request_resumeJob", {
    params ["_netId", "_playerUID"];

    private _device = objectFromNetId _netId;

    if (isNull _device) exitWith {
        ["ERROR", "ResumeJob failed. Invalid device. UID: %1", [_playerUID]] call fg2_fnc_log;
    };

    [_device, _playerUID] call fg2_fnc_resumeJob;

}] call CBA_fnc_addEventHandler;

["fg2_request_cancelJob", {
    params ["_netId", "_playerUID"];

    private _device = objectFromNetId _netId;

    if (isNull _device) exitWith {
        ["ERROR", "CancelJob failed. Invalid device. UID: %1", [_playerUID]] call fg2_fnc_log;
    };

    [_device, _playerUID] call fg2_fnc_cancelJob;

}] call CBA_fnc_addEventHandler;

missionNamespace setVariable ["fg2_frameworkReady", true, true];

["INFO", "Framework initialization complete"] call fg2_fnc_log;