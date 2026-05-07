/*
    FG2 - Resume Job
    SERVER ONLY
*/

if (!isServer) exitWith {};

params ["_device", ["_playerUID", ""]];

if (isNull _device) exitWith {};

private _activeJob = _device getVariable ["fg2_activeJob", []];
private _busy = _device getVariable ["fg2_deviceBusy", false];
private _paused = _device getVariable ["fg2_jobPaused", false];

if (!_busy) exitWith {
    ["WARN", "Resume ignored. Device not busy: %1", [_device]] call fg2_fnc_log;
};

if (_activeJob isEqualTo []) exitWith {
    ["WARN", "Resume ignored. No active job: %1", [_device]] call fg2_fnc_log;
};

if (!_paused) exitWith {
    ["WARN", "Resume ignored. Job is not paused: %1", [_device]] call fg2_fnc_log;
};

_device setVariable ["fg2_jobPaused", false, true];
_device setVariable ["fg2_jobPauseRequestedBy", "", true];

["INFO", "Job resumed on %1 by UID %2", [_device, _playerUID]] call fg2_fnc_log;