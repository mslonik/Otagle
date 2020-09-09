CheckingMacro()
{
    static 

    Gui, CheckMacro:New, -MinimizeBox -MaximizeBox
    Gui, CheckMacro:Font, s10
    Gui, CheckMacro:Add, Text,,Wybierz operacje do wykonania:
    Gui, CheckMacro:Add, CheckBox, gState vHeadings, % MsgText("Ustaw nagłówki i stopki")
    Gui, CheckMacro:Add, CheckBox, gState vSigns, % MsgText("Sprawdź znaki interpunkcyjne w listach numerowanych")
    Gui, CheckMacro:Add, CheckBox, gState vMultiSpaces, % MsgText("Usuń wielokrotne spacje i entery")   
    Gui, CheckMacro:Add, CheckBox, gState vRefresh,% MsgText("Odśwież dokument")
    Gui, CheckMacro:Add, CheckBox, gState vHardSpace,% MsgText("Zamień spacje w dokumencie na twarde spacje")
    Gui, CheckMacro:Add, CheckBox, gState vHyperlinks, % MsgText("Zamień odsyłacze na hiperłącza")
    Gui, CheckMacro:Add, CheckBox, gState vFailure, % MsgText("Poszukaj słowa ""błąd""")
    Gui, CheckMacro:Add, CheckBox, gState vSize, % MsgText("Zmniejsz rozmiar obrazków w dokumencie")
    Gui, CheckMacro:Add, Text, xm+15, Zaktualizuj Change Log
    Gui, CheckMacro:Add, Button, gGoNext vGoNext Disabled, Dalej
    Gui, CheckMacro:Add, Button, yp x+m gCheckMacroGuiClose, Anuluj
    Gui, CheckMacro:Show, xCenter yCenter, Checklist
    return

    State:
        Gui, CheckMacro:Submit, NoHide
        if ((Headings) or (Signs) or (MultiSpaces) or (Refresh) or (HardSpace) or (HyperLinks) or (Failure) or (Size))
        {
            GuiControl, Enable, Dalej
        }
        else
        {
            GuiControl, Disable, Dalej
        }
    return

    GoNext:
        Gui, CheckMacro:Destroy
        cntCheck := Headings + Signs + MultiSpaces + HardSpace + Refresh + HyperLinks + Failure + Size
        Gui, CheckNext:New, -MinimizeBox -MaximizeBox AlwaysOnTop
        Gui, CheckNext:Add, Text, vCheckText w300
        Gui, CheckNext:Add, Button, gCheckNext w150 Disabled, % MsgText("Następny krok")
        Gui, CheckNext:Add, Button, gCheckNextGuiClose yp x+m w150 Disabled, % MsgText("Zakończ")
        Gui, CheckNext:Show
    
    CheckNext:

        checkFlag := 1
        if(Headings) and (CheckFlag)
        {
            CheckFlag := 0
            GuiControl, Disable, % MsgText("Następny krok")
            GuiControl,, CheckText, % MsgText("Ustawianie nagłówków i stopek...")
            SetHeadersAndFooters()
            Gui, CheckNext:Default
            GuiControl,, CheckText, % MsgText("Ustawiono nagłówki i stopki.")
            GuiControl, Enable, % MsgText("Następny krok")
            Headings := 0
        }
        if(Signs) and (CheckFlag)
        {
            CheckFlag := 0
            GuiControl, Disable, % MsgText("Następny krok")
            GuiControl,, CheckText, % MsgText("Sprawdzanie znaków interpunkcyjnych na końcach wypunktowań...")
            Wypunktowania()
            Gui, CheckNext:Default
            GuiControl,, CheckText, % MsgText("Sprawdzono znaki interpunkcyjne na końcach wypunktowań.")
            GuiControl, Enable, % MsgText("Następny krok")
            Signs := 0
        }            
        if(MultiSpaces) and (CheckFlag)
        {
            CheckFlag := 0
            GuiControl, Disable, % MsgText("Następny krok")
            GuiControl,, CheckText, % MsgText("Usuwanie wielokrotnych spacji i enterów...")
            UsunWielokrotneSpacje()
            Gui, CheckNext:Default
            GuiControl,, CheckText, % MsgText("Usunięto wielokrotne spacje i entery.")
            GuiControl, Enable, % MsgText("Następny krok")
            MultiSpaces := 0
        }
        if(HardSpace) and (CheckFlag)
        {
            CheckFlag := 0
            GuiControl, Disable, % MsgText("Następny krok")
            GuiControl,, CheckText, % MsgText("Zamiana spacji na twarde spacje...")
            TwardaSpacja()
            Gui, CheckNext:Default
            GuiControl,, CheckText, % MsgText("Zamieniono spacje na twarde spacje.")
            GuiControl, Enable, % MsgText("Następny krok")
            HardSpace := 0
        }
        if(Refresh) and (CheckFlag)
        {
            CheckFlag := 0
            GuiControl, Disable, % MsgText("Następny krok")
            GuiControl,, CheckText, % MsgText("Odświeżanie dokumentu...")
            Refresh()
            Gui, CheckNext:Default
            GuiControl,, CheckText, % MsgText("Odświeżono dokument.")
            GuiControl, Enable, % MsgText("Następny krok")
            Refresh := 0
        }
        if(HyperLinks) and (CheckFlag)
        {
            CheckFlag := 0
            GuiControl, Disable, % MsgText("Następny krok")
            GuiControl,, CheckText, % MsgText("Zamiana odsyłaczy na hiperłącza...")
            Hiperlacza()
            Refresh()
            Gui, CheckNext:Default
            GuiControl,, CheckText, % MsgText("Zamieniono odsyłacze na hiperłącza.")
            GuiControl, Enable, % MsgText("Następny krok")
            HyperLinks := 0
        }
        if(Failure) and (CheckFlag)
        {
            CheckFlag := 0
            GuiControl, Disable, % MsgText("Następny krok")
            GuiControl,, CheckText, % MsgText("Szukanie słowa 'błąd'...")
            FindBlad()
            Gui, CheckNext:Default
            GuiControl,, CheckText, % MsgText("Ukończono szukanie słowa 'błąd'.")
            GuiControl, Enable, % MsgText("Następny krok")
            Failure := 0
        }
        if(Size) and (CheckFlag)
        {
            CheckFlag := 0
            GuiControl, Disable, % MsgText("Następny krok")
            GuiControl,, CheckText, % MsgText("Zmniejszanie rozmiaru obrazków w dokumencie...")
            MsgBox, 0x34, Uwaga!, % MsgText("Przed zmniejszeniem obrazków dokument zostanie zamknięty i zapisany. Czy chcesz kontynuować?")
            IfMsgBox, Yes
            {
                oWord := ComObjActive("Word.Application")
                DocName := oWord.ActiveDocument.FullName
                oWord.ActiveDocument.Close(-1)
                oWord := ""
                ResizeImages(DocName)

            }
            Gui, CheckNext:Default
            GuiControl,, CheckText, % MsgText("Zmiejszono rozmiar obrazków w dokumencie.")
            GuiControl, Enable, % MsgText("Następny krok")
            Size := 0
        }
        cntCheck := cntCheck - 1
        if (cntCheck == 0)
        {
            GuiControl, Disable, % MsgText("Następny krok")
            GuiControl, Enable, % MsgText("Zakończ")

        }
    return

    CheckNextGuiEscape:
    CheckNextGuiClose:
        Gui, CheckNext:Destroy
        return

    CheckMacroGuiEscape:
    CheckMacroGuiClose:
        Gui, CheckMacro:Destroy
        return
}