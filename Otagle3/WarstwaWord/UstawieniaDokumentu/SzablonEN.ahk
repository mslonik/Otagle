SzablonEN()	; to co poniżej, to jest definicja funkcji
	{
		global
		;to jest miejsce, gdzie użytkownik powinien dokonać wyboru; wybór użytkownika powinien zostać zapamiętany w zmiennej LocTempPL

		Gui, SelectTemplate: New 
		Gui, SelectTemplate: Add, Text, x20 y25, 							Select template
		Gui, SelectTemplate: Add, Radio, x20 y55 w200 vUserChoiceEN Checked,TQ-S402-en_OgolnyTechDok.dotm
		; Gui, SelectTemplate: Add, Radio, x20 y55 w200,					TQ-S402-pl_OgolnyTechDok.dotm 
		Gui, SelectTemplate: Add, Radio, x20 w200, 							TQ-S440-en_UserDoc.dotm 
		; Gui, SelectTemplate: Add, Radio, x20 w200,						TQ-S440-pl_DokUzyt.dotm 
		Gui, SelectTemplate: Add, Button, gButtonChoiceEN, 					OK
		Gui, SelectTemplate: Show, AutoSize, 								Please select template name
	}

ButtonChoiceEN()
{
	global
	local	template := "", LocTemp := ""
	Gui, SelectTemplate: Submit, NoHide
	MsgBox,, Drugie wywołanie
	Switch UserChoiceEN
	{
		Case 1: 
			LocTemp 	:= "S:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-en_OgolnyTechDok.dotm"
			template 	:= "OTD_en"	;zmienna template zostanie wykorzystana do wpisania wartości na "właściwość niestandardową" pliku MS Word, do którego zostanie podpięty szablon (Plik → Informacje → Właściwości, zakładka Niestandardowe);  skrót od OgólnyTechDok
		Case 2: 
			LocTemp 	:= "S:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S440-en_UserDoc.dotm"
			template 	:= "UD_en" ;zmienna template zostanie wykorzystana do wpisania wartości na "właściwość niestandardową" pliku MS Word, do którego zostanie podpięty szablon (Plik → Informacje → Właściwości, zakładka Niestandardowe);  skrót od DokUzyt
	}		
	WinActivate, ahk_class OpusApp
	oWord := ComObjActive("Word.Application")
	if (oWord.ActiveDocument.AttachedTemplate.FullName = LocTemp)	
	{
		MsgBox, 64, Information, % "The currently selected template is: `n" oWord.ActiveDocument.AttachedTemplate.FullName
	}
	else
	{
		oWord.ActiveDocument.AttachedTemplate 	:= LocTemp
		oWord.ActiveDocument.UpdateStylesOnOpen := -1
		oWord.ActiveDocument.UpdateStyles
		MsgBox, 64, A template is included!, % "A default document template is included. `n" oWord.ActiveDocument.AttachedTemplate.FullName
		try
			oWord.ActiveDocument.CustomDocumentProperties["PopSzab"] := template ;PopSzab to właściwość dokumentu; prawdopodobnie jest ona wykorzystywana przez inne skrypty; by ją zobaczyć: Plik → Informacje → Właściwości, zakładka Niestandardowe
		catch
		{
			oWord.ActiveDocument.CustomDocumentProperties.Add("PopSzab",0,4," ")
			oWord.ActiveDocument.CustomDocumentProperties["PopSzab"] := template
		}
	}
	Gui, SelectTemplate: Destroy
	oWord := "" ; Clear global COM objects when done with them
	WinActivate, ahk_class OpusApp 
}

SelectTemplateGuiCloseEN()
{
	Gui, SelectTemplate: Destroy
	oWord := "" ; Clear global COM objects when done with them
	WinActivate, ahk_class OpusApp 
}