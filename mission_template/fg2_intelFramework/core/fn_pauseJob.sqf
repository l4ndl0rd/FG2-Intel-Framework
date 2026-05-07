/*
    FG2 - Pause Job
    SERVER ONLY
*/

if (!isServer) exitWith {};

params ["_device", ["_playerUID", ""]];

if (isNull _device) exitWith {};

private _activeJob = _device getVariable ["fg2_activeJob", []];
private _busy = _device getVariable ["fg2_deviceBusy", false];
private _paused = _device getVariable ["fg2_jobPaused", false];

if (!_busy) exitWith {
    ["WARN", "Pause ignored. Device not busy: %1", [_device]] call fg2_fnc_log;
};

if (_activeJob isEqualTo []) exitWith {
    ["WARN", "Pause ignored. No active job: %1", [_device]] call fg2_fnc_log;
};

if (_paused) exitWith {
    ["WARN", "Pause ignored. Job already paused: %1", [_device]] call fg2_fnc_log;
};

_device setVariable ["fg2_jobPaused", true, true];
_device setVariable ["fg2_jobPauseRequestedBy", _playerUID, true];

["INFO", "Job paused on %1 by UID %2", [_device, _playerUID]] call fg2_fnc_log;