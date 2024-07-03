DeleteInterline() ; usuwa interlinię u góry strony (przerwę poprzedzającą ustawia na zero pkt; przywrócenie domyślnego formatowania akapitu: Ctrl + q)
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
