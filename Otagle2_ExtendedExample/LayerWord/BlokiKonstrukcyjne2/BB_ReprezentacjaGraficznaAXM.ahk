BB_ReprezentacjaGraficznaAXM()
{
	OurTemplateEN := "s:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-en_OgolnyTechDok.dotm"
	OurTemplatePL := "s:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-pl_OgolnyTechDok.dotm"
	
	oWord := ComObjActive("Word.Application")
	if  ( (oWord.ActiveDocument.AttachedTemplate.FullName <> OurTemplateEN) 
		and (oWord.ActiveDocument.AttachedTemplate.FullName <> OurTemplatePL) )
	{
		MsgBox, 16, Pr�ba wywo�ania stylu z szablonu, 
		( Join
		 Pr�bujesz wstawi� blok konstrukcyjny przypisany do szablonu, ale szablon nie zosta� jeszcze do��czony do tego pliku. 
	Najpierw do��cz szablon, a nast�pnie wywo�aj ponownie t� funkcj�.
		)
	}
	else
	{
		OurTemplate := oWord.ActiveDocument.AttachedTemplate.FullName
		oWord.Templates(OurTemplate).BuildingBlockEntries("Reprezentacja graficzna AXM").Insert(oWord.Selection.Range, -1)
	}
	oWord :=  "" ; Clear global COM objects when done with them
	WinActivate, ahk_class OpusApp
	return
}