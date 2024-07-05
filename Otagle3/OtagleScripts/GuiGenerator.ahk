#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance, Force

FileRead, Contents2,Assets/hashCode.txt ;Read CheckSum File

;Zmienne

hashCodeR                                   := 0
pages                                       := 0

; Utorzenie sumy kontrolnej przy pomocy kodowania md5.Za pomocą sumy kontrolnej sprawdzamy czy zaszły zmiany w konfiguracji(config.ini).
; Przy każdej zmianie konfiguracji jest generowane nowe gui - czyli pliki html znajdujace się w folderze PlikiHtml.

FileRead, Contents,Config.ini
data := Contents
MD5( ByRef V, L=0 ) {
    VarSetCapacity( MD5_CTX,104,0 ), DllCall( "advapi32\MD5Init", Str,MD5_CTX )
    DllCall( "advapi32\MD5Update", Str,MD5_CTX, Str,V, UInt,L ? L : VarSetCapacity(V) )
    DllCall( "advapi32\MD5Final", Str,MD5_CTX )
    Loop % StrLen( Hex:="123456789ABCDEF0" )
        N := NumGet( MD5_CTX,87+A_Index,"Char"), MD5 .= SubStr(Hex,N>>4,1) . SubStr(Hex,N&15,1)
    Return MD5
}
; Sprawdzona zostaje liczba hash jeżeli jest inna niż w wcześniej utworzonym plkku, oznacza to że konfiguracja jest zmieniona.

If (Contents2 == MD5(data,StrLen(data))){
    FileDelete, Assets/hashCode.txt
    FileAppend,% MD5(data,StrLen(data)),Assets/hashCode.txt
    
}Else If(Contents2 != MD5(data,StrLen(data))){
    FileDelete, Assets/hashCode.txt
    FileAppend,% MD5(data,StrLen(data)),Assets/hashCode.txt
    RemoveFolder()
}

;Przy inicjalizacji tworzenia nowych plików, jest utworzony nowy folder z o nzawie PlikiHtml - Powoduje to usunięcie starych plików wraz z folderem.
; Zabieg stosowany aby nie nadpisywać itniejącej struktury. Nadpisanie spowoduje dublowanie się okienek i przycisków.

if !(FileExist("PlikiHtml"))
{
    FileCreateDir, PlikiHtml
    BuildHTMLFile()
}
Else 
{
    Gosub, Gui
}

return
; Etykiety, które odsyłają do posczegulnych funkcji.

; - Używamy funkcji w przypadku kiedy zaszła zmiana w konfiguracji i tworzone są nowe pliki.
;Zostaje wyświetlony loader aby pokazać, że aplikacja działa.
Loader:
    DisplayLoader()
return
; - Uzywana funkcja w przypadku kiedy nie ma zmian w konfiguracji i nie trzeba wyświetlać loadera, bezpośrednio przechodzimy do aplikacji.
Gui:
    DisplayMainGui()
return

;Usuwanie folderu, aby nie nadpisywać plików Html.

RemoveFolder()
{
    FileRemoveDir, PlikiHtml,1
}

; Za pomocą metody FileAppend tworzone są pliki html.
; Pierwsze użycie tej metody zapisuje plik PlikiHtml/a_Welcome.html, gdzie zdefiniowany został plik html.

BuildHTMLFile()
{
    FileAppend,
    (
    <!DOCTYPE html>
    <html lang="en">
    <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="../Assets/font-awesome-4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="../Style/index.css" />
    <title>Otagle</title>
    </head>
    <body>
    <div class="loader-wrapper">
    <img class="logo"  src="../Assets/logo.svg" alt="">
    <h1 class="slogan">Let's make your PC personal again.</h1>
    </div>
    ), PlikiHtml/a_Welcome.html
    ; FileAppend,% "<div class=""loader""><span> loaded files " . loadedLayers . "/15 </span></div>", PlikiHtml/a_Welcome.html
    FileAppend,
    ( 
    <div class="lds-ellipsis"><div></div><div></div><div></div><div></div></div>
    ), PlikiHtml/a_Welcome.html
    FileAppend,
    (
    </body>
    </html>  
    ), PlikiHtml/a_Welcome.html
    

; Na podstawie konfiguracji zczytywana jest liczba warst, która mówi nam ile plików html zostanie  utworzonych.

    IniRead, Layers , % A_ScriptDir . "\Config.ini",Main,HowManyLayers
    Gosub, Loader

; Wykonywana jest iteracja za pomocą, której są zczytywane następne dane z konfiguracji.
; oibierany jest Tytuł, wielkośći przycisków, liczba przycisków w wierszach i kolumnach.

    Loop, %Layers%{
        Ln := A_Index
        loadedLayers := A_Index
        btns:= []
        SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
        SetWorkingDir %A_ScriptDir%  ; zmienna przechowuje "scieżkę do głownego katalogu z plikami należy tylko wskazać plik."
        IniRead, Title , % A_ScriptDir . "\Config.ini",Layer%Ln% ,Title
        IniRead, HorizontalGap,% A_ScriptDir . "\Config.ini",Layer%Ln%,ButtonHorizontalGap
        IniRead, VerticalGap,% A_ScriptDir . "\Config.ini",Layer%Ln%,ButtonVerticalGap
        IniRead, AmoountHBtn,% A_ScriptDir . "\Config.ini",Layer%Ln%,Amount of buttons horizontally
        IniRead, AmoountVBtn,% A_ScriptDir . "\Config.ini",Layer%Ln%,Amount of buttons vertically
        IniRead, BtnWidth,% A_ScriptDir . "\Config.ini",Layer%Ln%,ButtonWidth
        IniRead, BtnHeight,% A_ScriptDir . "\Config.ini",Layer%Ln%,ButtonHeight

  ; Tworzenie ikon. Na podstawie wcześniej pobranych danych jest tworzona macierz, z której zostaną pobrane i wykorzystane docelowe dane ikony.
  ; Każdy z przycisków jest linkiem(hiperłączem HTML) powstał za pomocą konkatenacji, 144 linijka kodu oraz 147.
  ; Aby nie wurzucało nam błedu pokliknięcu w ikonkę zostało dokonane sprawdzenie, czy ikonka przenosi na inną warstwę otagle? Jeżeli nie wstaw w  path #, który wyłącza linki html.

        Loop, %AmoountVBtn% 
        {
            VarVertical := A_Index
            Loop, %AmoountHBtn%
            {
                IniRead, BtnX ,% A_ScriptDir . "\Config.ini", Layer%Ln%, % "Button_" . VarVertical . "_" . A_Index . "_X"
                IniRead, BtnY ,% A_ScriptDir . "\Config.ini", Layer%Ln%, % "Button_" . VarVertical . "_" . A_Index . "_Y"
                IniRead, PictureDef,% A_ScriptDir . "\Config.ini",Layer%Ln%,  % "Button_" . VarVertical . "_" . A_Index . "_Picture"
                iconName:= SubStr(MsgText(PictureDef),20)
                FileRead, Contents, % A_ScriptDir . "\Assets\ikonySVG\" . iconName
                IniRead, ButtonA, % A_ScriptDir . "\Config.ini", Layer%Ln%, % "Button_" . VarVertical . "_" . A_Index . "_Action"
                IniRead, Path ,% A_ScriptDir . "\Config.ini", Layer%Ln%, % "Button_" . VarVertical . "_" . A_Index . "_Path",#
                IniRead, Name ,% A_ScriptDir . "\Config.ini", Layer%Ln%, % "Button_" . VarVertical . "_" . A_Index . "_Name",Tekst Testowy lalala

                Bw := BtnWidth
                Bh := BtnHeight

    ; Link pełni rolę wyłacznie rolę kontenera, na który ustawione jest nasłuchiwanie na zdarzenie "klik".
    ; Każda ikona posiada przypisane id, gdzie zawarta jest nazwa metody (Skrypt AHK). Określona jest akcja po kliknieciu.
    ; Nadane zostały style CSS np: maksymalny rozmiar kafelka, nadanie klasy wykorzystane jest do dodania styli w zewnętrzym pliku Css w katalogu Style.
    ; Wenatrz wszystkich kafelek umieszczona jest ikona SVG.

                If (Path == "#"){
                    btn:= % "<a style=""max-width:300px; max-height:300px; height:" . Bh . "vw; width:" . Bw . "vw;   ""  id=""" . ButtonA . """ class=""box_item"" href=""#""  onclick=""ahk.ClickF(event,id)"">" . Contents . "</a>"
                }
                Else{
                    btn:= % "<a style=""max-width:300px; max-height:300px; height:" . Bh . "vw; width:" . Bw . "vw;   "" id=""" . ButtonA . """ class=""box_item"" href=""" . "Layer" . Path . ".html" . """  onclick=""ahk.ClickF(event,id)"">" . Contents . "</a>"
                }
                
                btns[VarVertical,A_Index]:= btn
                
            }
        }

        ; Ttworzona jest struktura pików html.
        ;1 w sekcji <head> znajdują się importy do plików css, kodowanie znaków, tytuł.
        ; Sekcja Body rozpoczyna się okienkiem informacyjnym <div class="AboutBox">, jest to okienk pop-up wyświetlone po kliknięciu przycisku z menu about.
        ; Za wyświetlanie tego okienka odpowiedzialny jest JavaScript.

        FileAppend,
        (
        <!DOCTYPE html>
        <html lang="pl">
        <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="../Assets/font-awesome-4.7.0/css/font-awesome.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Lato:wght@700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="../Style/index.css" />
        <title>Otagle</title>
        </head>
        <body>
        <div class="AboutBox">
        <h2 class="AboutBox__title">O T A G L E v.2.0 by mslonik (🐘)</h2>
        <div class="AboutBox__introdution">
        <p class="AboutBox__introdution-p"> Make your computer Personal a g a i n...</p>
        <p class="AboutBox__introdution-p">Open source release of Stream Deck concept. Works at its best with touch screens.</p>
        <p class="AboutBox__introdution-p">For project description visit the following webpages:</p>
        <ul>
        <l1><a class="AboutBox__introdution-a"  href="#">http://mslonik.pl/biuro/1095-o-t-a-g-l-e-q-a</a></li>
        <l1><a class="AboutBox__introdution-a" href="#">https://www.autohotkey.com/boards/viewtopic.php?t=69690&p=300713</a></li>
        <l1><a class="AboutBox__introdution-a" href="#">https://github.com/mslonik/Autohotkey-scripts/tree/master/Otagle2</a></li>
        </ul>
        </div>
        <button class="btnOk">ok</button>
        </div>
        <header>
        ), PlikiHtml/Layer%Ln%.html
        FileAppend,
        ( 
        <img class="bar-icon" src="../Assets/OtagleIcon.ico" alt="icon"> 
        ), PlikiHtml/Layer%Ln%.html

        ;Zdeklarowany został pasek który mówi użytkownikowi najakie warstwie się znajduje.

        FileAppend,% "<span class=""title-bar""  onmousedown=""neutron.DragTitleBar()"" >" . "Otagle: " . "Layer" . Ln . " - " . Title . "</span>",PlikiHtml/Layer%Ln%.html

        ;Zostaje utrworzony niebieski pasek aplikacji z funkacjami zamknij,minimalizuj oraz maksymalizuj okono.

        FileAppend,
        (  
        <span class="title-btn__item Options">
        <i class="fa fa-wrench" aria-hidden="true"></i>
        </span>
        <span class="title-btn__item" onclick="neutron.Minimize()">
        <i class="fa fa-window-minimize" aria-hidden="true"></i>
        </span>
        <span class="title-btn__item" onclick="neutron.Maximize()">
        <i class="fa fa-window-maximize" aria-hidden="true"></i>
        </span>
        <span class="title-btn__item title-btn__close" onclick="neutron.CloseApp()"><i class="fa fa-times" aria-hidden="true"></i>
        </span>
        </header>
        <nav class="menu-bar">
            <ul class="menu-bar__list">
                <li class="menu-bar__item dropD1 ">
                    <button class="item__link trigger">Configure</button>
                    <ul class="sub-menu D1">
                        <li class="sub-menu__item" id="selectMonitor" onclick="ahk.BarF(event,id)"><a class="item__link sub__link" href="#"><i class="fa fa-arrow-down" aria-hidden="true"></i> + <span class="flag">S</span>elect Monitor</a></li>
                        <li class="sub-menu__item" id="addLayers" onclick="ahk.BarF(event,id)"><a class="item__link sub__link" href="#"><i class="fa fa-arrow-down" aria-hidden="true"></i> +<span class="flag">A</span>dd layer</a></li>
                        <li class="sub-menu__item" id="ConfigureEraseLayer" onclick="ahk.BarF(event,id)"><a class="item__link sub__link" href="#"><i class="fa fa-arrow-down" aria-hidden="true"></i> +<span class="flag">E</span>rase layer</a></li>
                    </ul>
                </li>
                <li class="menu-bar__item dropD2">
                    <button class="item__link trigger" href="#">Edit Buttons</button>
                    <ul class="sub-menu D2">
                        <li class="sub-menu__item" id="AddBtn" onclick="ahk.BarF(event,id)"><a class="item__link sub__link" href="#"><i class="fa fa-arrow-up" aria-hidden="true"></i>
                        +<span class="flag">A</span>dd button</a></li>
                        <li class="sub-menu__item" id="F_display_configurator" onclick="ahk.BarF(event,id)"><a class="item__link sub__link" href="#"><i class="fa fa-arrow-up" aria-hidden="true"></i>
                        +<span class="flag">S</span>wap button</a></li>
                        <li class="sub-menu__item" id="FdGuiDelete" onclick="ahk.BarF(event,id)"><a class="item__link sub__link" href="#"><i class="fa fa-arrow-up" aria-hidden="true"></i>
                        +<span class="flag">D</span>elete button</a></li>
                        <li class="sub-menu__item" id="Clone" onclick="ahk.BarF(event,id)"><a class="item__link sub__link" href="#"><i class="fa fa-arrow-up" aria-hidden="true"></i>
                        +<span class="flag">C</span>lone button</a></li>
                    </ul>
                </li>
                <li class="menu-bar__item" onclick="ahk.rWizard(event)">
                    <button class="item__link trigger" href="#"><i class="fa fa-arrow-right" aria-hidden="true"></i>+<span class="flag">R</span>un Wizard</button></li>
                <li class="menu-bar__item" id="rBox" onclick="ahk.resizeBox(event,id)">
                    <button class="item__link Order trigger" href="#"><span class="flag">A</span>utoscaling buttons</button>
                </li>
                <li class="menu-bar__item">
                    <button class="item__link About trigger" href="#">About</button>
                </li>
            </ul>
        </nav>
        <div class="wrapper" style="position: relative;">  
        ), PlikiHtml/Layer%Ln%.html

; Dodana zostaje macierz przycisków.

        Loop,%AmoountVBtn% {
            column := A_Index
            Loop, %AmoountHBtn%
            {
                FileAppend,% btns[column,A_Index], PlikiHtml/Layer%Ln%.html
            }
        }

; Dodane zostają tagi zamykające strukturę utworzonych plików HTML oraz został podlinkowany plik JavaScript, który obługuje proste zdarzenia zwiazane z paskiem menu.

        FileAppend,
        (
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="crossorigin="anonymous"></script>
        <script src="../OtagleScripts/index.js"></script>
        </body> 
        </html>   
        ), PlikiHtml/Layer%Ln%.html
        
        pages:=1
        
    }
    If (pages == 1){
        Gosub, Gui
    }
}

;Display GUI
; f10::
; IniRead, WhichMonitor , % A_ScriptDir . "\Config.ini",Main,WhichMonitor
; SysGet, MonitorBoundingCoordinates_, Monitor, % WhichMonitor
; VarWidth:= Abs(MonitorBoundingCoordinates_Left - MonitorBoundingCoordinates_Right)
; VarHeight:= Abs(MonitorBoundingCoordinates_Top - MonitorBoundingCoordinates_Bottom)
; MsgBox, % VarWidth . " X " . VarHeight
; windowSize:= % " w" . VarWidth . " h" . VarHeight
; return

;Funkcje do wyświetlania aplikacni za pośrednictem neutrona.

DisplayLoader()
{
    global
    neutron := new NeutronWindow()
    neutron.Load("PlikiHtml/a_Welcome.html")
    neutron.Gui("+LabelNeutron")
    neutron.Show("w620 h350")
}

DisplayMainGui()
{
    global
    neutron.Close("PlikiHtml/a_Welcome.html")
    neutron := new NeutronWindow()
    neutron.Load("PlikiHtml/Layer1.html")
    neutron.Gui("+LabelNeutron")
    neutron.Show("w1300 h800")
    neutron.Maximize()
}