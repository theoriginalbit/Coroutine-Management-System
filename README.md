Coroutine-Management-System
===========================

A better CMS for ComputerCraft that provides much more functionality than the Parallel API


Features
===========================
- Ability to add new routines into the routine queue while running
- Ability to kill/stop a routine
- When stopping a routine they will have their callback function invoked, or get a "SIG_KILL" event if no callback is supplied on creation
- Ability to queue events to a specific routine
- Ability to get the routine so you could also control the life-cycle (if no ID is provided it will return the current routine)
- Ability to queue event to a specific routine that are next in line to be unqueued (priority)
- Ability to pause and resume routines
