GoToNextComment() ; Przejd� do kolejnego komentarza
{
	oWord := ComObjActive("Word.Application")
	PrevPos := oWord.Selection.Range.Start
	oWord.Browser.Target := wdBrowseComment := 3
	oWord.Browser.Next 
	CurPos := oWord.Selection.Range.Start
	if (PrevPos >= CurPos)
		MsgBox, Brak p�niejszych komentarzy.
	oWord := ""
	WinActivate, ahk_class OpusApp
	return
}