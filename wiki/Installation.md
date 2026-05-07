# Installation

## Requirements

- Arma 3
- CBA_A3
- ACE3

## Mission integration

Copy this folder into your mission:

```text
mission_template/fg2_intelFramework
```

Add to `description.ext`:

```cpp
#include "fg2_intelFramework\config\CfgFG2IntelFramework.hpp"
#include "fg2_intelFramework\ui\RscFG2Terminal.hpp"
#include "fg2_intelFramework\CfgFunctions.hpp"
```

Add to `init.sqf`:

```sqf
if (isServer) then {
    [] call fg2_fnc_initFramework;
};

if (hasInterface) then {
    [] spawn fg2_fnc_initDeviceActions;
};
```
