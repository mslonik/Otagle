MergeTableCells() ; po��cz zaznaczone kom�rki tabeli
{
	oWord := ComObjActive("Word.Application")
	try
		oWord.Selection.Cells.Merge
	catch 
		MsgBox, Zaznacz przynajmniej 2 kom�rki tabeli!
	oWord := ""
	WinActivate, ahk_class OpusApp
	return
}
