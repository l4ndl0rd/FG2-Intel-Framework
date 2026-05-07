/*
    FG2 - Device ACE Interaction Builder
    CLIENT ONLY
*/

if (!hasInterface) exitWith {};

waitUntil {!isNil "ace_interact_menu_fnc_createAction"};
waitUntil {missionNamespace getVariable ["fg2_frameworkReady", false]};

while {true} do {

    {
        private _device = _x;

        private _deviceClass = _device getVariable ["fg2_deviceClass", ""];

        if (_deviceClass isEqualTo "") then {continue};
        if (_device getVariable ["fg2_actionsAdded", false]) then {continue};

        _device setVariable ["fg2_actionsAdded", true];

        private _action = [
            "fg2-terminal",
            "Intel Terminal",
            "",
            {
                params ["_target", "_player"];

                ["INFO", "Terminal opened | Player: %1 (%2) | Device: %3 | Class: %4", [
                    name _player,
                    getPlayerUID _player,
                    _target,
                    _target getVariable ["fg2_deviceClass", ""]
                ]] call fg2_fnc_log;

                [_target] call fg2_fnc_openTerminal;
            },
            {
                params ["_target", "_player"];

                !((_target getVariable ["fg2_deviceClass", ""]) isEqualTo "")
            }
        ] call ace_interact_menu_fnc_createAction;

        [_device, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

        ["INFO", "ACE interaction added to %1 with class %2", [_device, _deviceClass]] call fg2_fnc_log;

    } forEach allMissionObjects "All";

    uiSleep 1;
};