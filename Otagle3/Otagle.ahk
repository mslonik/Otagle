#NoEnv
#SingleInstance, Force
SetBatchLines, -1
SetWorkingDir %A_ScriptDir%
Menu, Tray,Icon, % A_ScriptDir . "\Assets\OtagleIcon.ico"
if !(FileExist("Config.ini")){
    Run, ConfigBuilder.ahk,%A_ScriptDir% 
}Else{
#Include *i %A_ScriptDir%\OtagleScripts\CopyTemplate.ahk
#Include *i %A_ScriptDir%\lib\Neutron.ahk
#Include *i %A_ScriptDir%\ButtonFunctions.ahk 
#Include *i %A_ScriptDir%\OtagleScripts\GuiGenerator.ahk
#Include *i %A_ScriptDir%\OtagleScripts\ConfigBuilder.ahk
#Include *i %A_ScriptDir%\OtagleScripts\ArrangeBtn.ahk

; Global variables

;Install filles
FileInstall, Layer1.html, Layer1.html
FileInstall, index.js, index.js
FileInstall, index.css, index.css
FileInstall, Assets/ikonySVG, *
FileInstall, bootstrap.min.css, bootstrap.min.css
FileInstall, bootstrap.min.js, bootstrap.min.js
FileInstall, jquery.min.js, jquery.min.js

; Button handler
ClickF(neutron,event,action){
    
    SplitPath, % action, FunctionName
    FunctionName := SubStr(FunctionName, 1, StrLen(FunctionName)-4)
  
    %FunctionName%()
    return
}
BarF(neutron,event,action){
    %action%()
    return
}
rWizard(neutron,event){
Run, % A_ScriptDir . "\OtagleScripts\ConfigBuilder.ahk" 
}
}
Reset(){
    global
    neutron.Close("PlikiHtml/Layer1.html")
    RemoveFolder()
    FileCreateDir, PlikiHtml
    BuildHTMLFile()
    
}

F1::
Send class="iTxt"
return
F3::
Send class=""
return
F4::
Send name=""
return