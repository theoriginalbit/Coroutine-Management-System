Coroutine-Management-System (CMS)
---------------------------------

A better CMS for ComputerCraft that provides much more functionality than the [Parallel API](http://computercraft.info/wiki/Parallel_(API)) see the below features list for more details.

Features
--------
- Add new routines into the queue while active (unlike the [Parallel API](http://computercraft.info/wiki/Parallel_(API)))
- Check routine status
- Stop a routine (raises SIG_STOP event)*
- Kill a routine (raises SIG_KILL event)*
- Pause a routine (raises SIG_PAUSE event)*
- Resume a routine (raises SIG_RESUME event)*
- Queue events targeted for specific routines
- Queue events that jump the event queue
- Ability for manual control of coroutine life-cycle

* Events are notification of change in life-cycle only and does not allow you to prevent the change

Author
------
- Joshua Asbury a.k.a. theoriginalbit

Contact Information
-------------------
- Skype: [theoriginalbit.computercraft](skype:theoriginalbit.computercraft?chat)
- ComputerCraft Forum: [theoriginalbit's profile](http://www.computercraft.info/forums2/index.php?/user/1217-theoriginalbit/)
- Email: [theoriginalbit@gmail.com](mailto:theoriginalbit@gmail.com?Subject=Lua%20CMS)
- Website: [computercraft.theoriginalbit.com](http://computercraft.theoriginalbit.com)