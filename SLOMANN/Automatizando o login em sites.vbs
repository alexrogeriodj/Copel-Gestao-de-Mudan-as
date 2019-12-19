Set WshShell = WScript.CreateObject("WScript.Shell")

WshShell.AppActivate "Internet Explorer, Google Crome, Mozilla Firefox"
Wscript.Sleep 1500
WshShell.SendKeys "{TAB}"
Wscript.Sleep 1500
WshShell.SendKeys "{TAB}"
Wscript.Sleep 1500
WshShell.SendKeys "{ENTER}"
Wscript.Sleep 1500