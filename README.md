# WTF is yep_util?!

This is a repository for my tools to assist the [Yanfly Engine Plugins (YEP)](http://yanfly.moe/yep) community. If you are unfamiliar with the YEP, [Yanfly](https://www.patreon.com/Yanfly) is an amazing developer that puts blood, sweat, and tears into creating extensible systems (via plugins) for use with [RPG Maker MV]().

# Current Tools

## [YEP Auto-Update](https://github.com/nekoyoubi/yep_util/tree/master/yep_autoupdate)

The YEP Auto-Update is an AutoHotkey script (and binaries) that gives you configurable, scheduled updates to your YEP-enabled projects. Mostly useful for keeping up-to-date with Yanfly's constant updates, this persistent script runs from your systray (mostly) silently keeping your projects current. It does not alter your project in any way (including plugin ordering) save for adding/updating the YEP.

## [yanfly.moe Stylish](https://userstyles.org/styles/122145/yanfly)

While not technically a part of the `yep_util`, I made a [Stylish](https://userstyles.org/) style for [yanfly.moe](yanfly.moe) that makes the comments area a lot more readable, in my opinion, especially in areas where there isn't a clear nesting of conversation, or large posts stacked on top of each other.

![yanfly.moe Stylish Preview](http://i.imgur.com/Ka5Gm33.png)

# Future Tools

## [YEP Auto-Sort](https://github.com/nekoyoubi/yep_util/tree/master/yep_autosort)

The YEP Auto-Sort is an AutoHotkey script (and binaries) that will let you target an RMMV project, and have that project's plugins reorganized based on known dependencies and potential issues from various plugins. Essentially a [LOOT](https://loot.github.io/) for RPG Maker MV with an emphasis on Yanfly's Engine Plugins.

# Why AutoHotkey?

I would love to write these in C#, as it's more my native application language, but I'm choosing to go a bit 'low-tech' with these in the interest of transparency, and flexibility. I would rather cater to a community that can take the scripts and modify them to their liking, than to provide only compiled applications that may concern or limit that community.
