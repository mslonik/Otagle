/*
    The running Otagle3 contains mainly AutoHotkey scripts referring to Microsoft Word. The script *CopyTemplate.ahk* copies the specific Microsoft Word template files (DOTM), stored in company's network to specific local folder of Otagle3. The template files are copied only if date or size of template files have changed.

    In general, if you wish to have "pure" Otagle, you can comment out or remove this file. 
    
    Please mind that some specific AutoHotkey scripts called upon pressing of buttons will not run without correct template files.
*/

if !(FileExist(A_ScriptDir . "\Templates\"))
    FileCreateDir, % A_ScriptDir . "\Templates\"

    OurTemplateEN := "S:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-en_OgolnyTechDok.dotm"
,   OurTemplatePL := "S:\OrgFirma\Szablony\Word\OgolneZmakrami\TQ-S402-pl_OgolnyTechDok.dotm"

,   TemplatePL := A_ScriptDir . "\Templates\TQ-S402-pl_OgolnyTechDok.dotm"
,   TemplateEN := A_ScriptDir . "\Templates\TQ-S402-en_OgolnyTechDok.dotm"


FileGetTime, OurTimePL, %OurTemplatePL%
FileGetTime, OurTimeEN, %OurTemplateEN%
FileGetTime, TimePL,    %TemplatePL%
FileGetTime, TimeEN,    %TemplateEN%
FileGetSize, OurSizePL, %OurTemplatePL%
FileGetSize, OurSizeEN, %OurTemplateEN%
FileGetSize, SizePL,    %TemplatePL%
FileGetSize, SizeEN,    %TemplateEN%

if (FileExist(OurTemplateEN) and ((OurTimeEN > TimeEN) or (OurSizePL != SizePL)))
    FileCopy, %OurTemplateEN%, % A_ScriptDir . "\Templates\", 1

if (FileExist(OurTemplatePL) and ((OurTimePL > TimePL) or (OurSizeEN != SizeEN)))
    FileCopy, %OurTemplatePL%, % A_ScriptDir . "\Templates\", 1