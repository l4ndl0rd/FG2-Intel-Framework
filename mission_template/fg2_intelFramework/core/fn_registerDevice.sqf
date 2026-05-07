/*
    FG2 - Register Device
    SERVER ONLY
*/

if (!isServer) exitWith {};

params ["_device", ["_class", ""]];

if (isNull _device) exitWith {
    ["ERROR", "RegisterDevice failed. Device is null"] call fg2_fnc_log;
};

if (_device getVariable ["fg2_registered", false]) exitWith {
    ["WARN", "Device already registered: %1", [_device]] call fg2_fnc_log;
};

private _existingClass = _device getVariable ["fg2_deviceClass", ""];

if (_existingClass isEqualTo "") exitWith {
    ["ERROR", "RegisterDevice failed. No fg2_deviceClass set on %1", [_device]] call fg2_fnc_log;
};

_device setVariable ["fg2_registered", true, true];
_device setVariable ["fg2_deviceClass", _existingClass, true];

// Queue / Runtime State
_device setVariable ["fg2_jobQueue", [], true];
_device setVariable ["fg2_activeJob", [], true];
_device setVariable ["fg2_jobProgress", 0, true];
_device setVariable ["fg2_deviceBusy", false, true];
_device setVariable ["fg2_queueLock", false, true];

// Control State
_device setVariable ["fg2_jobPaused", false, true];
_device setVariable ["fg2_jobPauseRequestedBy", "", true];
_device setVariable ["fg2_jobCancelRequested", false, true];

// Job Meta
_device setVariable ["fg2_unitsCompleted", 0, true];
_device setVariable ["fg2_unitsTotal", 0, true];
_device setVariable ["fg2_activeTitle", "", true];
_device setVariable ["fg2_unitLabel", "Completed", true];
_device setVariable ["fg2_lastJobId", "", true];


// Completion Effects
if (isNil {_device getVariable "fg2_onCompleteEvent"}) then {
    _device setVariable ["fg2_onCompleteEvent", "", true];
};

if (isNil {_device getVariable "fg2_onCompleteArgs"}) then {
    _device setVariable ["fg2_onCompleteArgs", [], true];
};

_device setVariable ["fg2_completionFired", false, true];

// Global Registry
private _allDevices = missionNamespace getVariable ["fg2_allDevices", []];

if !(_device in _allDevices) then {
    _allDevices pushBack _device;
    missionNamespace setVariable ["fg2_allDevices", _allDevices, true];
};

["INFO", "Registered device %1 with class %2", [_device, _existingClass]] call fg2_fnc_log;