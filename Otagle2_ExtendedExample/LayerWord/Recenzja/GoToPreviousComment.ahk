GoToPreviousComment()
{
	oWord := ComObjActive("Word.Application")
	PrevPos := oWord.Selection.Range.Start
	oWord.Browser.Target := wdBrowseComment := 3
	oWord.Browser.Previous
	CurPos := oWord.Selection.Range.Start
	if (PrevPos <= CurPos)
		MsgBox, Brak wcze�niejszych komentarzy.
	oWord := ""
	WinActivate, ahk_class OpusApp
	return
}