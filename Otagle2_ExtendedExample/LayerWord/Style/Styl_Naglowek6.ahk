Styl_Naglowek6()
{
	OurTemplateEN := "S:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-en_OgolnyTechDok.dotm"
    OurTemplatePL := "s:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-pl_OgolnyTechDok.dotm"
    oWord := ""

	oWord := ComObjActive("Word.Application")
	if  ( (oWord.ActiveDocument.AttachedTemplate.FullName <> OurTemplateEN) and (oWord.ActiveDocument.AttachedTemplate.FullName <> OurTemplatePL) )
	{
		MsgBox, 16, Pr�ba wywo�ania stylu z szablonu, 
		( Join
		 Pr�bujesz wywo�a� styl przypisany do szablonu, ale szablon nie zosta� jeszcze do��czony do tego pliku. 
 Najpierw dolacz szablon, a nast�pnie wywo�aj ponownie t� funkcj�.
		)
	}
	else
	{
		oWord.Selection.Style := "Nag��wek 6 ms"
	}
	oWord := "" ; Clear global COM objects when done with them
	WinActivate, ahk_class OpusApp
	return
}