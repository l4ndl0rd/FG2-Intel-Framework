if (!hasInterface) exitWith {};

params ["_device"];

if (isNull _device) exitWith {
    ["ERROR", "Invalid device", []] call fg2_fnc_log;
};

uiNamespace setVariable ["fg2_activeDevice", _device];

private _created = createDialog "RscFG2Terminal";

if (!_created) exitWith {
    ["ERROR", "Failed to create terminal UI", []] call fg2_fnc_log;
    uiNamespace setVariable ["fg2_activeDevice", objNull];
};

private _display = uiNamespace getVariable ["fg2_terminalDisplay", displayNull];

if (isNull _display) exitWith {
    ["ERROR", "Terminal Display nicht gefunden."] call fg2_fnc_log;
};

[_display] spawn fg2_fnc_updateTerminal;