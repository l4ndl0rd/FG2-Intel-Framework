# Global Events

Use `fg2_completion_globalEvent` to bridge into mission-specific logic.

```sqf
this setVariable ["fg2_onCompleteEvent", "fg2_completion_globalEvent", true];
this setVariable ["fg2_onCompleteArgs", ["fg2_labHackComplete", []], true];
```

Receiver:

```sqf
["fg2_labHackComplete", {
    "fg2_marker_lab" setMarkerAlpha 1;
}] call CBA_fnc_addEventHandler;
```
