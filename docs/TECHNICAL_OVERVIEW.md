# Technical Overview

The framework is split into bootstrap, core, interaction, UI, and utility modules.

- `bootstrap`: server initialization and completion effect registration
- `core`: queues, jobs, router, execution, pause/resume/cancel
- `interaction`: ACE actions
- `ui`: terminal dialog and UI updates
- `util`: logging

The runtime model is server-authoritative. Clients request actions through CBA events. The server validates devices, selects the configured job from `availableJobs[]`, queues the work, processes it, and triggers completion effects after the final unit.
