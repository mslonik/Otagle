﻿AlignTableCellConntentToLeft() ; Wyrównanie treści komórki do lewej i do środka w pionie
{
	oWord := ComObjActive("Word.Application")
	oWord.Selection.SelectCell
	oWord.Selection.ParagraphFormat.Alignment := wdAlignParagraphLeft := 0
	oWord.Selection.Cells.VerticalAlignment := wdCellAlignVerticalCenter := 1
	oWord := "" ; Clear global COM objects when done with them
	WinActivate, ahk_class OpusApp
	return
}