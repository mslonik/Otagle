DeleteInterline() ; usuwa interlini� u g�ry strony (przerw� poprzedzaj�c� ustawia na zero pkt; przywr�cenie domy�lnego formatowania akapitu: Ctrl + q)
;~ by Jakub Masiak
{
	oWord := ComObjActive("Word.Application")
	varInter := oWord.Selection.ParagraphFormat.SpaceBefore
	if (varInter = 48)
		{
		oWord.Selection.ParagraphFormat.SpaceBefore := 0
		}
	else if (varInter = 0)
		{
		oWord.Selection.ParagraphFormat.SpaceBefore := 48
		}
	oWord := ""
	WinActivate, ahk_class OpusApp
	return
}
