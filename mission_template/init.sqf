if (isServer) then {
    [] call fg2_fnc_initFramework;
};

if (hasInterface) then {
    [] spawn fg2_fnc_initDeviceActions;
};