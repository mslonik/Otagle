DopasowanieTabeli()
{
	oWord := ComObjActive("Word.Application")
	OurTempPL := "S:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S440-pl_DokUzyt.dotm"
	OurTempEN := "S:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S440-en_UserDoc.dotm"
	LocTempPL := % A_ScriptDir . "\Templates\TQ-S440-pl_DokUzyt.dotm"
	LocTempEN := % A_ScriptDir . "\Templates\TQ-S440-en_UserDoc.dotm"
	SzabPath := SubStr(A_ScriptDir, 1, InStr(A_ScriptDir, "AutoHotkeyScripts\Otagle")-1)
	SzabTempPL := % SzabPath . "OgolneZmakrami\szab_TQ-S440-pl_DokUzyt.dotm"
	SzabTempEN := % SzabPath . "OgolneZmakrami\szab_TQ-S440-en_UserDoc.dotm"
	OurTemplate := oWord.ActiveDocument.AttachedTemplate.FullName
	if  ((OurTemplate != OurTempPL) and (OurTemplate != OurTempEN) and (OurTemplate != LocTempPL) and (OurTemplate != LocTempEN) and (OurTemplate != SzabTempPL) and (OurTemplate != SzabTempEN))
	{
		MsgBox, 16, % "Próba wywołania stylu z szablonu",  % "Próbujesz wstawić blok konstrukcyjny przypisany do szablonu, ale szablon nie został jeszcze dołączony do tego pliku.`r`nNajpierw dołącz szablon, a następnie wywołaj ponownie tę funkcję."
	}
	else
	{
		oWord.Run("!DopasowanieTabeli")
	}
	oWord :=  "" ; Clear global COM objects when done with them
	WinActivate, ahk_class OpusApp
	return
}