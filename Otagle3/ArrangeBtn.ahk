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
    global l0 := SubStr(LayerToBeErased,1,InStr(LayerToBeErased, " ",,,1))  
     IniDelete, % A_ScriptDir . "\Config.ini", % l0 
     IniRead, HowManyLayers , % A_ScriptDir . "\Config.ini",Main,HowManyLayers
     HowManyLayers--
     
     IniWrite, % "HowManyLayers=" . HowManyLayers,           % A_ScriptDir . "\Config.ini", Main,
    Reset()
}
ConfigureEraseLayer()

global flag := 0
addLayers(){

 Gui,DeleteLayers:Destroy
 Gui,SwapLayers:Destroy
 Gui,CloneLayers:Destroy
 Gui, EraseLayer:Destroy
 Gui, aLayers:Destroy
 global widthButton :=
 global heightButton :=

 Gui, aLayers: New, +LabelMyGui_On -DPIScale
 Gui, aLayers: Add, Text, xm, Specify key size width: `
 Gui, aLayers: Add, Edit, x+m yp r1 w50
 Gui, aLayers: Add, UpDown, vwidthButton Range1-300,80
 Gui, aLayers: Add, Text, x+m yp, Specify key size height: `
 Gui, aLayers: Add, Edit, x+m yp r1 w50
 Gui, aLayers: Add, UpDown, vheightButton Range1-300,80
 Gui, aLayers: Add, Button, xm Default w80 gCalculateButtons, C&alculate 
 Gui, aLayers: Add, Text,  xm, % "Number of keys horizontally:`t" . (flag ? aLayer_AmountOfKeysHorizontally : "") 
 Gui, aLayers: Add, Text,  yp x+m, Write the title of the layer:
 Gui, aLayers: Add, Text, xm, % "Number of keys vertically:`t" . (flag ? aLayer_AmountOfKeysVertically : "") 
 Gui, aLayers: Add, Edit, yp x+m w120 vTitle, %Title%
 Gui, aLayers: Add, Button, x10  w80 gdrawButton hwndTestButtonHwnd, &Test
 Gui, aLayers: Add, Button, xm w80 gSaveLayer hwndSaveLayerHwnd, &Add Layer
    If (flag=""){
    GuiControl,aLayers:Disable, % TestButtonHwnd
    GuiControl,aLayers:Disable, % SaveLayerHwnd
    }
 Gui, aLayers:Show
}
Return
CalculateButtons:
  changeFlag()
   Gui,aLayers:Submit
   Gui, aLayers:Destroy
    GuiControl,aLayers:Enable, % TestButtonHwnd
    GuiControl,aLayers:Enable, % SaveLayerHwnd

   global aLayer_AmountOfKeysHorizontally := (1920 - 10) // ( widthButton + 10)
   global aLayer_AmountOfKeysVertically := (1080 - 10) // (heightButton + 10)
    addLayers()
Return
changeFlag(){
  flag := 1 
}

SaveLayer:
      Gui,aLayers:Submit,NoHide
      If (Title = ""){
          MsgBox, Please enter a layer name 
      }Else{
                IniRead, HowManyLayers , % A_ScriptDir . "\Config.ini",Main,HowManyLayers
      HowManyLayers++
      IniWrite, % "HowManyLayers=" . HowManyLayers,% A_ScriptDir . "\Config.ini", Main,
      IniWrite, % Title,                   % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers,  Title
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
            IniWrite, % "", % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers, % "Button_" . ExternalLoopIndex . "_" . A_Index . "_X"
            IniWrite, % "", % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers, % "Button_" . ExternalLoopIndex . "_" . A_Index . "_Y"
            IniWrite, % "", % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers, % "Button_" . ExternalLoopIndex . "_" . A_Index . "_W"
            IniWrite, % "", % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers, % "Button_" . ExternalLoopIndex . "_" . A_Index . "_H"
            IniWrite, % "", % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers, % "Button_" . ExternalLoopIndex . "_" . A_Index . "_Picture"
            IniWrite, % "",  % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers, % "Button_" . ExternalLoopIndex . "_" . A_Index . "_Action"
            IniWrite, % "",  % A_ScriptDir . "\Config.ini", % "Layer" . HowManyLayers, % "Button_" . ExternalLoopIndex . "_" . A_Index . "_Path"
        }
    }
    Gui, aLayers:Destroy
    Reset()
   }

Return

drawButton:
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