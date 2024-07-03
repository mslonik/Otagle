InsertTableRowAbove() ; tabela: Wstaw wiersz powyżej
{
	oWord := ComObjActive("Word.Application")
	oWord.Selection.InsertRowsAbove(1)
	oWord := "" ; Clear global COM objects when done with them
	WinActivate, ahk_class OpusApp
	return
}