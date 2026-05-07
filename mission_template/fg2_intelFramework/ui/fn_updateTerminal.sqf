/*
    FG2 - Update Intel Terminal UI
    CLIENT ONLY

    Runs only while the dialog is open.
    Reads authoritative state from synced device variables.
*/

if (!hasInterface) exitWith {};

params ["_display"];

if (isNull _display) exitWith {};

while {!isNull _display} do {
    private _device = uiNamespace getVariable ["fg2_activeDevice", objNull];

    if (!isNull _device) then {
        private _activeJob = _device getVariable ["fg2_activeJob", []];
        private _queue = _device getVariable ["fg2_jobQueue", []];
        private _progress = _device getVariable ["fg2_jobProgress", 0];
        private _busy = _device getVariable ["fg2_deviceBusy", false];
        private _paused = _device getVariable ["fg2_jobPaused", false];
        private _completed = _device getVariable ["fg2_unitsCompleted", 0];
        private _activeTitle = _device getVariable ["fg2_activeTitle", "ACTIVE JOB"];
        private _unitLabel = _device getVariable ["fg2_unitLabel", "Completed"];

        private _jobText = "";

        if !(_activeJob isEqualTo []) then {
            private _jobName = _activeJob param [1, "Unknown Job"];
            private _status = ["Processing", "Paused"] select _paused;

            _jobText = format [
                "<t size='1.15' color='#cc6900'>%1</t><br/><br/><t size='1.0'>%2</t><br/><br/>Queue: %3<br/>Status: <t size='1.0' color='#cc6900'>%4</t><br/>%5: %6",
                _activeTitle,
                _jobName,
                count _queue,
                _status,
                _unitLabel,
                _completed
            ];
        } else {
            _jobText = format [
                "<t size='1.15' color='#cc6900'>TERMINAL READY</t><br/><br/>Device Busy: %1<br/>Queue: %2<br/>Status: <t size='1.0' color='#cc6900'>Idle</t><br/>%3: %4",
                _busy,
                count _queue,
                _unitLabel,
                _completed
            ];
        };

        (_display displayCtrl 1001) ctrlSetStructuredText parseText _jobText;

        (_display displayCtrl 1002) ctrlSetText format [
            "Progress: %1%2",
            round (_progress * 100),
            "%"
        ];

        private _barBg = _display displayCtrl 1200;
        private _bar = _display displayCtrl 1201;

        private _bgPos = ctrlPosition _barBg;
        private _progressSafe = (_progress max 0) min 1;

        private _lastProgress = uiNamespace getVariable ["fg2_lastProgressValue", -1];

        _bar ctrlSetPosition [
            _bgPos select 0,
            _bgPos select 1,
            (_bgPos select 2) * _progressSafe,
            _bgPos select 3
        ];

        if (_progressSafe <= 0 && {_lastProgress > 0}) then {
            _bar ctrlCommit 0;
        } else {
            private _initialized = uiNamespace getVariable ["fg2_progressBarInitialized", false];

            if (!_initialized) then {
                _bar ctrlCommit 0;
                uiNamespace setVariable ["fg2_progressBarInitialized", true];
            } else {
                _bar ctrlCommit 0.35;
            };
        };

uiNamespace setVariable ["fg2_lastProgressValue", _progressSafe];

_bar ctrlCommit 0;

        private _button = _display displayCtrl 1601;

        if (_activeJob isEqualTo []) then {
            _button ctrlSetText "Start Job";
        } else {
            if (_paused) then {
                _button ctrlSetText "Resume Job";
            } else {
                _button ctrlSetText "Pause Job";
            };
        };
    };

    uiSleep 0.10;
};