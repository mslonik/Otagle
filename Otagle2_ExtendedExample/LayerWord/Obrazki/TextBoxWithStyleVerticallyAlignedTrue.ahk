TextBoxWithStyleVerticallyAlignedTrue()
	{
	oWord := ComObjActive("Word.Application")
	oWord.Selection.ShapeRange.CanvasItems.AddTextBox(Orientation := msoTextOrientationHorizontal := 1, Left := 50, Top := 50, Width := 75, Height := 25).Select
	oWord.Selection.ChildShapeRange.Line.Visible := -1
	oWord.Selection.ChildShapeRange.Fill.Visible := 0
	oWord.Selection.ChildShapeRange.TextFrame.VerticalAnchor := msoAnchorMiddle := 3
	oWord.Selection.TypeText("Fikumiku")
	oWord.Selection.StartOf(Unit := wdLine := 5, Extend := wdExtend := 1)
	oWord.Selection.Style := "Pola tekstowe ms"
	oWord := "" ; Clear global COM objects when done with them
	WinActivate, ahk_class OpusApp
	return
	}	