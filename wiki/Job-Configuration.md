# Job Configuration

Jobs are configured in `CfgFG2IntelFramework.hpp` under `class Jobs`.

```cpp
class HACK_DATA
{
    displayName = "Hack Data";
    activeTitle = "HACKING DATA";
    unitLabel = "Files Extracted";
    duration = 20;
    durationVariance = 5;
    unitsTotal = 5;
};
```

## Fields

| Field | Purpose |
|---|---|
| `displayName` | Name shown to users/logs |
| `activeTitle` | UI title while active |
| `unitLabel` | Progress label |
| `duration` | Base duration per unit |
| `durationVariance` | Random additional duration |
| `unitsTotal` | Number of sequential units |
