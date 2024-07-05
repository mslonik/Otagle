# O T A G L E 3

![Otagle3 Big Logo](/Otagle2/Core/OtagleBigLogo.png)

*Otagle3* is the newest version of the *Otagle* concept. In comparison to previous version, the main improvement is GUI and scallable icons / buttons. If you didn't yet read general introduction to *Otagle* concept [I strongly recommend to do so](https://github.com/mslonik/Otagle).

### How it works?
*Otagle3* is based on [*Neutron.ahk*](https://github.com/G33kDude/Neutron.ahk). It means that Graphical User Interface (GUI) is kept within Internet browser. As you may already know, Internet browsers are one of not so many applications, which are able to display videos, pictures and text together, within the same window. If your pictures are prepared as vector oriented graphics, such windows are scallable. So the idea behind is to open a window containing matrix of buttons, where all icons are vector graphics and all are scallable. 

Of course script window doesn't looks like Internet browser. Only core functions related to rendering of text and vector graphics are supported. The *Neutron* is actually software interface to *Trident* aka [*MSHTML*](https://en.wikipedia.org/wiki/Trident_(software)), which is a browser engine of the *Internet Explorer*. 

### How to setup it?
- If you run *Otagle3* for the very first time or for the purpose of script configuration, run the *ConfigBuilder.ahk*. You can select button matrix size, including width and height, calculate, test, name and save each layer of button matrix size into configuration files. The *ConfigBuilder.ahk* will create two files: *ButtonFunctions.ahk* and *Config.ini*. Both of those files must be kept within the main folder of the script.
- Every AutoHotkey script which will be assigned to a button must contain just a single function. The filename must be the same as function name. In other words skip usual for AutoHotkey auto-execute section.

### How to run it?
There are actually two scripts:
- *Otagle.ahk*, the default, regular script, **recommended** for the first time,
- *Flow.ahk*, the experimental script, which exchanges information with *Microsoft Word* about its current context. If the context changes, *Flow.ahk* follows it and automatically switches between available layers. Of course it works only with the provided example scripts (stored in subfolder *WarstwaWord*) and only with *Microsoft Word*.

### How to configure if it already runs?
In the top-right corner of the window you will find the wrench icon. 

![Wrench icon 🛠](/Otagle3/pictures/WrenchIcon_Configuration.png)

After clicking you can 
- edit your buttons (add, swap, remove), you
- configurate layers 
- chose monitor you wish Otagle to open.

#### Button configuration
Choose add button option. Next you will see the 3 message boxes in order to: 
- select SVG picture for your button icon (format SVG makes scaling possible), 
- AutoHotkey script that will be asign to current button and lastly 
- location in Otagle widnow for your button.

Now manualy assign the AutoHotkey script from the second step above to the *ButtonFunctions.ahk* file. For example: 

```AutoHotkey
    #Include *i Layer1\RunOrActivate_FrameMaker.ahk. 
```

### Additional tips and tricks
1. How to quicly check if a script which you would like to assign to one of the buttons actually works? 

Answer: Try if it works as a standalone script (without *Otagle* interface). Just add the AutoHotkey auto-execute section to your file, for example:
 ```AutoHotkey
    #NoEnv
    #SingleInstance, Force
    SendMode, Input
    SetBatchLines, -1
    SetWorkingDir, %A_ScriptDir%
    RunOrActivate_FrameMaker()
```
Now check, if it works. If all is fine, comment out or remove above lines and try it again, this time together with *Otagle*.

2. I recommend to organise your scripts and button icons related to the same layers into separate subfolders.


## Additional links

AutoHotkey forum [topic dedicated to Otagle](https://www.autohotkey.com/boards/viewtopic.php?t=69690). You can find there discussion about pros and cons as well as syntetic comparison with Elgato Stream Deck.
