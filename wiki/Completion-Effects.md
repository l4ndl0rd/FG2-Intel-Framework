# Completion Effects

Completion effects are configured on the device.

```sqf
this setVariable ["fg2_onCompleteEvent", "fg2_completion_hideObjectGlobal", true];
this setVariable ["fg2_onCompleteArgs", [], true];
```

## Available effects

| Event | Args | Result |
|---|---|---|
| `fg2_completion_deleteObject` | `[]` or `[targetObject]` | Deletes object |
| `fg2_completion_destroyObject` | `[]` or `[targetObject]` | Sets damage to 1 |
| `fg2_completion_hideObjectGlobal` | `[]` or `[targetObject]` | Hides object globally |
| `fg2_completion_setVariable` | `["var", value, public]` or `[target, "var", value, public]` | Sets variable |
| `fg2_completion_revealMarker` | `["marker"]` or `["marker", alpha]` | Reveals marker |
| `fg2_completion_unlockDoor` | See Door Unlocking | Unlocks door |
| `fg2_completion_globalEvent` | `["eventName", args]` | Calls CBA global event |

## Target fallback

For object-based events, empty args mean: use the device itself.
