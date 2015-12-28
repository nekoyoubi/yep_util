#Overview

This AutoHotkey script will give you configurable, scheduled updates to your [Yanfly Engine Plugins (YEP)](http://yanfly.moe/yep) projects.

#Installation

##Loose Script

To install the YEP Auto-Update via the loose AHK script:
	1. Download and install AutoHotkey from https://autohotkey.com/
	2. Download the `yep_autoupdate.ahk` and `yep_yanfly.ico` files above (or just download the entire repo). *Note: I recommend downloading to a "yanfly" folder at the root of your RMMV projects, as that's where the initial yep_dirs.txt will assume you've placed it.*
	3. Double-click the `yep_autoupdate.ahk` file from your wherever you decided to download it.

##Compiled

There is no real installation for the compiled YEP Auto-Update.
	1. Navigate to the `/bin/` folder above.
	2. Download your processor-appropriate version (32/64-bit).
	3. Run the `.exe`

##Setup

The first time you run the application or script you'll be prompted with the following message:

>The file 'yep_dirs.txt' was not found. A new one has been created for you.
>
>Please ensure that any projects that use YEP are included in this line-delimited path list. YEP updates will be extracted to extracted to these folders' subdirectory, js/plugins, so please only list the root RMMV project folders.
>
>If you are running this from inside your project, simply delete the contents of this file.

The `yep_dirs.txt` file mentioned is created in the same folder as the application or script unless it's being ran in a way that changes its working directory.

You should immediately navigate to this file and edit its default contents...

>yep
>..\SampleProject

... to whatever your projects' root folders are, line-delimited. The `yep` entry is there to keep a copy of the `js/plugins` changes made, so that a new project installation can be made simpler by copying and pasting the contents of this `yep` folder.

If you are only working with a single RMMV project, and would rather run this from the root, once the file generates, simply open it up and delete the contents. This will allow the YEP Auto-Update to assume you only want to update that one project it currently resides in.

Once you're done editing, save the `yep_dirs.txt` file and you're good to go!

#Usage

Now that you have the YEP Auto-Update running, here is a basic usage guide to help answer any questions you might have.

First off, everything you do to interact with the YEP Auto Update application or script will begin by right-clicking your shiny new Yanfly icon in your system tray. From there you should see something similar to the images below:

![YEP Auto Update: Intervals](https://github.com/nekoyoubi/yep_util/raw/master/yep_autoupdate/doc/yep_autoupdate_demo-assets/yep_autoupdate_demo_interval.png)
![YEP Auto Update: Notifications](https://github.com/nekoyoubi/yep_util/raw/master/yep_autoupdate/doc/yep_autoupdate_demo-assets/yep_autoupdate_demo_notifications.png "YEP Auto Update: Notifications")
![YEP Auto Update: Links](https://github.com/nekoyoubi/yep_util/raw/master/yep_autoupdate/doc/yep_autoupdate_demo-assets/yep_autoupdate_demo_links.png "YEP Auto Update: Links")

Here are the explanations of what you see here:

* **Manually Update YEP** - This will force an update check at your discretion. You can also get this by pressing `WIN+Y`.
* **Enable YEP Auto-Update** - This toggle will enable or disable whether your updates will come automatically.
* **Set Update Interval** - Here you can adjust the frequency of update checks. Sadly, only Yanfly can adjust the frequency of updates. ;)
* **Notifications** - These two options control what message popups you receive. You can turn either of to suit your needs (or both for the silent treatment).
* **Links** - These are just some links that I thought might be relevant for you. Maybe, maybe not. You really should support Yanfly though... seriously.
* **Close YEP Auto Update** - Does what it says on the tin. Click this, and the application or script will exit.

#Support

If you have any questions, please feel free to contact me via github or email me at lance@nekoyoubi.com. If you find an issue with the YEP Auto Update, please create an issue for it here, and I'll do my best to see it worked through.
