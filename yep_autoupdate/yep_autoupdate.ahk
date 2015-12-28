#SingleInstance, force
#Persistent

menu, tray, icon, yep_yanfly.ico
menu, tray, tip, YEP Auto-Update: On
menu, tray, add, Manually Update YEP, ManualUpdate
menu, tray, add
menu, tray, add, Enable YEP Auto-Update, EnableToggle
menu, tray, check, Enable YEP Auto-Update
menu, Interval, add, Every 1 Hour, SetInterval1h
menu, Interval, add, Every 2 Hours, SetInterval2h
menu, Interval, add, Every 4 Hours, SetInterval4h
menu, Interval, add, Every 8 Hours, SetInterval8h
menu, Interval, add, Every 12 Hours, SetInterval12h
menu, Interval, add, Every 24 Hours, SetInterval24h
menu, Interval, check, Every 12 Hours
menu, tray, add, Set Update Interval, :Interval
menu, tray, add
menu, Notifications, add, Notify on Update, NotifyUpdate
menu, Notifications, check, Notify on Update
menu, Notifications, add, Notify on No Updates, NotifyNoUpdate
menu, tray, add, Notifications, :Notifications
menu, Links, add, Visit Yanfly's YEP Page on yanfly.moe, VisitYEP
menu, Links, add, Support Yanfly on Patreon, VisitPatreon
menu, Links, add, Watch Yanfly's Videos on YouTube, VisitYouTube
menu, Links, add
menu, Links, add, Visit Nekoyoubi over at Stitch Gaming, VisitStitch
menu, tray, add, Links, :Links
menu, tray, add
menu, tray, add, Close YEP Auto-Update, CloseAU
menu, tray, NoStandard

auOn := true
auNotifyUpdate := true
auNotifyNoUpdate := false
auRunEvery := 43200000

; Hour-to-Millisecond translation.
e1h 	:= 3600000	; 1*60*60*1000
e2h 	:= 7200000	; 2*60*60*1000
e4h 	:= 14400000	; 4*60*60*1000
e8h		:= 28800000	; 8*60*60*1000
e12h	:= 43200000	; 12*60*60*1000
e24h	:= 86400000	; 24*60*60*1000

SetTimer, AutoUpdate, %auRunEvery%

#y::Gosub, Update

Update:
{
	; Checks to make sure the directory listing is accounted for. If not, creates it, and instructs the user on its use.
	IfNotExist, yep_dirs.txt
	{
		FileAppend, yep`r`n..\SampleProject, yep_dirs.txt
		MsgBox,, YEP Auto-Update, The file 'yep_dirs.txt' was not found. A new one has been created for you.`r`n`r`nPlease ensure that any projects that use YEP are included in this line-delimited path list. YEP updates will be extracted to extracted to these folders' subdirectory, js/plugins, so please only list the root RMMV project folders.`r`n`r`nIf you are running this from inside your project, simply delete the contents of this file.
		Return
	}

	; Downloads Yanfly's changelog to scrape the most current plugin updates revision date.
	UrlDownloadToFile, http://yanfly.moe/yep/changelog/, changelog.txt
	FileRead, changelog, changelog.txt
	RegExMatch(changelog, "Plugin Updates as of Launch Date to .*?\<strong\>(.*?)\<\/strong\>\<\/span\>\~", updated)
	FileDelete, changelog.txt

	; Notifies the user if an update was not found (message box self-closes after 20 seconds).
	if (auNotifyNoUpdate) {
		IfExist, yep_%updated1%.rar
		{
			MsgBox,, YEP Auto-Update, No update was necessary. YEP already at version %updated1%., 20
			Return
		}
	}

	IfNotExist, yep_%updated1%.rar
	{
		UrlDownloadToFile, https://www.dropbox.com/s/ihnfafxhvfpq39f/- YEP English -.rar?dl=1, yep_%updated1%.rar
		FileGetSize, dirsize, yep_dirs.txt
		if (dirsize > 0) {
			Loop, Read, yep_dirs.txt
				RunWait 7z.exe x yep_%updated1%.rar -aoa -o%A_LoopReadLine%\js\plugins,,hide
		} else {
			RunWait 7z.exe x yep_%updated1%.rar -aoa -ojs\plugins,,hide
		}
		if (auNotifyUpdate) {
			MsgBox,, YEP Auto-Update, YEP successfully updated to version %updated1%., 20
		}
		Return
	}
}

AutoUpdate:
	if (auOn){
		Gosub, Update
	}
Return

ManualUpdate:
	Gosub, Update
Return

EnableToggle:
	menu, tray, togglecheck, Enable YEP Auto-Update
	auOn := !auOn
	tip := auOn ? "On" : "Off"
	menu, tray, tip, YEP Auto-Update: %tip%
Return

SetInterval1h:
	if (auRunEvery == e1h){
		Return
	} else {
		auRunEvery := e1h
		menu, Interval, check, Every 1 Hour
		menu, Interval, uncheck, Every 2 Hours
		menu, Interval, uncheck, Every 4 Hours
		menu, Interval, uncheck, Every 8 Hours
		menu, Interval, uncheck, Every 12 Hours
		menu, Interval, uncheck, Every 24 Hours
		SetTimer, AutoUpdate, %auRunEvery%
	}
Return

SetInterval2h:
	if (auRunEvery == e2h){
		Return
	} else {
		auRunEvery := e2h
		menu, Interval, uncheck, Every 1 Hour
		menu, Interval, check, Every 2 Hours
		menu, Interval, uncheck, Every 4 Hours
		menu, Interval, uncheck, Every 8 Hours
		menu, Interval, uncheck, Every 12 Hours
		menu, Interval, uncheck, Every 24 Hours
		SetTimer, AutoUpdate, %auRunEvery%
	}
Return

SetInterval4h:
	if (auRunEvery == e4h){
		Return
	} else {
		auRunEvery := e4h
		menu, Interval, uncheck, Every 1 Hour
		menu, Interval, uncheck, Every 2 Hours
		menu, Interval, check, Every 4 Hours
		menu, Interval, uncheck, Every 8 Hours
		menu, Interval, uncheck, Every 12 Hours
		menu, Interval, uncheck, Every 24 Hours
		SetTimer, AutoUpdate, %auRunEvery%
	}
Return

SetInterval8h:
	if (auRunEvery == e8h){
		Return
	} else {
		auRunEvery := e8h
		menu, Interval, uncheck, Every 1 Hour
		menu, Interval, uncheck, Every 2 Hours
		menu, Interval, uncheck, Every 4 Hours
		menu, Interval, check, Every 8 Hours
		menu, Interval, uncheck, Every 12 Hours
		menu, Interval, uncheck, Every 24 Hours
		SetTimer, AutoUpdate, %auRunEvery%
	}
Return

SetInterval12h:
	if (auRunEvery == e12h){
		Return
	} else {
		auRunEvery := e12h
		menu, Interval, uncheck, Every 1 Hour
		menu, Interval, uncheck, Every 2 Hours
		menu, Interval, uncheck, Every 4 Hours
		menu, Interval, uncheck, Every 8 Hours
		menu, Interval, check, Every 12 Hours
		menu, Interval, uncheck, Every 24 Hours
		SetTimer, AutoUpdate, %auRunEvery%
	}
Return

SetInterval24h:
	if (auRunEvery == e24h){
		Return
	} else {
		auRunEvery := e24h
		menu, Interval, uncheck, Every 1 Hour
		menu, Interval, uncheck, Every 2 Hours
		menu, Interval, uncheck, Every 4 Hours
		menu, Interval, uncheck, Every 8 Hours
		menu, Interval, uncheck, Every 12 Hours
		menu, Interval, check, Every 24 Hours
		SetTimer, AutoUpdate, %auRunEvery%
	}
Return

NotifyUpdate:
	menu, Notifications, togglecheck, Notify on Update
	auNotifyUpdate := !auNotifyUpdate
Return

NotifyNoUpdate:
	menu, Notifications, togglecheck, Notify on No Updates
	auNotifyNoUpdate := !auNotifyNoUpdate
Return

VisitYEP:
	Run http://yanfly.moe/yep/
Return

VisitPatreon:
	Run https://www.patreon.com/Yanfly
Return

VisitYouTube:
	Run https://www.youtube.com/channel/UCxqti0F9VuiSWyqznaua_zA
Return

VisitStitch:
	Run http://stitchgaming.com/
Return

CloseAU:
	ExitApp
Return