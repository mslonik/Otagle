VersionAndAdjustationFinal() 
{
	oWord := ComObjActive("Word.Application")
	StateOfOriginalAdjustation := oWord.ActiveWindow.View.ShowRevisionsAndComments
	if (StateOfOriginalAdjustation = -1)
		{
		oWord.ActiveWindow.View.ShowRevisionsAndComments := 0
		}
	else
		{
		oWord.ActiveWindow.View.ShowRevisionsAndComments := -1
		}
		oWord.ActiveWindow.View.RevisionsView := wdRevisionsViewFinal := 0	
	oWord := "" 
	WinActivate, ahk_class OpusApp
	WinGetPos, WinX, WinY,WinW,WinH,A
    mouseX := Round(WinX+WinW/2)
    mouseY := Round(WinY+WinH/2)
    DllCall("SetCursorPos", "int", mouseX, "int", mouseY)
	return
}