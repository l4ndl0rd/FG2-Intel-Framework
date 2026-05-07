# Device Setup

A device is any editor object with `fg2_deviceClass` set.

## Basic device

```sqf
this setVariable ["fg2_deviceClass", "HACK_TERMINAL", true];
```

The class must exist in `CfgFG2IntelFramework >> Devices`.

## Device with completion effect

```sqf
this setVariable ["fg2_deviceClass", "HACK_TERMINAL", true];
this setVariable ["fg2_onCompleteEvent", "fg2_completion_hideObjectGlobal", true];
this setVariable ["fg2_onCompleteArgs", [fg2_target_vehicle_1], true];
```
