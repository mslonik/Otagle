F11::
UsunKolor()
Return

F12::
ZielenKolor()
Return

UsunKolor(){
oWord := ComObjActive("Word.Application")
Loop, % oWord.ActiveDocument.Styles.Count{
 
testCheck := (oWord.ActiveDocument.Styles(A_Index).Type == 1) And (InStr(oWord.ActiveDocument.Styles(A_Index).NameLocal, "ms"))
    oWord.ActiveDocument.ActiveWindow.view.DisplayBackgrounds := True
    oWord.ActiveDocument.Background.Fill.Visible := -1
    oWord.ActiveDocument.Background.Fill.ForeColor.RGB := 0xFFFFFF
    oWord.ActiveDocument.Background.Fill.Solid

If (testCheck){
    var := oWord.ActiveDocument.Styles(A_Index).ParagraphFormat
    var.Shading.Texture := 0
    var.Shading.ForegroundPatternColor := -16777216
    var.Shading.BackgroundPatternColor := -16777216
}

}
oWord :=  "" ; Clear global COM objects when done with them
WinActivate, ahk_class OpusApp
Return
}

ZielenKolor()
{
oWord := ComObjActive("Word.Application")
Loop, % oWord.ActiveDocument.Styles.Count{
 
testCheck := (oWord.ActiveDocument.Styles(A_Index).Type == 1) And (InStr(oWord.ActiveDocument.Styles(A_Index).NameLocal, "ms"))
    oWord.ActiveDocument.ActiveWindow.view.DisplayBackgrounds := True
    oWord.ActiveDocument.Background.Fill.Visible := -1
    oWord.ActiveDocument.Background.Fill.ForeColor.RGB := 0xa8d08d
    oWord.ActiveDocument.Background.Fill.Solid

If (testCheck){
    var := oWord.ActiveDocument.Styles(A_Index).ParagraphFormat
    var.Shading.Texture := 0
    var.Shading.ForegroundPatternColor := -16777216
    var.Shading.BackgroundPatternColor := 13434828
}

}
oWord :=  "" ; Clear global COM objects when done with them
WinActivate, ahk_class OpusApp
Return
}
