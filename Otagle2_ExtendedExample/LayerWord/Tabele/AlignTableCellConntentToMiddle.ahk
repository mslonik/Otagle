AlignTableCellConntentToMiddle() ; Wyr�wnanie tre�ci kom�rki do �rodka i do �rodka w pionie
{
	oWord := ComObjActive("Word.Application")
	oWord.Selection.SelectCell
	oWord.Selection.ParagraphFormat.Alignment := wdAlignParagraphCenter := 1
	oWord.Selection.Cells.VerticalAlignment := wdCellAlignVerticalCenter := 1
	oWord := "" ; Clear global COM objects when done with them
	WinActivate, ahk_class OpusApp
	return
}