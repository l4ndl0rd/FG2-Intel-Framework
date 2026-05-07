if (!isServer) exitWith {};

params ["_device", "_job"];

private _queue = +(_device getVariable ["fg2_jobQueue", []]);
_queue pushBack _job;

_device setVariable ["fg2_jobQueue", _queue, true];