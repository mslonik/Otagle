FindDeadLinks()
{
    static akDeadLink
    global indDeadLink := 0
    global DeadLinkArray := []
    global noDeadLink
    oWord := ComObjActive("Word.Application")
    cntField := oWord.ActiveDocument.Fields.Count
    WinActivate, ahk_class OpusApp
    oWord.ActiveDocument.Bookmarks.Add("DeadLinkBook")
    oWord.ScreenUpdating := 0
    Gui, DeadLinkSearch:New, -Border +AlwaysOnTop
    Gui, DeadLinkSearch:Add, Text,, Przeszukiwanie pól:
    Gui, DeadLinkSearch:Add, Text, x+m vakDeadLink w50
    Gui, DeadLinkSearch:Show
    Loop, % cntField
    {
        GuiControl,, akDeadLink, %A_Index%/%cntField%
        if (oWord.ActiveDocument.Fields(A_Index).Type == 3)
        {
            oWord.ActiveDocument.Fields(A_Index).Select
            temp := oWord.Selection.Text
            if (temp == "0")
            {
                DeadLinkArray.Push(A_Index)
            }
        }
    }
    Gui, DeadLinkSearch:Destroy
    oWord.ScreenUpdating := -1
    noDeadLink := DeadLinkArray.MaxIndex()
    if (noDeadLink >= 1)
    {
        Gui, DeadLink:New, -Border +AlwaysOnTop
        Gui, DeadLink:Add, Text,w200, Liczba martwych łącz: %noDeadLink%
        Gui, DeadLink:Add, Button,gDeadLinkPop Disabled, Poprzedni
        Gui, DeadLink:Add, Button,gDeadLinkNast yp x+m Disabled, Następny
        Gui, DeadLink:Add, Button,yp x+m gDeadLinkEnd, Koniec
        if (noDeadLink > 1)
            GuiControl, Enable, Następny
        Gui, DeadLink:Show
        WinActivate, ahk_class OpusApp
        indDeadLink := 1
        oWord.ActiveDocument.Fields(DeadLinkArray[indDeadLink]).Select        
    }
    else
    {
        oWord.Selection.GoTo(-1,,,"DeadLinkBook")
        MsgBox, Nie znaleziono martwych łączy.
    }
    oWord.ActiveDocument.Bookmarks("DeadLinkBook").Delete
    oWord := ""
    return

    DeadLinkPop:
    oWord := ComObjActive("Word.Application")
    WinActivate, ahk_class OpusApp
    indDeadLink := indDeadLink - 1
    oWord.ActiveDocument.Fields(DeadLinkArray[indDeadLink]).Select
    if (indDeadLink == 1)
        GuiControl, Disable, Poprzedni
    if (indDeadLink < noDeadLink)
        GuiControl, Enable, Następny
    oWord := ""
    return

    DeadLinkNast:
    oWord := ComObjActive("Word.Application")
    WinActivate, ahk_class OpusApp
    indDeadLink := indDeadLink + 1
    oWord.ActiveDocument.Fields(DeadLinkArray[indDeadLink]).Select
    if (indDeadLink == noDeadLink)
        GuiControl, Disable, Następny
    if (indDeadLink > 1)
        GuiControl, Enable, Poprzedni
    oWord := ""
    return

    DeadLinkEnd:
    DeadLinkGuiEscape:
    Gui, DeadLink:Destroy
    return
}