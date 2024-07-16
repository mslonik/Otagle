/*
    O T A G L E 3
    Written by: Ernest Mgłosiek, Maciej Słojewski
    License: GNU GPL 3.x
*/

#NoEnv
#SingleInstance, Force
SetBatchLines, -1
SetWorkingDir %A_ScriptDir%

Menu, Tray, Icon, % A_ScriptDir . "\Assets\OtagleIcon.ico"
#Include 		%A_ScriptDir%\OtagleScripts\CopyTemplate.ahk    ;this file is not necessary for pure Otagle3. If you wish you can comment it out.
#Include 		%A_ScriptDir%\lib\Neutron.ahk
#Include *i 	%A_ScriptDir%\ButtonFunctions.ahk ;this file may not exist on startup, so it is run with "*i" parameter
#Include 		%A_ScriptDir%\OtagleScripts\GuiGenerator.ahk
#Include 		%A_ScriptDir%\OtagleScripts\ConfigBuilder.ahk
#Include 		%A_ScriptDir%\OtagleScripts\ArrangeBtn.ahk

if !(FileExist("Config.ini"))
	{
	    Run, ConfigBuilder.ahk, %A_ScriptDir% 
	}

; Global variables
global Flag := False


; Add filles to executable (EXE)
FileInstall, Layer1.html, Layer1.html
FileInstall, index.js, index.js
FileInstall, index.css, index.css
FileInstall, Assets/ikonySVG, *
FileInstall, bootstrap.min.css, bootstrap.min.css
FileInstall, bootstrap.min.js, bootstrap.min.js
FileInstall, jquery.min.js, jquery.min.js


; Obsługa kafelka - przekzane jest z poziomu html zdarzenie, które jest zawiera nazwę metody.
; Każdy kafelek zawiera indentyfikator, gdzie zawarta jest nazwa funkcji.
ClickF(neutron,event,action)
{ ; pozbycie się zbędnych elementów i pozostawienie samej nazwy metody.
    SplitPath, % action, FunctionName
    FunctionName := SubStr(FunctionName, 1, StrLen(FunctionName)-4)

    %FunctionName%()
    return
}

BarF(neutron, event, action)
{
    %action%()
    return
}

resizeBox(neutron, event, f)
{
	Flag := !Flag
	If (Flag)
	{
    		%f%()
   	}
	Else
	{
    		Reset()
   	}
}

rWizard(neutron,event)
{
	Run, % A_ScriptDir . "\OtagleScripts\ConfigBuilder.ahk" 
}

Reset()
{
    global
    MsgBox, Config.ini has been modified. Now O T A G L E will restart in order to apply changes.
    neutron.Close("PlikiHtml/Layer1.html")
    RemoveFolder()
    FileCreateDir, PlikiHtml
    BuildHTMLFile()
}

; Skrypt przygotowany dla Kamili, ma na celu zatrzymanie się skalowania kafelek.
rBox()
{
	IniRead, Layers_02 , % A_ScriptDir . "\Config.ini",Main,HowManyLayers
    	Loop,%Layers_02%
	{
    		index := A_Index
    		FileRead, Contents44,PlikiHtml/Layer%index%.html
    		Occurence := 1
    		AllFoundPos := ""
    		resizeBox := ""
    		Loop
    		{
     	   FoundPos := InStr(Contents44, "box_item",,,Occurence)
     	   AllFoundPos .= FoundPos . "`n"  
     	   if (FoundPos == 0)
     	       Break
     	   Occurence++
     	   resizeBox := SubStr(Contents44, FoundPos, 8)
     	   fixedContent := StrReplace(Contents44, resizeBox, "box_item stopResize")
    		}
    		FileDelete, PlikiHtml/Layer%index%.html
    		Loop, Parse, fixedContent, `n
    		{
     	   FileAppend,%A_LoopField%`n,PlikiHtml/Layer%index%.html,UTF-8
    		}
	}
}