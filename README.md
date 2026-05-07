# FG2 Intel Processing Framework

**Author:** l4ndl0rd  
**Version:** 1.1.0  

Server-authoritative Intel/job processing framework for Arma 3 missions using ACE and CBA.

## What it does

The framework lets mission makers place devices such as laptops or terminals and attach configurable jobs to them. Players interact through ACE, start jobs in a terminal UI, and the server processes those jobs through a queue. When processing is finished, optional completion effects can modify the mission state.

Typical use cases:

- hacking a terminal
- shredding documents
- extracting intel
- revealing hidden map markers
- unlocking doors
- hiding, deleting, or destroying objects
- triggering custom CBA events

## Requirements

- Arma 3
- CBA_A3
- ACE3

## Repository contents

```text
mission_template/        Drop-in mission framework files
docs/                    Technical documentation
wiki/                    GitHub Wiki-ready Markdown pages
.github/                 GitHub issue templates
```

## Quick start

1. Copy `mission_template/fg2_intelFramework` into your mission folder.
2. Copy or merge `mission_template/description.ext` and `mission_template/init.sqf`.
3. Place a laptop or terminal object in Eden.
4. Add this to the object init:

```sqf
this setVariable ["fg2_deviceClass", "HACK_TERMINAL", true];
```

5. Configure devices/jobs in:

```text
fg2_intelFramework/config/CfgFG2IntelFramework.hpp
```

6. Start the mission and use the ACE interaction on the device.

## Basic completion effect example

Hide a vehicle after the terminal job is complete.

Vehicle variable name in Eden:

```text
fg2_target_vehicle_1
```

Laptop init:

```sqf
this setVariable ["fg2_deviceClass", "HACK_TERMINAL", true];
this setVariable ["fg2_onCompleteEvent", "fg2_completion_hideObjectGlobal", true];
this setVariable ["fg2_onCompleteArgs", [fg2_target_vehicle_1], true];
```

## Completion effects

| Event | Purpose |
|---|---|
| `fg2_completion_deleteObject` | Deletes an object |
| `fg2_completion_destroyObject` | Destroys an object with `setDamage 1` |
| `fg2_completion_hideObjectGlobal` | Hides an object and disables simulation |
| `fg2_completion_setVariable` | Sets a variable on a device or target |
| `fg2_completion_revealMarker` | Reveals a marker by changing alpha |
| `fg2_completion_unlockDoor` | Unlocks and optionally opens a door |
| `fg2_completion_globalEvent` | Triggers a custom CBA global event |

See the `wiki/` folder for complete implementation documentation.

## GitHub Wiki

The `wiki/` folder is prepared so it can be pushed into the GitHub Wiki repository.

Example after creating the GitHub repo and enabling Wiki:

```bash
git clone https://github.com/<USER>/<REPO>.wiki.git FG2-Intel-Framework.wiki
cp wiki/*.md FG2-Intel-Framework.wiki/
cd FG2-Intel-Framework.wiki
git add .
git commit -m "Add FG2 Intel Framework documentation"
git push
```

## Changelog

See [`CHANGELOG.md`](CHANGELOG.md).
