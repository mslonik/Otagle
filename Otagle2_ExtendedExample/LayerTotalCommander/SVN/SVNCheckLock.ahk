SVNCheckLock()
{
	WinActivate, ahk_class TTOTAL_CMD
	if WinActive("ahk_class TTOTAL_CMD")
	{
		Send, {AppsKey}
		Send, {t down}{t up}
		Send, {r down}{r up}
	}
}