/*
    FG2 - Add Intel Job
    SERVER ONLY
*/

if (!isServer) exitWith {};

params ["_device", "_jobId"];

if (isNull _device) exitWith {
    ["ERROR", "addIntelJob failed. Invalid/null device. Job ID: %1", [_jobId]] call fg2_fnc_log;
};

private _cfg = missionConfigFile >> "CfgFG2IntelFramework" >> "Jobs" >> _jobId;

if (!isClass _cfg) exitWith {
    ["ERROR", "Invalid job ID: %1", [_jobId]] call fg2_fnc_log;
};

private _displayName = getText (_cfg >> "displayName");
private _activeTitle = getText (_cfg >> "activeTitle");
private _unitLabel = getText (_cfg >> "unitLabel");

private _duration = getNumber (_cfg >> "duration");
private _variance = getNumber (_cfg >> "durationVariance");
private _unitsTotal = getNumber (_cfg >> "unitsTotal");

if (_displayName isEqualTo "") then {
    _displayName = _jobId;
};

if (_activeTitle isEqualTo "") then {
    _activeTitle = toUpper _displayName;
};

if (_unitLabel isEqualTo "") then {
    _unitLabel = "Completed";
};

if (_duration <= 0) then {
    _duration = 1;
};

if (_variance < 0) then {
    _variance = 0;
};

if (_unitsTotal <= 0) then {
    _unitsTotal = 1;
};

private _completed = _device getVariable ["fg2_unitsCompleted", 0];
private _remaining = _unitsTotal - _completed;

_device setVariable ["fg2_unitsTotal", _unitsTotal, true];
_device setVariable ["fg2_lastJobId", _jobId, true];
_device setVariable ["fg2_activeTitle", _activeTitle, true];
_device setVariable ["fg2_unitLabel", _unitLabel, true];

if (_completed <= 0) then {
    _device setVariable ["fg2_completionFired", false, true];
};

if (_remaining <= 0) exitWith {
    ["INFO", "Start ignored. All units already completed on %1. Job: %2. Completed: %3/%4", [_device, _jobId, _completed, _unitsTotal]] call fg2_fnc_log;

    _device setVariable ["fg2_jobQueue", [], true];
    _device setVariable ["fg2_activeJob", [], true];
    _device setVariable ["fg2_jobProgress", 0, true];
    _device setVariable ["fg2_deviceBusy", false, true];
    _device setVariable ["fg2_jobPaused", false, true];
    _device setVariable ["fg2_jobCancelRequested", false, true];
};

for "_i" from (_completed + 1) to _unitsTotal do {
    private _job = [
        _jobId,
        format ["%1 (%2/%3)", _displayName, _i, _unitsTotal],
        _duration,
        _variance,
        _activeTitle,
        _unitLabel,
        _unitsTotal
    ];

    [_device, _job] call fg2_fnc_pushQueue;
};

["INFO", "Added remaining jobs for %1 on %2. Completed: %3/%4. Queued: %5", [_jobId, _device, _completed, _unitsTotal, _remaining]] call fg2_fnc_log;

if !(_device getVariable ["fg2_deviceBusy", false]) then {
    [_device] spawn fg2_fnc_jobRouter;
};