#NoEnv  						; Recommended for performance and compatibility with future AutoHotkey releases.
 ;#Warn  						; Enable warnings to assist with detecting common errors. Commented out because of Class_ImageButton.ahk
SendMode Input  				; Recommended for new scripts due to its superior speed and reliability.
#SingleInstance, Force
SetWorkingDir %A_ScriptDir%	
global Title :=
global btnWidth := 80
global btnHeight := 80
global ButtonHorizontalGap := 10   
global ButtonVerticalGap   := 10
global MonitorBoundingCoordinates_Left  := 0
global MonitorBoundingCoordinates_Right := 0
global MonitorBoundingCoordinates_Top   := 0
global MonitorBoundingCoordinates_Bottom:= 0
global T_CalculateButton   := 0 
global WhichMonitor        := 0
global aLayer_AmountOfKeysHorizontally :=
global aLayer_AmountOfKeysVertically := 
global  HowManyLayers  := 1

addLayer(){
Gui, aLayer:Destroy
Gui, aLayer: New, +LabelMyGui_On -DPIScale
Gui, aLayer: Add, Text, xm, Specify key size width: `
Gui, aLayer: Add, Edit, x+m yp r1 w50
Gui, aLayer: Add, UpDown, vbtnWidth Range1-300, % btnWidth 
Gui, aLayer: Add, Text, x+m yp, Specify key size height: `
Gui, aLayer: Add, Edit, x+m yp r1 w50
Gui, aLayer: Add, UpDown, vbtnHeight Range1-300, % btnHeight
Gui, aLayer: Add, Button, xm Default w80 gBCalcu, C&alculate 
Gui, aLayer: Add, Button, x10  w80 gPlotButtons2 hwndTestButtonHwnd,       &Test
Gui, aLayer: Add, Text,  xm, % "Number of keys horizontally:`t" . (T_CalculateButton ? aLayer_AmountOfKeysHorizontally : "") 
Gui, aLayer: Add, Text,  yp x+m, Write the title of the layer:
Gui, aLayer: Add, Text, xm, % "Number of keys vertically:`t" . (T_CalculateButton ? aLayer_AmountOfKeysVertically : "") 
Gui, aLayer: Add, Edit, yp x+m w120 vTitle, %Title%
Gui, aLayer: Add, Button, xm w80 gSaveLayer hwndSaveConfigHwnd, &iniect Layer


if (T_CalculateButton = 0)
{
    GuiControl, aLayer: Disable, % TestButtonHwnd
    GuiControl, aLayer: Disable, % SaveConfigHwnd
}

Gui, aLayer:Show
}

BCalcu(){
Gui, aLayer: Submit
T_CalculateButton :=1 
global MonitorBoundingCoordinates_,
SysGet, MonitorBoundingCoordinates_, Monitor, % WhichMonitor
MonitorBoundingCoordinates_Left := Format("{:d}", MonitorBoundingCoordinates_Left/ (A_ScreenDPI/96))
MonitorBoundingCoordinates_Right := Format("{:d}", MonitorBoundingCoordinates_Right/ (A_ScreenDPI/96))
MonitorBoundingCoordinates_Top := Format("{:d}", MonitorBoundingCoordinates_Top/ (A_ScreenDPI/96))
MonitorBoundingCoordinates_Bottom := Format("{:d}", MonitorBoundingCoordinates_Bottom/ (A_ScreenDPI/96))
global aLayer_AmountOfKeysHorizontally := (Abs(MonitorBoundingCoordinates_Left - MonitorBoundingCoordinates_Right) -  ButtonHorizontalGap) // ( btnWidth + ButtonHorizontalGap)
global aLayer_AmountOfKeysVertically := (Abs(MonitorBoundingCoordinates_Top - MonitorBoundingCoordinates_Bottom) - ButtonVerticalGap) // (btnHeight + ButtonVerticalGap)
addLayer()

}

PlotButtons2(){
     Gui, aLayer:    Submit, NoHide
     Gui, aLayer:    Destroy
     GuiControl, aLayer: Enable, % TestButtonHwnd
     GuiControl, aLayer: Enable, % SaveConfigHwnd
     Gui, Template: New, +LabelMyGui_On -DPIScale
     AVBtn := aLayer_AmountOfKeysVertically
     AHBtn := aLayer_AmountOfKeysHorizontally
     Bw := btnWidth
     Bh := btnHeight
    Loop, %AVBtn% 
    {
    VarVertical := A_Index
        Loop, %AHBtn%
        {
           Gui, Template: Add, Button,% "xm Default" . " w" . Bw . " h" . Bh  . " x" . (bw + 10) * (A_Index - 1) . " y" . (bh + 10) * (VarVertical - 1) ,   Button 
        }
    }
    Gui, Template:Show
    SetTimer, outG ,4000000,-1
    outG:
    Gui, Template:Destroy
    
     addLayer()
}
SaveLayer(){
    Gui, aLayer:    Submit, NoHide
     HowManyLayers++
     IniWrite, % HowManyLayers,           % A_ScriptDir . "\Config.ini", Main, HowManyLayers ; Save the total amount of created layers
     IniWrite, % Title,                   % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers,  Title
     If (btnHeight == btnWidth){
     IniWrite, % Floor(100/aLayer_AmountOfKeysHorizontally), % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers,  ButtonWidth
     IniWrite, % Floor(100/aLayer_AmountOfKeysHorizontally), % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers,  ButtonHeight
     }Else{
      IniWrite, % Floor(btnWidth/1920 * 100), % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers,  ButtonWidth
      IniWrite, % Floor(btnHeight/1080 * 100), % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers,  ButtonHeight
     }
     IniWrite, % ButtonHorizontalGap,     % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers,  ButtonHorizontalGap
     IniWrite, % ButtonVerticalGap,       % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers,  ButtonVerticalGap
    Loop, % aLayer_AmountOfKeysVertically
    {
    ExternalLoopIndex := A_Index
    Loop, % aLayer_AmountOfKeysHorizontally
        {
        IniWrite, % "", % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers, % "Button_" . ExternalLoopIndex . "_" . A_Index . "_X"
        IniWrite, % "", % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers, % "Button_" . ExternalLoopIndex . "_" . A_Index . "_Y"
        ; IniWrite, % "", % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers, % "Button_" . ExternalLoopIndex . "_" . A_Index . "_W"
        ; IniWrite, % "", % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers, % "Button_" . ExternalLoopIndex . "_" . A_Index . "_H"
        IniWrite, % "", % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers, % "Button_" . ExternalLoopIndex . "_" . A_Index . "_Picture"
        IniWrite, % "",  % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers, % "Button_" . ExternalLoopIndex . "_" . A_Index . "_Action"
        IniWrite, % "",  % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers, % "Button_" . ExternalLoopIndex . "_" . A_Index . "_Path"
        }
    }
    Gui, aLayer:Destroy


}

addLayer()