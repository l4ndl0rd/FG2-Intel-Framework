/*
    FG2 - Job Router
    SERVER ONLY
*/

if (!isServer) exitWith {};

params ["_device"];

if (isNull _device) exitWith {};

if (_device getVariable ["fg2_queueLock", false]) exitWith {};

_device setVariable ["fg2_queueLock", true, true];

private _queue = +(_device getVariable ["fg2_jobQueue", []]);

if (_queue isEqualTo []) exitWith {
    _device setVariable ["fg2_deviceBusy", false, true];
    _device setVariable ["fg2_activeJob", [], true];
    _device setVariable ["fg2_jobProgress", 0, true];
    _device setVariable ["fg2_queueLock", false, true];

    ["INFO", "Queue empty on %1", [_device]] call fg2_fnc_log;
};

private _job = _queue deleteAt 0;

_device setVariable ["fg2_jobQueue", _queue, true];
_device setVariable ["fg2_activeJob", _job, true];
_device setVariable ["fg2_deviceBusy", true, true];
_device setVariable ["fg2_jobProgress", 0, true];
_device setVariable ["fg2_queueLock", false, true];

["INFO", "Routing job on %1: %2", [_device, _job]] call fg2_fnc_log;

[_device, _job] spawn fg2_fnc_executeJob;