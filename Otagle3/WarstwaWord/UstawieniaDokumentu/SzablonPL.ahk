SzablonPL()	; to co poniżej, to jest definicja funkcji
	{
		global
		;to jest miejsce, gdzie użytkownik powinien dokonać wyboru; wybór użytkownika powinien zostać zapamiętany w zmiennej LocTempPL

		Gui, SelectTemplate: New 
		Gui, SelectTemplate: Add, Text, x20 y25, 							Select template
		; Gui, SelectTemplate: Add, Radio, x20 y55 w200, 					TQ-S402-en_OgolnyTechDok.dotm
		Gui, SelectTemplate: Add, Radio, x20 y55 w200 vUserChoicePL Checked,TQ-S402-pl_OgolnyTechDok.dotm 
		; Gui, SelectTemplate: Add, Radio, x20 w200, 						TQ-S440-en_UserDoc.dotm 
		Gui, SelectTemplate: Add, Radio, x20 w200,							TQ-S440-pl_DokUzyt.dotm 
		Gui, SelectTemplate: Add, Button, gButtonChoicePL, 					OK
		Gui, SelectTemplate: Show, AutoSize, 								Please select template name
	}

ButtonChoicePL()
{
	global
	local	template := "", LocTemp := "", msoTrue := -1, msoFalse := 0
	Gui, SelectTemplate: Submit, NoHide

	OutputDebug, % "Przed switch." . A_Space . "LocTemp:" . A_Space . LocTemp . A_Space . "template:" . A_Space . template . "`n"
	Switch UserChoicePL
	{
		Case 1: 
			LocTemp 	:= "S:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-pl_OgolnyTechDok.dotm"
			template 	:= "OTD_pl"	;zmienna template zostanie wykorzystana do wpisania wartości na "właściwość niestandardową" pliku MS Word, do którego zostanie podpięty szablon (Plik → Informacje → Właściwości, zakładka Niestandardowe);  skrót od OgólnyTechDok
		Case 2: 
			LocTemp 	:= "S:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S440-pl_DokUzyt.dotm"
			template 	:= "UD_pl" ;zmienna template zostanie wykorzystana do wpisania wartości na "właściwość niestandardową" pliku MS Word, do którego zostanie podpięty szablon (Plik → Informacje → Właściwości, zakładka Niestandardowe);  skrót od DokUzyt
	}
	OutputDebug, % "Po switch." . A_Space . "LocTemp:" . A_Space . LocTemp . A_Space . "template:" . A_Space . template . "`n"
	WinActivate, ahk_class OpusApp
	oWord := ComObjActive("Word.Application")
	if (oWord.ActiveDocument.AttachedTemplate.FullName = LocTemp)	
	{
		MsgBox, 64, Information, % "The currently selected template: `n" oWord.ActiveDocument.AttachedTemplate.FullName
	}
	else
	{
		OutputDebug, % "oWord.ActiveDocument.AttachedTemplate:" . A_Space . oWord.ActiveDocument.AttachedTemplate . "`n"
		OutputDebug, % "oWord.ActiveDocument.AttachedTemplate.FullName:" . A_Space . oWord.ActiveDocument.AttachedTemplate.FullName . "`n"
		oWord.ActiveDocument.AttachedTemplate	 	:= LocTemp	;https://docs.microsoft.com/en-us/office/vba/api/word.document.attachedtemplate
		; oWord.ActiveDocument.AttachedTemplate	 	:= "s:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S440-pl_DokUzyt.dotm"
		oWord.ActiveDocument.UpdateStylesOnOpen 	:= msoTrue
		MsgBox, 64, A template is included!, % "The following template was attached:`n" oWord.ActiveDocument.AttachedTemplate.FullName
		try
			oWord.ActiveDocument.CustomDocumentProperties["PopSzab"] := template ;PopSzab to właściwość dokumentu; prawdopodobnie jest ona wykorzystywana przez inne skrypty; by ją zobaczyć: Plik → Informacje → Właściwości, zakładka Niestandardowe
		catch
		{
			oWord.ActiveDocument.CustomDocumentProperties.Add("PopSzab",0,4," ")
			oWord.ActiveDocument.CustomDocumentProperties["PopSzab"] := template
		}
	}
	OutputDebug, % "oWord.ActiveDocument.AttachedTemplate.FullName:" . A_Space . oWord.ActiveDocument.AttachedTemplate.FullName . "`n"
	OutputDebug, % "oWord.ActiveDocument.AttachedTemplate:" . A_Space . oWord.ActiveDocument.AttachedTemplate . "`n"
	OutputDebug, % "oWord.ActiveDocument.AttachedTemplate.Name:" . A_Space . oWord.ActiveDocument.AttachedTemplate.Name . "`n"
	Gui, SelectTemplate: Destroy
	oWord := "" ; Clear global COM objects when done with them
	WinActivate, ahk_class OpusApp 
}

SelectTemplateGuiClosePL()
{
	Gui, SelectTemplate: Destroy
	oWord := "" ; Clear global COM objects when done with them
	WinActivate, ahk_class OpusApp 
}