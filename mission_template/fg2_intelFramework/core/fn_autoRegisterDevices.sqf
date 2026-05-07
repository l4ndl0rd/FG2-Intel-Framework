/*
    FG2 - Auto Register Devices
    SERVER ONLY
*/

if (!isServer) exitWith {};

{
    private _deviceClass = _x getVariable ["fg2_deviceClass", ""];

    if !(_deviceClass isEqualTo "") then {
        [_x, _deviceClass] call fg2_fnc_registerDevice;
    };

} forEach allMissionObjects "All";

["INFO", "Auto-register scan complete"] call fg2_fnc_log;