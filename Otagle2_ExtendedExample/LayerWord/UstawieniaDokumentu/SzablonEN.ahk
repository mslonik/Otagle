SzablonEN()
	{
	OurTemplateEN := "s:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-en_OgolnyTechDok.dotm"
	WinActivate, ahk_class OpusApp
	
	oWord := ComObjActive("Word.Application")
	if (oWord.ActiveDocument.AttachedTemplate.FullName = OurTemplateEN)	
	{
		MsgBox, 64, Ju� ustawi�e� szablon, % "Ju� wcze�niej zosta� wybrany szablon " oWord.ActiveDocument.AttachedTemplate.FullName
	}
	else
	{
		oWord.ActiveDocument.AttachedTemplate := OurTemplateEN
		oWord.ActiveDocument.UpdateStylesOnOpen := -1
		oWord.ActiveDocument.UpdateStyles
		MsgBox, 64, Informacja, % "Do��czono szablon!`n Do��czono domyslny szablon dokumentu: `n" oWord.ActiveDocument.AttachedTemplate.FullName, 5
		template := "EN"
		try
			oWord.ActiveDocument.CustomDocumentProperties["PopSzab"] := template
		catch
		{
			oWord.ActiveDocument.CustomDocumentProperties.Add("PopSzab",0,4," ")
			oWord.ActiveDocument.CustomDocumentProperties["PopSzab"] := template
		}
		
	}
	oWord := "" ; Clear global COM objects when done with them
	WinActivate, ahk_class OpusApp
	return
}