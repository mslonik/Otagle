﻿StrikeThroughText() ; 2019-10-03
	{
	;~ global oWord
	oWord := ComObjActive("Word.Application")
	oWord.Selection.Font.StrikeThrough := wdToggle := 9999998 
	oWord :=  "" ; Clear global COM objects when done with them
	}

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
; the following line has been prepared for O T A G L E
; StrikeThroughText()