Hotstrings()
{
    DetectHiddenWindows, On
    SetTitleMatchMode, 2
    If !(WinExist("Hotstrings3.ahk" . " ahk_class AutoHotkey"))
        Run, ..\Hotstrings3\Hotstrings3.ahk
    Sleep, 200
    Send, ^#h
    return
}