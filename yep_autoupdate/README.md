##Overview

This AutoHotkey script will give you configurable, scheduled updates to your [Yanfly Engine Plugins (YEP)](http://yanfly.moe/yep) projects.

##Installation

YEP Auto-Update uses 7-Zip's or WinRAR's CLI to extract Yanfly's YEP .rar, so please ensure that you have one of them installed. Also, since I'm assuming that you've installed 7-Zip/WinRAR fully, the YEP Auto-Update expects `7z.exe` or `unrar.exe` to be accessible from the current working directory (in other words, you should make sure 7-Zip/WinRAR gets a `PATH` entry). However, settings in the `config.ini` can be altered to allow for full paths to these tools if needed.

[7-zip's Download Page](http://www.7-zip.org/download.html)

*Note: If you do not use 7-Zip (recommended) or WinRAR, you may need to do the legwork of finding out what your own commands would be, but I would think with a few small edits to the extraction commands, you can get this to work with just about any archive manager.*

###Loose Script

To install the YEP Auto-Update via the loose AHK script:

1. Download and install AutoHotkey from https://autohotkey.com/  
2. Download the `yep_autoupdate.ahk` and `yep_yanfly.ico` files above (or just download the entire repo).  
3. Double-click the `yep_autoupdate.ahk` file from your wherever you decided to download it.  

###Compiled

There is no real installation for the compiled YEP Auto-Update.

1. Navigate to the `/bin/` folder above.  
2. Download your processor-appropriate version (32/64-bit).  
3. Run the `.exe`  

###Setup

The first time you run the application or script a `yep_dirs.txt` file is created in the same folder as the application or script unless it's being ran in a way that changes its current working directory (heavily not recommended).

If you **are** running the YEP Auto-Update from an RVVM's project root and that's the only project you're interested in keeping up-to-date, there's nothing more to do with the `yep_dirs.txt`.

If you are **not** running the YEP Auto-Update from an RVVM's project root, you should immediately add your projects to the `yep_dirs.txt` by either editing the file directly (there is a menu option to help), or through the `Add Project Directory` menu option, and navigating to your project's root with a handy-dandy visual dialog.

The `yep_dirs.txt` file is a line-delimited list of project roots to extract the YEP to. A sample of this file might look something like:

>yep  
>..\SampleProject  
>C:\Projects\MyGame  

*Note: The `yep` entry is there to keep a copy of the `js/plugins` changes made, so that a new project installation can be made simpler by copying and pasting the contents of this `yep` folder. This is only an example though, and is not needed by any means.*

##Usage

Now that you have the YEP Auto-Update running, here is a basic usage guide to help answer any questions you might have.

First off, everything you do to interact with the YEP Auto-Update application or script will begin by right-clicking your shiny new Yanfly icon in your system tray. From there you should see something similar to the images below (not accounting for features/changes added since these screenshots were made):

![YEP Auto-Update: Intervals](https://github.com/nekoyoubi/yep_util/raw/master/yep_autoupdate/doc/yep_autoupdate_demo-assets/yep_autoupdate_demo_interval.png)
![YEP Auto-Update: Notifications](https://github.com/nekoyoubi/yep_util/raw/master/yep_autoupdate/doc/yep_autoupdate_demo-assets/yep_autoupdate_demo_notifications.png)
![YEP Auto-Update: Extraction](https://github.com/nekoyoubi/yep_util/raw/master/yep_autoupdate/doc/yep_autoupdate_demo-assets/yep_autoupdate_demo_extraction.png)
![YEP Auto-Update: Links](https://github.com/nekoyoubi/yep_util/raw/master/yep_autoupdate/doc/yep_autoupdate_demo-assets/yep_autoupdate_demo_links.png)

Here are the explanations of what you see here:

* **Manually Update YEP** - This will perform an update check at your discretion. You can also get this by pressing `WIN+Y`.  
* **Force YEP Update** - This will force an update regardless of whether you have the latest YEP scripts .rar or not.  
* **Enable YEP Auto-Update** - This toggle will enable or disable whether your updates will come automatically.  
* **Set Update Interval** - Here you can adjust the frequency of update checks. Sadly, only Yanfly can adjust the frequency of updates. ;)  
* **Notifications** - These two options control what message pop-ups you receive. You can turn either off to suit your needs (or both for the silent treatment).  
* **Add Project Directory** - This will open a visual directory selection dialog. Navigate to your project's root folder and then confirm.  
* **Edit Project Directories** - This will open the `yep_dirs.txt` file for you to edit.  
* **Edit Config File** - This will open the `config.ini` file for you to edit.  
* **Extraction Tool** - These options control which archive utility you want to use. 7-Zip is fully supported, but there is an experimental option for WinRAR as well.  
*Note: I do not use WinRAR myself, so if you encounter any issues with WinRAR, please let me know as soon as possible.*  
* **Links** - These are just some links that I thought might be relevant for you. Maybe, maybe not. You really should support Yanfly though... seriously.  
* **Close YEP Auto-Update** - Does what it says on the tin. Click this, and the application or script will exit.  

##Support

If you have any questions, please feel free to contact me via github or email me at lance@nekoyoubi.com. If you find an issue with the YEP Auto-Update, please create an issue for it here, and I'll do my best to see it worked through.
