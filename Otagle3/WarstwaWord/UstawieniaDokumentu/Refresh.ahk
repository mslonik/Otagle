Refresh()
{
    static RefTxt 

    OurTempPL := "S:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-pl_OgolnyTechDok.dotm"
	OurTempEN := "S:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-en_OgolnyTechDok.dotm"
	LocTempPL := % A_WorkingDir . "\Templates\TQ-S402-pl_OgolnyTechDok.dotm"
	LocTempEN := % A_WorkingDir . "\Templates\TQ-S402-en_OgolnyTechDok.dotm"
	SzabPath := SubStr(A_ScriptDir, 1, InStr(A_ScriptDir, "AutoHotkeyScripts\Otagle")-1)
	SzabTempPL := % SzabPath . "OgolneZmakrami\szab_TQ-S402-pl_OgolnyTechDok.dotm"
	SzabTempEN := % SzabPath . "OgolneZmakrami\szab_TQ-S402-en_OgolnyTechDok.dotm"
    oWord := ComObjActive("Word.Application")
	OurTemplate := oWord.ActiveDocument.AttachedTemplate.FullName
	if  ((OurTemplate != OurTempPL) and (OurTemplate != OurTempEN) and (OurTemplate != LocTempPL) and (OurTemplate != LocTempEN) and (OurTemplate != SzabTempPL) and (OurTemplate != SzabTempEN))
	{
    	MsgBox, 16,% MsgText("Próba wywołania makra"), % MsgText("Próbujesz wywołać makro przypisane do szablonu, ale szablon nie został jeszcze dołączony do tego pliku. Najpierw dołącz szablon, a następnie wywołaj ponownie tę funkcję.")
	}
	else
	{
		oWord.ScreenUpdating := 0
        oWord.DisplayAlerts := 0
        
        Gui, Ref:New, -Border
        Gui, Ref:Add, Text, h25 w200 vRefTxt, % MsgText("Działanie makra w toku")
        Gui, Ref:Show, h25 w200

        if oWord.ActiveWindow.ActivePane.view.SeekView == 0
        {
             oWord.Selection.Bookmarks.Add("pozycja")
        }

        GuiControl,, RefTxt, % MsgText("Odświeżanie pól")
        Loop, 17
        {
            try
            {
                oWord.ActiveDocument.StoryRanges(A_Index).Select
                oWord.Selection.Fields.Update
            }
        }

        GuiControl,, RefTxt, % MsgText("Odświeżanie spisów treści")
        toCcnt := oWord.ActiveDocument.TablesOfContents.Count
        Loop, %toCcnt%
        {
            oWord.ActiveDocument.TablesOfContents(A_Index).Update
        }
    
        oWord.Selection.Collapse(0)

        oWord.Application.DisplayAlerts := -1

        if oWord.ActiveDocument.Bookmarks.Exists("pozycja")
        {
            oWord.Selection.GoTo(-1,,,"pozycja")
            oWord.ActiveDocument.Bookmarks("pozycja").Delete
        }
        else
        {
            oWord.ActiveDocument.GoTo(6)
        }

        oWord.ActiveWindow.view.Type := 3
        oWord.Application.ScreenUpdating := -1
        Gui, Ref:Destroy
	}
	oWord :=  "" ; Clear global COM objects when done with them
	WinActivate, ahk_class OpusApp
	return
}