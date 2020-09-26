#NoEnv  						; Recommended for performance and compatibility with future AutoHotkey releases.
 ;#Warn  						; Enable warnings to assist with detecting common errors. Commented out because of Class_ImageButton.ahk
SendMode Input  				; Recommended for new scripts due to its superior speed and reliability.
#SingleInstance, Force
SetWorkingDir %A_ScriptDir%	
global actionPath :=
global imgPath :=
global x1 :=
global x2 :=
global y1 :=
global y2 :=
global Pd :=
global pd2:=
global A  := 
global A2 :=
global P  := 
global P2 :=
global NrLayer,NrRow,NrElement,NrLayer2,NrRow2,NrElement2
global Title :=
global btnWidth := 80
global btnHeight := 80
global WhichMonitor := 0
global HowManyLayers :=
global LayerToBeErased :=
F_display_configurator() {
    Gui,AddLayers:Destroy
    Gui,DeleteLayers:Destroy
    Gui,SwapLayers:Destroy
    Gui, EraseLayer:Destroy
    IniRead, VL , % A_ScriptDir . "\Config.ini",Main,HowManyLayers
    Loop, %VL%{
        Ln := A_Index
        loadedLayers := A_Index
        SendMode Input  
        SetWorkingDir %A_ScriptDir%  
        IniRead, AmoountHBtn,% A_ScriptDir . "\Config.ini",Layer%Ln%,Amount of buttons horizontally
        IniRead, AmoountVBtn,% A_ScriptDir . "\Config.ini",Layer%Ln%,Amount of buttons vertically
        IniRead, Title , % A_ScriptDir . "\Config.ini",Layer%Ln% ,Title
        opt := % opt . "Layer: " . Ln . " " . MsgText(Title) . "|"
    }
Gui, +AlwaysOnTop -MaximizeBox -MinimizeBox
Gui,SwapLayers:Add, Text,, Please select a layer:
Gui,SwapLayers:Add, ComboBox, w200 vNrLayer, % opt
Gui,SwapLayers:Add, Text,, Please enter some icon line:
Gui,SwapLayers:Add, Edit, vNrRow w200
Gui,SwapLayers:Add, Text,, Please enter some icon number
Gui,SwapLayers:Add, Edit, vNrElement w200
Gui,SwapLayers:Add, Text,, Please select a layer:
Gui,SwapLayers:Add, ComboBox, w200 vNrLayer2, % opt
Gui,SwapLayers:Add, Text,, Please enter some icon line:
Gui,SwapLayers:Add, Edit, vNrRow2 w200
Gui,SwapLayers:Add, Text,, Please enter element number:
Gui,SwapLayers:Add, Edit, vNrElement2 w200
Gui, SwapLayers:Add, Button, Default gSwap, SWAP

Gui,SwapLayers:Show
}

Swap(){
    Gui,SwapLayers:Submit,NoHide
    IniRead, Layers , % A_ScriptDir . "\Config.ini",Main,HowManyLayers
     
     global l1 := SubStr(NrLayer,1,InStr(NrLayer, " ",,,2))
     global l2 := % SubStr(NrLayer2,1,InStr(NrLayer2, " ",,,2))
     l1 := SubStr(l1,8)
     l2 :=SubStr(l2,8)
     global v1 := % "Button_" . NrRow . "_" . NrElement
     global v2 := % "Button_" . NrRow2 . "_" . NrElement2
    Loop, %Layers%{
        Ln := A_Index
        If (Ln == l1){
        SendMode Input 
        SetWorkingDir %A_ScriptDir%  
                IniRead, BtnX ,% A_ScriptDir . "\Config.ini", Layer%Ln%, % v1 . "_X"
                IniRead, BtnY ,% A_ScriptDir . "\Config.ini", Layer%Ln%, % v1 . "_Y"
                IniRead, PictureDef,% A_ScriptDir . "\Config.ini",Layer%Ln%,  % v1 . "_Picture"
                IniRead, ButtonA, % A_ScriptDir . "\Config.ini", Layer%Ln%, % v1 . "_Action"
                IniRead, Path ,% A_ScriptDir . "\Config.ini", Layer%Ln%, % v1 . "_Path",#  
                x1 := BtnX
                y1 := BtnY
                pd := PictureDef
                A  := ButtonA
                P  := Path
        }
    }
    Loop, %Layers%{
        iter := A_Index
        If (iter == l2){
            SendMode Input 
            SetWorkingDir %A_ScriptDir% 
                    IniRead, BtnX2 ,% A_ScriptDir . "\Config.ini", Layer%iter%,% v2 . "_X"
                    IniRead, BtnY2 ,% A_ScriptDir . "\Config.ini", Layer%iter%,% v2 . "_Y"
                    IniRead, PictureDef2,% A_ScriptDir . "\Config.ini",Layer%iter%, % v2 . "_Picture"
                    IniRead, ButtonA2, % A_ScriptDir . "\Config.ini", Layer%iter%,% v2 . "_Action"
                    IniRead, Path2 ,% A_ScriptDir . "\Config.ini", Layer%iter%,% v2 . "_Path",#   
                    x2 := BtnX2
                    y2 := BtnY2
                    pd2:= PictureDef2
                    A2 := ButtonA2
                    P2 := Path2
        }
    }
    Loop, %Layers%{
        calc := A_Index
        If (calc == l1){
            IniRead, HB1,% A_ScriptDir . "\Config.ini",Layer%calc%,Amount of buttons horizontally
            IniRead, VB1,% A_ScriptDir . "\Config.ini",Layer%calc%,Amount of buttons vertically
            SendMode Input 
            SetWorkingDir %A_ScriptDir% 
                IniWrite, % x2 ,% A_ScriptDir . "\Config.ini", Layer%calc%,% v1 . "_X"
                IniWrite, % y2,% A_ScriptDir . "\Config.ini", Layer%calc%,% v1 . "_Y"
                IniWrite, % pd2,% A_ScriptDir . "\Config.ini",Layer%calc%, % v1 . "_Picture"
                IniWrite, % A2, % A_ScriptDir . "\Config.ini", Layer%calc%,% v1 . "_Action"
                IniWrite, % P2 ,% A_ScriptDir . "\Config.ini", Layer%calc%,% v1 . "_Path"
        }
    }
    Loop, %Layers%{
        index := A_Index
        If (index == l2){
            SendMode Input 
            SetWorkingDir %A_ScriptDir% 
                IniWrite, % x1 ,% A_ScriptDir . "\Config.ini", Layer%index%,% v2 . "_X"
                IniWrite, % y1 ,% A_ScriptDir . "\Config.ini", Layer%index%,% v2 . "_Y"
                IniWrite, % pd ,% A_ScriptDir . "\Config.ini",Layer%index%, % v2 . "_Picture"
                IniWrite, % A , % A_ScriptDir . "\Config.ini", Layer%index%,% v2 . "_Action"
                IniWrite, % P ,% A_ScriptDir . "\Config.ini", Layer%index%,% v2 . "_Path"
        }
    }
        Gui,SwapLayers:Destroy
        Reset()
}
FdGuiDelete(){
    Gui,AddLayers:Destroy
    Gui,DeleteLayers:Destroy
    Gui,SwapLayers:Destroy
    Gui, EraseLayer:Destroy
    IniRead, VL , % A_ScriptDir . "\Config.ini",Main,HowManyLayers
    Loop, %VL%{
    Ln := A_Index
    loadedLayers := A_Index
    SendMode Input 
    SetWorkingDir %A_ScriptDir%  
    IniRead, AmoountHBtn,% A_ScriptDir . "\Config.ini",Layer%Ln%,Amount of buttons horizontally
    IniRead, AmoountVBtn,% A_ScriptDir . "\Config.ini",Layer%Ln%,Amount of buttons vertically
    IniRead, Title , % A_ScriptDir . "\Config.ini",Layer%Ln% ,Title
    opt := % opt . "Layer: " . Ln . " " . MsgText(Title) . "|"
    }

    Gui, +AlwaysOnTop -MaximizeBox -MinimizeBox
    Gui,DeleteLayers:Add, Text,, Please enter layer nuber:
    Gui,DeleteLayers:Add, ComboBox, w200 vNrLayer, % opt
    Gui,DeleteLayers:Add, Text,, Please enter some icon line:
    Gui,DeleteLayers:Add, Edit,w200 vNrRow
    Gui,DeleteLayers:Add, Text,, Please enter element number:
    Gui,DeleteLayers:Add, Edit,w200 vNrElement
    Gui, DeleteLayers:Add, Button, Default gDeleteF, Delete
    Gui,DeleteLayers:Show
}
DeleteF(){
    Gui,DeleteLayers:Submit,NoHide
    IniRead, Layers , % A_ScriptDir . "\Config.ini",Main,HowManyLayers
     global l1 := SubStr(NrLayer,1,InStr(NrLayer, " ",,,2))
     l1 := SubStr(l1,8)
     global v1 := % "Button_" . NrRow . "_" . NrElement
    Loop, %Layers%{
        calc := A_Index
        If (calc == l1){
            SendMode Input 
            SetWorkingDir %A_ScriptDir% 
                IniWrite,% "",% A_ScriptDir . "\Config.ini", Layer%calc%,% v1 . "_X"
                IniWrite,% "",% A_ScriptDir . "\Config.ini", Layer%calc%,% v1 . "_Y"
                IniWrite,% "",% A_ScriptDir . "\Config.ini",Layer%calc%, % v1 . "_Picture"
                IniWrite,% "", % A_ScriptDir . "\Config.ini", Layer%calc%,% v1 . "_Action"
                IniWrite,% "",% A_ScriptDir . "\Config.ini", Layer%calc%,% v1 . "_Path"
        }
    }
    Gui,DeleteLayers:Destroy
    Reset()
}
AddBtn(){
    Gui,AddLayers:Destroy
    Gui,DeleteLayers:Destroy
    Gui,SwapLayers:Destroy
    Gui, EraseLayer:Destroy
    IniRead, VL , % A_ScriptDir . "\Config.ini",Main,HowManyLayers
    Loop, %VL%{
        Ln := A_Index
        loadedLayers := A_Index
        SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
        SetWorkingDir %A_ScriptDir%  ; zmienna przechowuje "scieżkę do głownego katalogu z plikami należy tylko wskazać plik."
        IniRead, AmoountHBtn,% A_ScriptDir . "\Config.ini",Layer%Ln%,Amount of buttons horizontally
        IniRead, AmoountVBtn,% A_ScriptDir . "\Config.ini",Layer%Ln%,Amount of buttons vertically
        IniRead, Title , % A_ScriptDir . "\Config.ini",Layer%Ln% ,Title
        opt := % opt . "Layer: " . Ln . " " . MsgText(Title) . "|"
    }
    Gui, +AlwaysOnTop -MaximizeBox -MinimizeBox
    Gui,AddLayers:Add, Text,, Please enter layer nuber:
    Gui,AddLayers:Add, ComboBox, w200 vNrLayer, % opt
    Gui,AddLayers:Add, Text,, Please enter row number:
    Gui,AddLayers:Add, Edit, vNrRow w200 
    Gui,AddLayers:Add, Text,, Please enter element number:
    Gui,AddLayers:Add, Edit, vNrElement w200 
    Gui,AddLayers:Add, Text,, Please select the layer to which the user will be transferred after click
    Gui,AddLayers:Add, ComboBox, w200 vNrLayer2, % opt
    MsgBox, Select Picture file
    FileSelectFile,    SelectedFile, 3, %A_ScriptDir%, Select a picture file, Picture (*.svg; *.png)
     if (SelectedFile = "")
          {
          MsgBox,   No picture file was selected.
          }Else{
          imgPath := SubStr(SelectedFile, StrLen(A_ScriptDir)+1)
          }
    MsgBox, Select Script file
    FileSelectFile, SelectedFile2, 3, , Select an .ahk or .exe file, File (*.ahk; *.exe)
    if (SelectedFile2 = "") 
        {
        MsgBox,   No action file was selected.
        } Else{
        actionPath := SubStr(SelectedFile2, StrLen(A_ScriptDir)+2)
        }     
    Gui, AddLayers:Add, Button, Default gAddF, Add
    Gui,AddLayers:Show
}
AddF(){
Gui,AddLayers:Submit
IniRead, Layers , % A_ScriptDir . "\Config.ini",Main,HowManyLayers  
global l1 := SubStr(NrLayer,1,InStr(NrLayer, " ",,,2))
l1 := SubStr(l1,8)
global l2 := % SubStr(NrLayer2,1,InStr(NrLayer2, " ",,,2))
l2 :=SubStr(l2,8)
global v1 := % "Button_" . NrRow . "_" . NrElement 
fP := % ".." . imgPath
fM := % ".." . actionPath
    Loop, %Layers%{
        calc := A_Index
        If (calc == l1){
            SendMode Input 
            SetWorkingDir %A_ScriptDir% 
            IniWrite,% "",% A_ScriptDir . "\Config.ini", Layer%calc%,% v1 . "_X"
            IniWrite,% "",% A_ScriptDir . "\Config.ini", Layer%calc%,% v1 . "_Y"
            IniWrite,% fP,% A_ScriptDir . "\Config.ini",Layer%calc%, % v1 . "_Picture"
            IniWrite,% fM, % A_ScriptDir . "\Config.ini", Layer%calc%,% v1 . "_Action"
            IniWrite,% l2,% A_ScriptDir . "\Config.ini", Layer%calc%,% v1 . "_Path",#
        }
    }
    Gui,AddLayers:Destroy
    Reset()
}
Clone(){
Gui,AddLayers:Destroy
Gui,DeleteLayers:Destroy
Gui,SwapLayers:Destroy
Gui,CloneLayers:Destroy
Gui, EraseLayer:Destroy
IniRead, VL , % A_ScriptDir . "\Config.ini",Main,HowManyLayers
    Loop, %VL%{
        Ln := A_Index
        loadedLayers := A_Index
        SendMode Input  
        SetWorkingDir %A_ScriptDir%  
        IniRead, AmoountHBtn,% A_ScriptDir . "\Config.ini",Layer%Ln%,Amount of buttons horizontally
        IniRead, AmoountVBtn,% A_ScriptDir . "\Config.ini",Layer%Ln%,Amount of buttons vertically
        IniRead, Title , % A_ScriptDir . "\Config.ini",Layer%Ln% ,Title
        opt := % opt . "Layer: " . Ln . " " . MsgText(Title) . "|"
    }
Gui, +AlwaysOnTop -MaximizeBox -MinimizeBox
Gui,CloneLayers:Add, Text,, Please select a layer:
Gui,CloneLayers:Add, ComboBox, w200 vNrLayer, % opt
Gui,CloneLayers:Add, Text,, Please enter some icon line:
Gui,CloneLayers:Add, Edit, vNrRow w200
Gui,CloneLayers:Add, Text,, Please enter some icon number
Gui,CloneLayers:Add, Edit, vNrElement w200
Gui,CloneLayers:Add, Text,, Please select a layer:
Gui,CloneLayers:Add, ComboBox, w200 vNrLayer2, % opt
Gui,CloneLayers:Add, Text,, Please enter some icon line:
Gui,CloneLayers:Add, Edit, vNrRow2 w200
Gui,CloneLayers:Add, Text,, Please enter element number:
Gui,CloneLayers:Add, Edit, vNrElement2 w200
Gui,CloneLayers:Add, Button, Default gCloneB, Clone
Gui,CloneLayers:Show
}
CloneB(){
 Gui,CloneLayers:Submit,NoHide
    IniRead, Layers , % A_ScriptDir . "\Config.ini",Main,HowManyLayers
     global l1 := SubStr(NrLayer,1,InStr(NrLayer, " ",,,2))
     global l2 := % SubStr(NrLayer2,1,InStr(NrLayer2, " ",,,2))
     l1 := SubStr(l1,8)
     l2 :=SubStr(l2,8)
     global v1 := % "Button_" . NrRow . "_" . NrElement
     global v2 := % "Button_" . NrRow2 . "_" . NrElement2
    Loop, %Layers%{
        Ln := A_Index
        If (Ln == l1){
        SendMode Input 
        SetWorkingDir %A_ScriptDir%  
            IniRead, BtnX ,% A_ScriptDir . "\Config.ini", Layer%Ln%, % v1 . "_X"
            IniRead, BtnY ,% A_ScriptDir . "\Config.ini", Layer%Ln%, % v1 . "_Y"
            IniRead, PictureDef,% A_ScriptDir . "\Config.ini",Layer%Ln%,  % v1 . "_Picture"
            IniRead, ButtonA, % A_ScriptDir . "\Config.ini", Layer%Ln%, % v1 . "_Action"
            IniRead, Path ,% A_ScriptDir . "\Config.ini", Layer%Ln%, % v1 . "_Path",#  
            x1 := BtnX
            y1 := BtnY
            pd := PictureDef
            A  := ButtonA
            P  := Path
        }
    }
    Loop, %Layers%{
        index := A_Index
        If (index == l2){
            SendMode Input 
            SetWorkingDir %A_ScriptDir% 
            IniWrite, % x1 ,% A_ScriptDir . "\Config.ini", Layer%index%,% v2 . "_X"
            IniWrite, % y1 ,% A_ScriptDir . "\Config.ini", Layer%index%,% v2 . "_Y"
            IniWrite, % pd ,% A_ScriptDir . "\Config.ini",Layer%index%, % v2 . "_Picture"
            IniWrite, % A , % A_ScriptDir . "\Config.ini", Layer%index%,% v2 . "_Action"
            IniWrite, % P ,% A_ScriptDir . "\Config.ini", Layer%index%,% v2 . "_Path",#  
        }
    }
    Gui,CloneLayers:Destroy
    Reset()
}
ConfigureEraseLayer(){
     Gui,AddLayers:Destroy
     Gui,DeleteLayers:Destroy
     Gui,SwapLayers:Destroy
     Gui,CloneLayers:Destroy
     Gui, EraseLayer:Destroy
     Gui, EraseLayer: New, +LabelMyGui_On
     Gui, EraseLayer: Font, bold
     Gui, EraseLayer: Add, Text, , Erase layer
     Gui, EraseLayer: Font
     Gui, EraseLayer: Add, Text, , Select which layer should be erased:
    IniRead, VL , % A_ScriptDir . "\Config.ini",Main,HowManyLayers
    Loop, %VL%{
        Ln := A_Index
        loadedLayers := A_Index
        SendMode Input  
        SetWorkingDir %A_ScriptDir%
        IniRead, AmoountHBtn,% A_ScriptDir . "\Config.ini",Layer%Ln%,Amount of buttons horizontally
        IniRead, AmoountVBtn,% A_ScriptDir . "\Config.ini",Layer%Ln%,Amount of buttons vertically
        IniRead, Title , % A_ScriptDir . "\Config.ini",Layer%Ln% ,Title
        opt := % opt . "Layer" . Ln . " " . Title . "|"
    }
    Gui,EraseLayer:Add, ComboBox, w200 vLayerToBeErased, % opt

    Gui, EraseLayer: Add, Button, xm+30 w80 gEraseLayer,     &Erase layer
    Gui, EraseLayer: Show
}
EraseLayer(){
    Gui, EraseLayer: Submit, NoHide
    Gui, EraseLayer: Destroy
    IniRead, HowManyLayers , % A_ScriptDir . "\Config.ini",Main,HowManyLayers
    IniRead, mVal , % A_ScriptDir . "\Config.ini",Main,WhichMonitor
    IniWrite, % mVal,% A_ScriptDir . "\Config.ini", Main,WhichMonitor
    global l0 := SubStr(LayerToBeErased,1,InStr(LayerToBeErased, " ",,,1))  
     IniDelete, % A_ScriptDir . "\Config.ini", % l0 

     HowManyLayers--
     
     IniWrite, % "HowManyLayers=" . HowManyLayers,           % A_ScriptDir . "\Config.ini", Main,
    Reset()
}
ConfigureEraseLayer()
global widthButton :=
global heightButton :=
global flag := 0
global flag2 := 0
addLayers(){
 Gui,DeleteLayers:Destroy
 Gui,SwapLayers:Destroy
 Gui,CloneLayers:Destroy
 Gui, EraseLayer:Destroy
 Gui, aLayers:Destroy
 Gui, aLayers: New, +LabelMyGui_On -DPIScale
 Gui, aLayers: Add, Text, xm, Specify key size width: `
 Gui, aLayers: Add, Edit, x+m yp r1 w80
 Gui, aLayers: Add, UpDown, vwidthButton Range80-300, % widthButton
 Gui, aLayers: Add, Text, x+m yp, Specify key size height: `
 Gui, aLayers: Add, Edit, x+m yp r1 w80
 Gui, aLayers: Add, UpDown, vheightButton Range80-300,% heightButton
 Gui, aLayers: Add, Button, xm Default w80 gCalculateButtons, C&alculate 
 Gui, aLayers: Add, Text,  xm, % "Number of keys horizontally:`t" . (flag ? aLayer_AmountOfKeysHorizontally : "") 
 Gui, aLayers: Add, Text, xm, % "Number of keys vertically:`t" . (flag ? aLayer_AmountOfKeysVertically : "") 
 Gui, aLayers: Add, Text, yp x+m,Layer title: 
 Gui, aLayers: Add, Edit, yp x+m w120 vTitle, %Title%
 Gui, aLayers: Add, Button, x10  w80 gdrawButton hwndTestButtonHwnd, &Test
 Gui, aLayers: Add, Text, xm, Write the title of the layer:
 Gui, aLayers: Add, Button, xm w80 gSaveLayer hwndSaveLayerHwnd, &Add Layer
    If (flag=""){
     GuiControl,aLayers:Disable, % TestButtonHwnd
    }
    If (flag2=""){
      GuiControl,aLayers:Disable, % SaveLayerHwnd
    }
   
 Gui, aLayers:Show
}
Return
CalculateButtons:
    flag := 1
    Gui,aLayers:Submit
    Gui, aLayers:Destroy
    GuiControl,aLayers:Enable, % TestButtonHwnd
    GuiControl,aLayers:Enable, % SaveLayerHwnd

   global aLayer_AmountOfKeysHorizontally := (1920 - 10) // ( widthButton + 10)
   global aLayer_AmountOfKeysVertically := (1080 - 10) // (heightButton + 10)
    addLayers()
Return
SaveLayer:
      Gui,aLayers:Submit,NoHide
      If (Title = ""){
          MsgBox, Please write the title of the layer
      }Else{
     IniRead, HowManyLayers , % A_ScriptDir . "\Config.ini",Main,HowManyLayers
     IniRead, mVal , % A_ScriptDir . "\Config.ini",Main,WhichMonitor
      HowManyLayers++
      IniDelete, % A_ScriptDir . "\Config.ini", Main,HowManyLayers
      IniWrite, % HowManyLayers,% A_ScriptDir . "\Config.ini", Main, HowManyLayers
      IniWrite, % mVal,% A_ScriptDir . "\Config.ini", Main,WhichMonitor
      IniWrite, % Title,% A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers,  Title
      If (heightButton == widthButton){
            IniWrite, % Floor(100/aLayer_AmountOfKeysHorizontally), % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers,  ButtonWidth
            IniWrite, % Floor(100/aLayer_AmountOfKeysHorizontally), % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers,  ButtonHeight
     }Else{
            IniWrite, % Floor(widthButton/1920 * 100), % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers,  ButtonWidth
            IniWrite, % Floor(heightButton/1080 * 100), % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers,  ButtonHeight
        }
     IniWrite,% aLayer_AmountOfKeysHorizontally ,% A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers,Amount of buttons horizontally
     IniWrite,% aLayer_AmountOfKeysVertically ,% A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers,Amount of buttons vertically
    Loop, % aLayer_AmountOfKeysVertically
    {
    ExternalLoopIndex := A_Index
    Loop, % aLayer_AmountOfKeysHorizontally
        {
            ; IniWrite, % "", % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers, % "Button_" . ExternalLoopIndex . "_" . A_Index . "_X"
            ; IniWrite, % "", % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers, % "Button_" . ExternalLoopIndex . "_" . A_Index . "_Y"
            ; IniWrite, % "", % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers, % "Button_" . ExternalLoopIndex . "_" . A_Index . "_W"
            ; IniWrite, % "", % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers, % "Button_" . ExternalLoopIndex . "_" . A_Index . "_H"
            IniWrite, % "", % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers, % "Button_" . ExternalLoopIndex . "_" . A_Index . "_Picture"
            IniWrite, % "",  % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers, % "Button_" . ExternalLoopIndex . "_" . A_Index . "_Action"
            IniWrite, % "",  % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers, % "Button_" . ExternalLoopIndex . "_" . A_Index . "_Path"
        }
    }
    MsgBox, Config.ini has been modified. Now O T A G L E will restart in order to apply changes.
    Gui, aLayers:Destroy
    Reset()
   }
Return
drawButton:
   flag2 := 1
   Gui,aLayers:Submit,NoHide
   Gui, aLayers:Destroy
   Gui, Template: New, +LabelMyGui_On -DPIScale
     AVBtn := aLayer_AmountOfKeysVertically
     AHBtn := aLayer_AmountOfKeysHorizontally
     Bw := widthButton
     Bh := heightButton
     Loop, %AVBtn% 
    {
    VarVertical := A_Index
        Loop, %AHBtn%
        {
           Gui, Template: Add, Button,% "xm Default" . " w" . Bw . " h" . Bh  . " x" . (bw + 10) * (A_Index - 1) . " y" . (bh + 10) * (VarVertical - 1) ,  Button 
        }
    }
    SetTimer,CloseMatrix,4000,-1
    Gui, Template:Show
Return    
CloseMatrix:
Gui,Template:Submit
Gui, Template:Destroy
SetTimer,, Off
addLayers()
Return
global W :=
selectMonitor(){
    global
     Gui,AddLayers:Destroy
     Gui,DeleteLayers:Destroy
     Gui,SwapLayers:Destroy
     Gui,CloneLayers:Destroy
     Gui, EraseLayer:Destroy
     Gui, WizardStep1:Destroy
     Gui, WizardStep1: New, +LabelMyGui_On
     Gui, WizardStep1: Font, bold
     Gui, WizardStep1: Font
     Gui, WizardStep1: Add, Text, w500, Specify one out of the available Monitor No.
     SysGet, HowManyMonitors,       MonitorCount
     SysGet, WhichIsPrimary,        MonitorPrimary
    if (WhichMonitor = 0) {
        WhichMonitor := WhichIsPrimary
    }
    Loop, % HowManyMonitors
        {
        if (A_Index = WhichMonitor){
            Gui, WizardStep1: Add, Radio, xm+50 vW%A_Index% gSlectOptions   , % "Monitor #" . A_Index . (A_Index = WhichIsPrimary ? " (primary)" : "")
        }else
            Gui, WizardStep1: Add, Radio, xm+50 vW%A_Index%  gSlectOptions   , % "Monitor #" . A_Index . (A_Index = WhichIsPrimary ? " (primary)" : "")
        } 
    Gui, WizardStep1: Add, Button, Default xm+30 y+20 gCheckMonitorNumbering,  &Check Monitor Numbering
    Gui, WizardStep1: Add, Button, Default xm+30 y+20 gChangeMonitorReloadApp,  &Ok
    Gui, WizardStep1:Show
    return
}
return
SlectOptions:
 Gui, WizardStep1: Submit, NoHide
 W := ""
 Loop, % HowManyMonitors
 {
     Wtemp := W%A_Index%

    if (Wtemp){
      res := A_Index
      W := % res
    }
 }
Return
CheckMonitorNumbering:
     F_ShowMonitorNumbers()
     SetTimer, DestroyGuis, -3000
return
DestroyGuis:
 Gui, WizardStep1: Submit, NoHide
     Loop, %HowManyMonitors%
          {
          Gui, %A_Index%:Destroy
          }
     Gui, Font ; restore the font to the system's default GUI typeface, zize and color.
return
F_ShowMonitorNumbers()
{
     global
     Loop, %HowManyMonitors%
          {
          SysGet, MonitorBoundingCoordinates_, Monitor, %A_Index%
          MonitorBoundingCoordinates_Left := Format("{:d}", MonitorBoundingCoordinates_Left/ (A_ScreenDPI/96))
          MonitorBoundingCoordinates_Right := Format("{:d}", MonitorBoundingCoordinates_Right/ (A_ScreenDPI/96))
          MonitorBoundingCoordinates_Top := Format("{:d}", MonitorBoundingCoordinates_Top/ (A_ScreenDPI/96))
          MonitorBoundingCoordinates_Bottom := Format("{:d}", MonitorBoundingCoordinates_Bottom/ (A_ScreenDPI/96))
          Gui, %A_Index%:-SysMenu -Caption +Border
          Gui, %A_Index%:Color, Black ; WindowColor, ControlColor
          Gui, %A_Index%:Font, cWhite s26 bold, Calibri
          Gui, %A_Index%:Add, Text, x138 y130 w130 h130, % A_Index
          Gui, % A_Index . ":Show", % "x" .  MonitorBoundingCoordinates_Left + (Abs(MonitorBoundingCoordinates_Left - MonitorBoundingCoordinates_Right) / 2) - (300 / 2) . "y" 
          . MonitorBoundingCoordinates_Top + (Abs(MonitorBoundingCoordinates_Top - MonitorBoundingCoordinates_Bottom) / 2) - (300 / 2) . "w300" . "h300"
          }
return
}
ChangeMonitorReloadApp(){
    Gui, WizardStep1: Submit, NoHide
    IniDelete, % A_ScriptDir . "\Config.ini", Main,WhichMonitor
    IniWrite, % W,% A_ScriptDir . "\Config.ini", Main,WhichMonitor
    MsgBox, Config.ini has been modified. Now O T A G L E will restart in order to apply changes.
    Gui, WizardStep1:Destroy
    Reset()
}

