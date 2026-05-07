# Troubleshooting

## Device does not register

Check that the object has:

```sqf
this setVariable ["fg2_deviceClass", "HACK_TERMINAL", true];
```

And the class exists in config.

## Completion effect does not run

Check:

- `fg2_onCompleteEvent` is on the device, not the target
- event name spelling
- `fn_initCompletionEffects.sqf` is registered in `CfgFunctions.hpp`
- `fn_initFramework.sqf` calls `fg2_fnc_initCompletionEffects`

## Marker does not reveal

Check marker name and alpha.

## Door does not unlock

Check door index and whether the building has animated doors.
