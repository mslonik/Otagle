#NoEnv
#SingleInstance Force
#Persistent
SetWorkingDir, %A_ScriptDir%
SetBatchLines, -1

flagFlow := 0
SetTimer, Update, 250

#Include *i Otagle.ahk
return

Update:
if !WinExist(A_ScriptName) and (flagFlow == 1)
{
   MsgBox, %A_ScriptName%
   SetTimer, Update, Off
}
if WinExist(A_ScriptName)
{
   flagFlow := 1
}
prvWin := ActWin
prvExe := ActExe
WinGetClass, ActWin, A
if (ActWin == "AutoHotkeyGUI")
   ActWin := prvWin
WinGet, ActExe, ProcessName, A
if (ActExe == "AutoHotkey.exe")
   ActEve := prvExe
if (ActWin == "OpusApp")
{
   oWord := ComObjActive("Word.Application")
   if ((oWord.Selection.Type == 7) or (oWord.Selection.Type == 8))
   {
      if (prvCon != "obrazek")
         ReloadF(8)
      prvCon := "obrazek"
   }
   else if (oWord.Selection.Information(12))
   {
      if (prvCon != "tabela")
         ReloadF(7) 
      prvCon := "tabela"
   }
   else if (oWord.Selection.Information(26))
   {
      if (prvCon != "recenzja")
         ReloadF(11)
      prvCon := "recenzja"
   }
   else
   {
      if (prvCon != "inne")
         ReloadF(2)
      prvCon := "inne"
   }
   oWord := ""
}
else if ((ActWin == "TTOTAL_CMD") and (prvWin != ActWin))
{
   ReloadF(13)
   prvCon := ""
}
else
{
   prvCon := ""
}
return

ReloadF(layer)
{
    global
    try
    {
      neutron.Load("PlikiHtml/Layer" . layer . ".html")
    }
    return
}