﻿GoToNextComment() ; Przejd� do kolejnego komentarza
{
	oWord := ComObjActive("Word.Application")
	PrevPos := oWord.Selection.Range.Start
	oWord.Browser.Target := wdBrowseComment := 3
	oWord.Browser.Next 
	CurPos := oWord.Selection.Range.Start
	if (PrevPos >= CurPos)
		MsgBox, % "Brak późniejszych komentarzy."
	oWord := ""
	WinActivate, ahk_class OpusApp
	WinGetPos, WinX, WinY,WinW,WinH,A
    mouseX := Round(WinX+WinW/2)
    mouseY := Round(WinY+WinH/2)
    DllCall("SetCursorPos", "int", mouseX, "int", mouseY)
	return
}