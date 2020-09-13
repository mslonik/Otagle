PreviousChangeOrComment() ; poprzednia zmiana lub komentarz
;~ by Jakub Masiak
{	
	oWord := ComObjActive("Word.Application")
	try
		oWord.WordBasic.PreviousChangeOrComment
	oWord := ""
	WinActivate, ahk_class OpusApp
	WinGetPos, WinX, WinY,WinW,WinH,A
    mouseX := Round(WinX+WinW/2)
    mouseY := Round(WinY+WinH/2)
    DllCall("SetCursorPos", "int", mouseX, "int", mouseY)
	return
}