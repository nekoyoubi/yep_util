#SingleInstance, force
#Persistent

menu, tray, icon, yep_yanfly.ico
menu, tray, add, Manually Update YEP (WIN+Y), ManualUpdate
menu, tray, add, Force YEP Update, ForceUpdate
menu, tray, add
menu, tray, add, Enable YEP Auto-Update, EnableToggle
menu, Interval, add, Every 1 Hour, SetInterval1h
menu, Interval, add, Every 2 Hours, SetInterval2h
menu, Interval, add, Every 4 Hours, SetInterval4h
menu, Interval, add, Every 8 Hours, SetInterval8h
menu, Interval, add, Every 12 Hours, SetInterval12h
menu, Interval, add, Every 24 Hours, SetInterval24h
menu, tray, add, Set Update Interval, :Interval
menu, Notifications, add, Notify on Update, NotifyUpdate
menu, Notifications, add, Notify on No Updates, NotifyNoUpdate
menu, tray, add, Notifications, :Notifications
menu, tray, add
menu, ExtractionTool, add, 7-Zip, SetExTool7zip
menu, ExtractionTool, add, WinRAR, SetExToolwinrar
menu, tray, add, Extraction Tool, :ExtractionTool
menu, tray, add
menu, tray, add, Add Project Directory, AddProjectDir
menu, tray, add, Edit Project Directories, EditProjectDirs
menu, tray, add, Edit Config File, EditConfigFile
menu, tray, add
menu, Links, add, Visit Yanfly's YEP Page on yanfly.moe, VisitYEP
menu, Links, add, Support Yanfly on Patreon, VisitPatreon
menu, Links, add, Watch Yanfly's Videos on YouTube, VisitYouTube
menu, Links, add
menu, Links, add, Visit Nekoyoubi over at Stitch Gaming, VisitStitch
menu, tray, add, Links, :Links
menu, tray, add
menu, tray, add, Close YEP Auto-Update, CloseAU
menu, tray, NoStandard

; Hour-to-Millisecond translation.
e1h 	:= 3600000	; 1*60*60*1000
e2h 	:= 7200000	; 2*60*60*1000
e4h 	:= 14400000	; 4*60*60*1000
e8h		:= 28800000	; 8*60*60*1000
e12h	:= 43200000	; 12*60*60*1000
e24h	:= 86400000	; 24*60*60*1000

; Reads config file; if none exists, writes the initial.
IfNotExist, config.ini
{
	IniWrite, 1, config.ini, Config, AutoUpdateActive
	IniWrite, 12, config.ini, Config, AutoUpdateInterval
	IniWrite, 1, config.ini, Config, NotifyUpdate
	IniWrite, 0, config.ini, Config, NotifyNoUpdate
	IniWrite, 20, config.ini, Config, NotifyClose
	IniWrite, http://yanfly.moe/yep/changelog/, config.ini, Config, ChangelogURL
	IniWrite, https://www.dropbox.com/s/ihnfafxhvfpq39f/- YEP English -.rar?dl=1, config.ini, Config, YEPURL
	IniWrite, 7zip, config.ini, Config, ExtractionTool
	IniWrite, 7z.exe, config.ini, Config, 7ZipPath
	IniWrite, unrar.exe, config.ini, Config, WinRARPath
}

; Reads in the config file and sets up initial variables.
IniRead, auOn, config.ini, Config, AutoUpdateActive, 1
IniRead, auInterval, config.ini, Config, AutoUpdateInterval, 12
IniRead, auNotifyUpdate, config.ini, Config, NotifyUpdate, 1
IniRead, auNotifyNoUpdate, config.ini, Config, NotifyNoUpdate, 0
IniRead, auNotifyClose, config.ini, Config, NotifyClose, 20
IniRead, auChangelogURL, config.ini, Config, ChangelogURL, http://yanfly.moe/yep/changelog/
IniRead, auYEPURL, config.ini, Config, YEPURL, https://www.dropbox.com/s/ihnfafxhvfpq39f/- YEP English -.rar?dl=1
IniRead, auExTool, config.ini, Config, ExtractionTool, 7zip
IniRead, au7zPath, config.ini, Config, 7ZipPath, 7z.exe
IniRead, auUnrarPath, config.ini, Config, WinRARPath, unrar.exe

; Checks to make sure the directory listing is accounted for. If not, creates it, and instructs the user on its use.
IfNotExist, yep_dirs.txt
{
	FileAppend,, yep_dirs.txt
	IfNotExist, *.rpgproject
		Gosub, AddProjectDir
}

if (auOn) {
	menu, tray, tip, YEP Auto-Update: On
	menu, tray, check, Enable YEP Auto-Update
} else {
	menu, tray, tip, YEP Auto-Update: Off
}

auRunEvery := auInterval*60*60*1000

; If the interval specified in the config file doesn't line up with a menu item none will
; be selected, but it should still allow you to set any amount of hours needed.
if (auInterval == 1) {
	menu, Interval, check, Every 1 Hour
} else if (auInterval == 2) {
	menu, Interval, check, Every 2 Hours
} else if (auInterval == 4) {
	menu, Interval, check, Every 4 Hours
} else if (auInterval == 8) {
	menu, Interval, check, Every 8 Hours
} else if (auInterval == 12) {
	menu, Interval, check, Every 12 Hours
} else if (auInterval == 24) {
	menu, Interval, check, Every 24 Hours
}

if (auNotifyUpdate) {
	menu, Notifications, check, Notify on Update
}

if (auNotifyNoUpdate) {
	menu, Notifications, check, Notify on No Updates
}

if (auExTool = "7zip") {
	menu, ExtractionTool, check, 7-Zip
} else if  (auExTool = "winrar"){
	menu, ExtractionTool, check, WinRAR
}

; Sets the initial timer that will handle the YEP auto-updates.
SetTimer, AutoUpdate, %auRunEvery%
Return

; SUPER(WIN)+Y  --  Runs a manual update of the YEP scripts.
#y::Gosub, Update

; Handles all the checking, downloading, and installing of the YEP scripts.
Update:
	; Downloads Yanfly's changelog to scrape the most current plugin updates revision date.
	UrlDownloadToFile, %auChangelogURL%, changelog.txt
	FileRead, changelog, changelog.txt
	RegExMatch(changelog, "Plugin Updates as of Launch Date to .*?\<strong\>(.*?)\<\/strong\>\<\/span\>\~", updated)
	FileDelete, changelog.txt

	; Notifies the user if an update was not found (message box self-closes after 20 seconds).
	if (!auForceUpdate) {	
		if (auNotifyNoUpdate) {
			IfExist, yep_%updated1%.rar
			{
				MsgBox,, YEP Auto-Update, No update was necessary. YEP already at version %updated1%., %auNotifyClose%
				Return
			}
		}
	} else {
		FileDelete, yep_%updated1%.rar
		auForceUpdate := false
	}

	; If the current YEP version is not found, download it.
	IfNotExist, yep_%updated1%.rar
	{
		UrlDownloadToFile, %auYEPURL%, yep_%updated1%.rar
		FileGetSize, dirsize, yep_dirs.txt
		; Check for a non-0-byte dirs file. If found, cycle through the directories, extracting the YEP into each.
		; Otherwise, assume the current directory is a project root, and extract once into its js/plugins.
		if (dirsize > 0) {
			Loop, Read, yep_dirs.txt
			{
				if (auExTool = "7zip") {
					RunWait %au7zPath% x yep_%updated1%.rar -aoa -o%A_LoopReadLine%\js\plugins,,hide
				} else if (auExTool = "winrar"){
					RunWait %auUnrarPath% x yep_%updated1%.rar -o+ %A_LoopReadLine%\js\plugins,,hide					
				}
			}
		} else {
				if (auExTool = "7zip") {
					RunWait %au7zPath% x yep_%updated1%.rar -aoa -ojs\plugins,,hide
				} else if (auExTool = "winrar"){
					RunWait %auUnrarPath% x yep_%updated1%.rar -o+ js\plugins,,hide					
				}
		}
		; Once download and extraction are complete, notify the user that they have a new YEP (if they want to know).
		if (auNotifyUpdate) {
			MsgBox,, YEP Auto-Update, YEP successfully updated to version %updated1%., %auNotifyClose%
		}
	}
Return

; Checks if the auto-update is enabled. If so, runs the Update routine. Used by the timer.
AutoUpdate:
	if (auOn){
		Gosub, Update
	}
Return

; Activates the update regardless of schedule. Does not reset the timer.
ManualUpdate:
	Gosub, Update
Return

ForceUpdate:
	auForceUpdate := true
	Gosub, Update
Return

; Toggles whether the auto-update timer will have any effect.
EnableToggle:
	menu, tray, togglecheck, Enable YEP Auto-Update
	auOn := !auOn
	tip := auOn ? "On" : "Off"
	menu, tray, tip, YEP Auto-Update: %tip%
	IniWrite, %auOn%, config.ini, Config, AutoUpdateActive
Return

; Sets the auto-update timer to 1 hour intervals.
SetInterval1h:
	if (auRunEvery != e1h) {
		auRunEvery := e1h
		menu, Interval, check, Every 1 Hour
		menu, Interval, uncheck, Every 2 Hours
		menu, Interval, uncheck, Every 4 Hours
		menu, Interval, uncheck, Every 8 Hours
		menu, Interval, uncheck, Every 12 Hours
		menu, Interval, uncheck, Every 24 Hours
		IniWrite, 1, config.ini, Config, AutoUpdateInterval
		SetTimer, AutoUpdate, %auRunEvery%
	}
Return

; Sets the auto-update timer to 2 hour intervals.
SetInterval2h:
	if (auRunEvery != e2h) {
		auRunEvery := e2h
		menu, Interval, uncheck, Every 1 Hour
		menu, Interval, check, Every 2 Hours
		menu, Interval, uncheck, Every 4 Hours
		menu, Interval, uncheck, Every 8 Hours
		menu, Interval, uncheck, Every 12 Hours
		menu, Interval, uncheck, Every 24 Hours
		IniWrite, 2, config.ini, Config, AutoUpdateInterval
		SetTimer, AutoUpdate, %auRunEvery%
	}
Return

; Sets the auto-update timer to 4 hour intervals.
SetInterval4h:
	if (auRunEvery != e4h) {
		auRunEvery := e4h
		menu, Interval, uncheck, Every 1 Hour
		menu, Interval, uncheck, Every 2 Hours
		menu, Interval, check, Every 4 Hours
		menu, Interval, uncheck, Every 8 Hours
		menu, Interval, uncheck, Every 12 Hours
		menu, Interval, uncheck, Every 24 Hours
		IniWrite, 4, config.ini, Config, AutoUpdateInterval
		SetTimer, AutoUpdate, %auRunEvery%
	}
Return

; Sets the auto-update timer to 8 hour intervals.
SetInterval8h:
	if (auRunEvery != e8h) {
		auRunEvery := e8h
		menu, Interval, uncheck, Every 1 Hour
		menu, Interval, uncheck, Every 2 Hours
		menu, Interval, uncheck, Every 4 Hours
		menu, Interval, check, Every 8 Hours
		menu, Interval, uncheck, Every 12 Hours
		menu, Interval, uncheck, Every 24 Hours
		IniWrite, 8, config.ini, Config, AutoUpdateInterval
		SetTimer, AutoUpdate, %auRunEvery%
	}
Return

; Sets the auto-update timer to 12 hour intervals.
SetInterval12h:
	if (auRunEvery != e12h) {
		auRunEvery := e12h
		menu, Interval, uncheck, Every 1 Hour
		menu, Interval, uncheck, Every 2 Hours
		menu, Interval, uncheck, Every 4 Hours
		menu, Interval, uncheck, Every 8 Hours
		menu, Interval, check, Every 12 Hours
		menu, Interval, uncheck, Every 24 Hours
		IniWrite, 12, config.ini, Config, AutoUpdateInterval
		SetTimer, AutoUpdate, %auRunEvery%
	}
Return

; Sets the auto-update timer to 24 hour intervals.
SetInterval24h:
	if (auRunEvery != e24h) {
		auRunEvery := e24h
		menu, Interval, uncheck, Every 1 Hour
		menu, Interval, uncheck, Every 2 Hours
		menu, Interval, uncheck, Every 4 Hours
		menu, Interval, uncheck, Every 8 Hours
		menu, Interval, uncheck, Every 12 Hours
		menu, Interval, check, Every 24 Hours
		IniWrite, 24, config.ini, Config, AutoUpdateInterval
		SetTimer, AutoUpdate, %auRunEvery%
	}
Return

; Toggles the notification that there was an update (updated successfully).
NotifyUpdate:
	menu, Notifications, togglecheck, Notify on Update
	auNotifyUpdate := !auNotifyUpdate
	IniWrite, %auNotifyUpdate%, config.ini, Config, NotifyUpdate
Return

; Toggles the notification that there were no updates (changelog downloaded, but nothing changed).
NotifyNoUpdate:
	menu, Notifications, togglecheck, Notify on No Updates
	auNotifyNoUpdate := !auNotifyNoUpdate
	IniWrite, %auNotifyNoUpdate%, config.ini, Config, NotifyNoUpdate
Return

; Allows the user to add RMMV project directories with a handy-dandy visual dialog.
AddProjectDir:
	FileSelectFolder, auAddProject, *%A_WorkingDir%, 1, Please select your RMMV project's root folder...
	if auAddProject !=
	{
		FileGetSize, auDirsSize, yep_dirs.txt
		if (auDirsSize > 0) {
			FileAppend,`r`n%auAddProject%, yep_dirs.txt
		} else {
			FileAppend,%auAddProject%, yep_dirs.txt
		}
		MsgBox,, YEP Auto-Update, %auAddProject%`r`n`r`n... was added to your yep_dirs.txt file., %auNotifyClose%
	}
Return

; Opens the yep_dirs.txt file for editing.
EditProjectDirs:
	Run yep_dirs.txt
Return

; Opens the config.ini file for editing.
EditConfigFile:
	Run config.ini
Return

; Sets the active extraction tool to 7-Zip
SetExTool7zip:
	menu, ExtractionTool, check, 7-Zip
	menu, ExtractionTool, uncheck, WinRAR
	auExTool := "7zip"
	IniWrite, %auExTool%, config.ini, Config, ExtractionTool
Return

; Sets the active extraction tool to WinRAR
SetExToolwinrar:
	menu, ExtractionTool, uncheck, 7-Zip
	menu, ExtractionTool, check, WinRAR
	auExTool := "winrar"
	IniWrite, %auExTool%, config.ini, Config, ExtractionTool
Return

; The link to Yanfly's YEP page.
VisitYEP:
	Run http://yanfly.moe/yep/
Return

; The link to Yanfly's Patreon page.
VisitPatreon:
	Run https://www.patreon.com/Yanfly
Return

; The link to Yanfly's YouTube channel.
VisitYouTube:
	Run https://www.youtube.com/channel/UCxqti0F9VuiSWyqznaua_zA
Return

; The link to one of the author's sites.
VisitStitch:
	Run http://stitchgaming.com/
Return

; Closes the auto-update application.
CloseAU:
	ExitApp
Return