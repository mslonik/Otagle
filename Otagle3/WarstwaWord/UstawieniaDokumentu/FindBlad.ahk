FindBlad()
{
    static akBlad
    global indBlad := 0
    global bladArray := []
    global noBlad
    oWord := ComObjActive("Word.Application")
    cntField := oWord.ActiveDocument.Fields.Count
    WinActivate, ahk_class OpusApp
    oWord.ActiveDocument.Bookmarks.Add("bladBook")
    oWord.ScreenUpdating := 0
    Gui, BladSearch:New, -Border +AlwaysOnTop
    Gui, BladSearch:Add, Text,, Przeszukiwanie pól:
    Gui, BladSearch:Add, Text, x+m vakBlad w50
    Gui, BladSearch:Show
    Loop, % cntField
    {
        GuiControl,, akBlad, %A_Index%/%cntField%
        if (oWord.ActiveDocument.Fields(A_Index).Type == 3)
        {
            oWord.ActiveDocument.Fields(A_Index).Select
            temp := oWord.Selection.Text
            if (InStr(temp, "Błąd"))
            {
                bladArray.Push(A_Index)
            }
        }
    }
    Gui, BladSearch:Destroy
    oWord.ScreenUpdating := -1
    noBlad := bladArray.MaxIndex()
    if (noBlad >= 1)
    {
        Gui, Blad:New, -Border +AlwaysOnTop
        Gui, Blad:Add, Text,w200, Liczba wystąpień słowa "błąd": %noBlad%
        Gui, Blad:Add, Button,gbladPop Disabled, Poprzedni
        Gui, Blad:Add, Button,gbladNast yp x+m Disabled, Następny
        Gui, Blad:Add, Button,yp x+m gbladEnd, Koniec
        if (noBlad > 1)
            GuiControl, Enable, Następny
        Gui, Blad:Show
        WinActivate, ahk_class OpusApp
        indBlad := 1
        oWord.ActiveDocument.Fields(bladArray[indBlad]).Select        
    }
    else
    {
        oWord.Selection.GoTo(-1,,,"bladBook")
        MsgBox, Nie znaleziono słowa "błąd".
    }
    oWord.ActiveDocument.Bookmarks("bladBook").Delete
    oWord := ""
    return

    bladPop:
    oWord := ComObjActive("Word.Application")
    WinActivate, ahk_class OpusApp
    indBlad := indBlad - 1
    oWord.ActiveDocument.Fields(bladArray[indBlad]).Select
    if (indBlad == 1)
        GuiControl, Disable, Poprzedni
    if (indBlad < noBlad)
        GuiControl, Enable, Następny
    oWord := ""
    return

    bladNast:
    oWord := ComObjActive("Word.Application")
    WinActivate, ahk_class OpusApp
    indBlad := indBlad + 1
    oWord.ActiveDocument.Fields(bladArray[indBlad]).Select
    if (indBlad == noBlad)
        GuiControl, Disable, Następny
    if (indBlad > 1)
        GuiControl, Enable, Poprzedni
    oWord := ""
    return

    bladEnd:
    BladGuiEscape:
    Gui, Blad:Destroy
    return
}