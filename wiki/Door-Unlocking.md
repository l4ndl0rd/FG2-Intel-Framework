# Door Unlocking

Use:

```sqf
this setVariable ["fg2_onCompleteEvent", "fg2_completion_unlockDoor", true];
```

## Editor-placed building

```sqf
this setVariable ["fg2_onCompleteArgs", [fg2_target_building_1, 1, true], true];
```

## Map building via marker

```sqf
this setVariable ["fg2_onCompleteArgs", ["fg2_marker_targetBuilding_1", 1, true], true];
```

## Nearest building to device

```sqf
this setVariable ["fg2_onCompleteArgs", [], true];
```

## Args

```sqf
[target, doorIndex, animateDoor]
```

`animateDoor = true` unlocks and opens. `false` only unlocks.
