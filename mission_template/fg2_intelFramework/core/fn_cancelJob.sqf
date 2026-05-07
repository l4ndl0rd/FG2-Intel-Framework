/*
    FG2 - Cancel Job / Clear Queue
    SERVER ONLY
*/

if (!isServer) exitWith {};

params ["_device", ["_playerUID", ""]];

if (isNull _device) exitWith {};

private _completed = _device getVariable ["fg2_unitsCompleted", 0];
private _unitLabel = _device getVariable ["fg2_unitLabel", "Completed"];

_device setVariable ["fg2_jobCancelRequested", true, true];

_device setVariable ["fg2_jobQueue", [], true];
_device setVariable ["fg2_activeJob", [], true];
_device setVariable ["fg2_jobProgress", 0, true];
_device setVariable ["fg2_deviceBusy", false, true];
_device setVariable ["fg2_jobPaused", false, true];
_device setVariable ["fg2_jobPauseRequestedBy", "", true];

_device setVariable ["fg2_unitsCompleted", _completed, true];

["INFO", "Job cancelled and queue cleared on %1 by UID %2. %3 preserved: %4", [_device, _playerUID, _unitLabel, _completed]] call fg2_fnc_log;