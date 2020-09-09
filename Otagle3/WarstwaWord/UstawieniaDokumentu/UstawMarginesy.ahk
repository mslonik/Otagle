UstawMarginesy()
{
    static MarginVoe, MarginWas, MarginSzer

    WinActivate, ahk_class OpusApp
    WinGetPos, WordX, WordY, WordW, WordH, A
    PosX := WordX + WordW/2
    PosY := WordY + WordH/2
	Gui, Margins:New, -MinimizeBox -MaximizeBox
    Gui, Margins:Add, Radio, y30 vMarginVoe Checked, Standardowe vaSig Sopot
    Gui, Margins:Add, Radio, yp+30 vMarginWas, Wąskie
    Gui, Margins:Add, Radio, yp+30 vMarginSzer, Szerokie
    Gui, Margins:Add, Button, yp+40 x60 w80 h30 gMarginOK Default, OK
    Gui, Margins:Show, w200 h180 x%PosX% y%PosY%, Ustawienia Marginesów
    return

    MarginOK:
    Gui, Margins:Submit
    oWord := ComObjActive("Word.Application")
    oSetup := oWord.ActiveDocument.PageSetup
    if (MarginVoe == 1)
    {
        oSetup.TopMargin := 1.5
        oSetup.BottomMargin := 1.5
        oSetup.LeftMargin := 2.27
        oSetup.RightMargin := 1.27
        oSetup.Gutter := 0
        oSetup.MirrorMargins := -1
    }
    else if (MarginWas == 1)
    {
        oSetup.TopMargin := 1.2
        oSetup.BottomMargin := 1.2
        oSetup.LeftMargin := 1.2
        oSetup.RightMargin := 1.2
        oSetup.Gutter := 0
        oSetup.MirrorMargins := 0
    }
    else if (MarginSzer == 1)
    {
        oSetup.TopMargin := 1.5
        oSetup.BottomMargin := 1.5
        oSetup.LeftMargin := 2.27
        oSetup.RightMargin := 2.27
        oSetup.Gutter := 0
        oSetup.MirrorMargins := 0
    }
    oWord := ""
    WinActivate, ahk_class OpusApp
    return
}
