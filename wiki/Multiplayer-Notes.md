# Multiplayer Notes

## Server authority

Job execution runs on the server only.

## Public variables

Use:

```sqf
_object setVariable ["name", value, true];
```

The final `true` broadcasts the variable.

## Doors

Door lock state uses object variables. Door opening uses remote execution for better multiplayer consistency.

## JIP

Completion states should be set globally so join-in-progress clients inherit the result.
