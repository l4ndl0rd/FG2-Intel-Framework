/*
    FG2 - Execute Job
    SERVER ONLY
*/

if (!isServer) exitWith {};

params ["_device", "_job"];

if (isNull _device) exitWith {};

if (_job isEqualTo [] || {count _job < 6}) exitWith {
    ["ERROR", "Invalid job passed to executeJob: %1", [_job]] call fg2_fnc_log;

    _device setVariable ["fg2_activeJob", [], true];
    _device setVariable ["fg2_jobProgress", 0, true];
    _device setVariable ["fg2_deviceBusy", false, true];
    _device setVariable ["fg2_jobPaused", false, true];
    _device setVariable ["fg2_jobPauseRequestedBy", "", true];
    _device setVariable ["fg2_jobCancelRequested", false, true];

    [_device] spawn fg2_fnc_jobRouter;
};

_job params [
    "_jobId",
    "_name",
    "_duration",
    "_variance",
    "_activeTitle",
    "_unitLabel",
    ["_unitsTotalFromJob", 0]
];

private _totalTime = _duration + random _variance;
private _tick = 0.2;
private _elapsed = 0;

if (_totalTime <= 0) then { _totalTime = 1; };

private _unitsTotal = _device getVariable ["fg2_unitsTotal", _unitsTotalFromJob];
if (_unitsTotal <= 0) then { _unitsTotal = _unitsTotalFromJob; };
if (_unitsTotal <= 0) then { _unitsTotal = 1; };

_device setVariable ["fg2_unitsTotal", _unitsTotal, true];
_device setVariable ["fg2_lastJobId", _jobId, true];
_device setVariable ["fg2_activeTitle", _activeTitle, true];
_device setVariable ["fg2_unitLabel", _unitLabel, true];

_device setVariable ["fg2_jobCancelRequested", false, true];
_device setVariable ["fg2_jobPaused", false, true];
_device setVariable ["fg2_jobPauseRequestedBy", "", true];
_device setVariable ["fg2_jobProgress", 0, true];

["INFO", "Started job: %1 on %2. Duration: %3", [_name, _device, _totalTime]] call fg2_fnc_log;

while {
    _elapsed < _totalTime
    && {alive _device}
    && {!(_device getVariable ["fg2_jobCancelRequested", false])}
} do {
    private _paused = _device getVariable ["fg2_jobPaused", false];

    if (!_paused) then {
        _elapsed = _elapsed + _tick;
        private _progress = (_elapsed / _totalTime) min 1;
        _device setVariable ["fg2_jobProgress", _progress, true];
    };

    sleep _tick;
};

if (_device getVariable ["fg2_jobCancelRequested", false]) exitWith {
    ["INFO", "Job execution stopped by cancel request on %1", [_device]] call fg2_fnc_log;

    _device setVariable ["fg2_activeJob", [], true];
    _device setVariable ["fg2_jobProgress", 0, true];
    _device setVariable ["fg2_deviceBusy", false, true];
    _device setVariable ["fg2_jobPaused", false, true];
    _device setVariable ["fg2_jobPauseRequestedBy", "", true];
    _device setVariable ["fg2_jobCancelRequested", false, true];
};

if (!alive _device) exitWith {
    ["WARN", "Job aborted. Device destroyed: %1", [_device]] call fg2_fnc_log;

    _device setVariable ["fg2_activeJob", [], true];
    _device setVariable ["fg2_jobProgress", 0, true];
    _device setVariable ["fg2_deviceBusy", false, true];
    _device setVariable ["fg2_jobPaused", false, true];
    _device setVariable ["fg2_jobPauseRequestedBy", "", true];
    _device setVariable ["fg2_jobCancelRequested", false, true];
};

_device setVariable ["fg2_jobProgress", 1, true];

private _completed = _device getVariable ["fg2_unitsCompleted", 0];
_completed = _completed + 1;
_device setVariable ["fg2_unitsCompleted", _completed, true];

["INFO", "Completed job: %1 on %2. %3: %4/%5", [_name, _device, _unitLabel, _completed, _unitsTotal]] call fg2_fnc_log;

private _queue = _device getVariable ["fg2_jobQueue", []];
private _completionFired = _device getVariable ["fg2_completionFired", false];

if (
    !_completionFired
    && {_completed >= _unitsTotal}
    && {_queue isEqualTo []}
) then {
    _device setVariable ["fg2_completionFired", true, true];

    private _onCompleteEvent = _device getVariable ["fg2_onCompleteEvent", ""];
    private _onCompleteArgs = _device getVariable ["fg2_onCompleteArgs", []];

    if !(_onCompleteEvent isEqualTo "") then {
        ["INFO", "Firing completion event '%1' for %2. Job: %3. Args: %4", [_onCompleteEvent, _device, _jobId, _onCompleteArgs]] call fg2_fnc_log;
        [_onCompleteEvent, [_device, _jobId, _onCompleteArgs]] call CBA_fnc_localEvent;
    } else {
        ["INFO", "No completion event configured for %1. Job: %2", [_device, _jobId]] call fg2_fnc_log;
    };
};

sleep 0.2;

if (!isNull _device) then {
    _device setVariable ["fg2_activeJob", [], true];
    _device setVariable ["fg2_jobProgress", 0, true];
    _device setVariable ["fg2_deviceBusy", false, true];
    _device setVariable ["fg2_jobPaused", false, true];
    _device setVariable ["fg2_jobPauseRequestedBy", "", true];
    _device setVariable ["fg2_jobCancelRequested", false, true];

    [_device] spawn fg2_fnc_jobRouter;
};
