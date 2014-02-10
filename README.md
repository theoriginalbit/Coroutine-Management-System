Coroutine-Management-System
---------------------------

A coroutine management system (CMS) written for Lua, targeted towards users of the Minecraft Mod – [ComputerCraft](http://computercraft.info) – as a better replacement for the [Parallel API](http://computercraft.info/wiki/Parallel_(API)).

Features
--------
- Add new routines into the queue while active (unlike ComputerCraft's [Parallel API](http://computercraft.info/wiki/Parallel_(API)))
- Check routine status
- Stop a routine (raises SIG_STOP event)*
- Kill a routine (raises SIG_KILL event)*
- Pause a routine (raises SIG_PAUSE event)*
- Resume a routine (raises SIG_RESUME event)*
- Queue events targeted for specific routines
- Queue events that jump the event queue
- Ability for manual control of coroutine life-cycle

\* Events are notification of change in life-cycle only and does not allow you to prevent the change