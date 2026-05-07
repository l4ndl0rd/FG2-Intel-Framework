# Marker Reveal

Create a marker in Eden and set alpha to `0`.

Reveal it on completion:

```sqf
this setVariable ["fg2_onCompleteEvent", "fg2_completion_revealMarker", true];
this setVariable ["fg2_onCompleteArgs", ["fg2_marker_objective_1"], true];
```

With custom alpha:

```sqf
this setVariable ["fg2_onCompleteArgs", ["fg2_marker_objective_1", 0.75], true];
```
