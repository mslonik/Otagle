EditComment() ; edytuj komentarz
{	
	oWord := ComObjActive("Word.Application")
	try
	{
		cursorPosition := oWord.Selection.Range
		oWord.WordBasic.AnnotationEdit
	}
	catch e
	{
		MsgBox, 48,, Aby edytowa� komentarz, musisz umie�ci� kursor w obr�bie tekstu, kt�rego komentarz dotyczy.
	}
	oWord := ""
	WinActivate, ahk_class OpusApp
	return
}