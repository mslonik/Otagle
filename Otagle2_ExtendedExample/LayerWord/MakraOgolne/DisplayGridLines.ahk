DisplayGridLines() ; w��cz / wy��cz linie siatki
;~ by Jakub Masiak
{
	oWord := ComObjActive("Word.Application")
	oWord.Options.DisplayGridLines := Not oWord.Options.DisplayGridLines
	oWord := ""
	WinActivate, ahk_class OpusApp
	return
}