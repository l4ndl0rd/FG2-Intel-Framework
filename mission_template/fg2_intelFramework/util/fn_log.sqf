/*
    FG2 - Central Logger

    Usage:
    ["INFO", "Message"] call fg2_fnc_log;
    ["WARN", "Message with %1", [_value]] call fg2_fnc_log;
*/

params [
    ["_level", "INFO"],
    ["_message", ""],
    ["_args", []]
];

private _enabled = missionNamespace getVariable ["fg2_debugEnabled", true];

if (!_enabled && {_level != "ERROR"}) exitWith {};

private _text = if (_args isEqualTo []) then {
    _message
} else {
    format ([_message] + _args)
};

private _line = format ["[FG2][%1] %2", _level, _text];

diag_log _line;

if (missionNamespace getVariable ["fg2_debugIngame", false]) then {
    systemChat _line;
};