CheckingMacro()
{
    static 

    Gui, CheckMacro:New, -MinimizeBox -MaximizeBox
    Gui, CheckMacro:Font, s10
    Gui, CheckMacro:Add, Text,,Wybierz operacje do wykonania:
    Gui, CheckMacro:Add, CheckBox, gState vHeadings, Ustaw nagłówki i stopki
    Gui, CheckMacro:Add, CheckBox, gState vSigns, Sprawdź znaki interpunkcyjne w listach numerowanych
    Gui, CheckMacro:Add, CheckBox, gState vMultiSpaces, Usuń wielokrotne spacje i entery 
    Gui, CheckMacro:Add, CheckBox, gState vRefresh, Odśwież dokument
    Gui, CheckMacro:Add, CheckBox, gState vHardSpace, Zamień spacje w dokumencie na twarde spacje
    Gui, CheckMacro:Add, CheckBox, gState vHyperlinks, Zamień odsyłacze na hiperłącza
    Gui, CheckMacro:Add, CheckBox, gState vFailure, Poszukaj słowa "błąd"
    Gui, CheckMacro:Add, CheckBox, gState vDeadLinks, Poszukaj martwych łączy
    Gui, CheckMacro:Add, CheckBox, gState vSize, Zmniejsz rozmiar obrazków w dokumencie
    Gui, CheckMacro:Font, cRed bold
    Gui, CheckMacro:Add, Text, xm+15, Zaktualizuj Change Log
    Gui, CheckMacro:Font, cBlack norm
    Gui, CheckMacro:Add, Button, gGoNext vGoNext Disabled, Dalej
    Gui, CheckMacro:Add, Button, yp x+m gCheckMacroGuiClose Default, Anuluj
    Gui, CheckMacro:Show, xCenter yCenter, Checklist
    return

    State:
        Gui, CheckMacro:Submit, NoHide
        if ((Headings) or (Signs) or (MultiSpaces) or (Refresh) or (HardSpace) or (HyperLinks) or (Failure) or (DeadLinks) or (Size))
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
        cntCheck := Headings + Signs + MultiSpaces + HardSpace + Refresh + HyperLinks + Failure + DeadLinks + Size
        Gui, CheckNext:New, -MinimizeBox -MaximizeBox AlwaysOnTop
        Gui, CheckNext:Add, Text, vCheckText w300
        Gui, CheckNext:Add, Button, gCheckNext w150 Disabled, Następny krok 
        Gui, CheckNext:Add, Button, gCheckNextGuiClose yp x+m w150 Disabled, Zakończ 
        Gui, CheckNext:Show,, Checklist Macro
    
    CheckNext:

        checkFlag := 1
        if(Headings) and (CheckFlag)
        {
            CheckFlag := 0
            GuiControl, Disable, Następny krok 
            GuiControl,, CheckText, Ustawianie nagłówków i stopek... 
            SetHeadersAndFooters()
            Gui, CheckNext:Default
            GuiControl,, CheckText, Ustawiono nagłówki i stopki. 
            GuiControl, Enable, Następny krok 
            Headings := 0
        }
        if(Signs) and (CheckFlag)
        {
            CheckFlag := 0
            GuiControl, Disable, Następny krok 
            GuiControl,, CheckText, Sprawdzanie znaków interpunkcyjnych na końcach wypunktowań... 
            Wypunktowania()
            Gui, CheckNext:Default
            GuiControl,, CheckText, Sprawdzono znaki interpunkcyjne na końcach wypunktowań. 
            GuiControl, Enable, Następny krok 
            Signs := 0
        }            
        if(MultiSpaces) and (CheckFlag)
        {
            CheckFlag := 0
            GuiControl, Disable, Następny krok 
            GuiControl,, CheckText, Usuwanie wielokrotnych spacji i enterów... 
            UsunWielokrotneSpacje()
            Gui, CheckNext:Default
            GuiControl,, CheckText, Usunięto wielokrotne spacje i entery. 
            GuiControl, Enable, Następny krok 
            MultiSpaces := 0
        }
        if(HardSpace) and (CheckFlag)
        {
            CheckFlag := 0
            GuiControl, Disable, Następny krok 
            GuiControl,, CheckText, Zamiana spacji na twarde spacje... 
            TwardaSpacja()
            Gui, CheckNext:Default
            GuiControl,, CheckText, Zamieniono spacje na twarde spacje. 
            GuiControl, Enable, Następny krok 
            HardSpace := 0
        }
        if(Refresh) and (CheckFlag)
        {
            CheckFlag := 0
            GuiControl, Disable, Następny krok 
            GuiControl,, CheckText, Odświeżanie dokumentu... 
            Refresh()
            Gui, CheckNext:Default
            GuiControl,, CheckText, Odświeżono dokument. 
            GuiControl, Enable, Następny krok 
            Refresh := 0
        }
        if(HyperLinks) and (CheckFlag)
        {
            CheckFlag := 0
            GuiControl, Disable, Następny krok 
            GuiControl,, CheckText, Zamiana odsyłaczy na hiperłącza... 
            Hiperlacza()
            Refresh()
            Gui, CheckNext:Default
            GuiControl,, CheckText, Zamieniono odsyłacze na hiperłącza. 
            GuiControl, Enable, Następny krok 
            HyperLinks := 0
        }
        if(Failure) and (CheckFlag)
        {
            CheckFlag := 0
            GuiControl, Disable, Następny krok 
            GuiControl,, CheckText, Szukanie słowa 'błąd'... 
            FindBlad()
            Gui, CheckNext:Default
            GuiControl,, CheckText, Ukończono szukanie słowa 'błąd'. 
            GuiControl, Enable, Następny krok 
            Failure := 0
        }
        if(DeadLinks) and (CheckFlag)
        {
            CheckFlag := 0
            GuiControl, Disable, Następny krok
            GuiControl,, CheckText, Szukanie martwych łączy...
            FindDeadLinks()
            Gui, CheckNext:Default
            GuiControl,, CheckText, Ukończono szukanie martwych łączy.
            GuiControl, Enable, Następny krok
            DeadLinks := 0
        }
        if(Size) and (CheckFlag)
        {
            CheckFlag := 0
            GuiControl, Disable, Następny krok 
            GuiControl,, CheckText, Zmniejszanie rozmiaru obrazków w dokumencie... 
            MsgBox, 0x34, Uwaga!, Przed zmniejszeniem obrazków dokument zostanie zamknięty i zapisany. Czy chcesz kontynuować? 
            IfMsgBox, Yes
            {
                oWord := ComObjActive("Word.Application")
                DocName := oWord.ActiveDocument.FullName
                oWord.ActiveDocument.Close(-1)
                oWord := ""
                ResizeImages(DocName)

            }
            Gui, CheckNext:Default
            GuiControl,, CheckText, Zmiejszono rozmiar obrazków w dokumencie. 
            GuiControl, Enable, Następny krok 
            Size := 0
        }
        cntCheck := cntCheck - 1
        if (cntCheck == 0)
        {
            GuiControl, Disable, Następny krok 
            GuiControl, Enable, Zakończ 

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