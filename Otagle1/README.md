# Otagle1 

- Mimics numeric pad (numpad) of keyboard. 
- Window size is dedicated to dedicated touch screen (1024 x 600 px).
- The oldest release of Otagle concept. For more info please see [the main readme of the project](https://github.com/mslonik/Otagle/tree/master/README.md).

![Full keyboard with numeric pad](/Otagle1/pictures/IMG_5525_FullKeyboard_zm.jpg)
#### Picture 1. Full keyboard with numeric pad.

![Zoom in to numeric pad](/Otagle1/pictures/IMG_5524_NumPad_zm.jpg)
#### Picture 2. Zoom in to numeric pad aka numpad.

![Photo of the dedicated touch screen](/Otagle1/pictures/IMG_5523_DefaultScreen_zm.jpg)
#### Picture 3. Photo of the dedicated touch screen, default layer of application.

## How to run it?

Download all the files to the chosen folder. Keep the subfolder structure. 

**Tip**: use Git clone for your convenience.
**Tip**: executable file is not required.

If you already have installed [AutoHotkey](https://www.autohotkey.com/docs/AutoHotkey.htm) ver. 1.1 (deprecated) then just run the *Otagle.ahk*. If not, at first [download](https://www.autohotkey.com/download/ahk-install.exe) and install the AutoHotkey v1.1.

After running you should see the default window / layer, see *Picture 3* above. If you have dedicated piece of hardware, move the new opened window to that display.


## Function description

Layer by layer. The default layer is displayed upon Otagle1 starts.

### The default layer

![Layer0_BaseLayer](/Otagle1/pictures/Layer0_BaseLayer.png)

| row          | icon / key     | function                           |
| :---         |     :---       | :---                               |
| top          | NumLock        | toggles the NumLock key (ON / OFF) |
| top          | KeePass        | runs or activates the [KeePass application](https://keepass.info/) (password manager)      |
| top          | Word           | runs or activates Microsoft Word, switches to Word sublayer      |
| top          | diskette       | runs or activates [Total Commander](https://www.ghisler.com/) (twin-window file manager)      |

### Layer1 (Word_BaseLayer)

![Layer1_Word_BaseLayer](/Otagle1/pictures/Layer1_Word_BaseLayer.png)

| row          | icon / key         | function                           |
| :---         |     :---           | :---                               |
| top          | NumLock            | toggles the NumLock key (ON / OFF) |
| top          | Styles             | moves to Layer3 (Word_TemplateStyles1) |
| top          | Building Blocks    | moves to Layer2 (Word_BBLayer) |
| top          | Macros             | moves to Layer6 (Macro_Layer) |
| 2nd          | Attach a template to this document | Attaches one of the defined templates (DOTM files) |
| 2nd / 3rd    | Back               | Return to previous layer |
| 3rd          | Text Strikethrough | Font level formatting, strikethrough |
| 3rd          | Text Hidden        | Specific style to better show hidden text |

### Layer2 (Word_BBLayer)

![Layer2_Word_BBLayer](/Otagle1/pictures/Layer2_Word_BBLayer.png)

| row          | icon / key         | function                           |
| :---         | :---               | :---                               |
| top          | NumLock            | toggles the NumLock key (ON / OFF) |
| top          | BB Mona            | inserts Building Block Mona        |
| top          | BB Table1          | inserts Building Block Table 1    |
| top          | BB Header Dissertation | inserts Building Block Header Dissertation |
| 2nd / 3rd    | Back               | Return to previous layer |

### Layer3 (Word_TemplateStyles1)

![Layer3_Word_TemplateStyles1](/Otagle1/pictures/Layer3_Word_TemplateStyles1.png)

| row          | icon / key         | function                                   |
| :---         |     :---           | :---                                       |
| top          | NumLock            | toggles the NumLock key (ON / OFF)         |
| top          | Normal             | Applies dedicated template paragraph style |
| top          | Normal between     | Applies dedicated template paragraph style |
| top          | Heading 1          | Applies dedicated template paragraph style |
| 2nd          | Heading 2          | Applies dedicated template paragraph style |
| 2nd          | Heading 3          | Applies dedicated template paragraph style |
| 2nd          | Heading 4          | Applies dedicated template paragraph style |
| 2nd / 3rd    | Back               | Moves back to previous layer               |
| 3rd          | Heading 5          | Applies dedicated template paragraph style |
| 3rd          | Heading 6          | Applies dedicated template paragraph style |
| 3rd          | Heading 7          | Applies dedicated template paragraph style |
| 4th          | Heading 8          | Applies dedicated template paragraph style |
| 4th / 5th    | Forward            | Moves forward to the next layer            |
| 5th          | Small line         | Applies dedicated template paragraph style |
| 5th          | Hidden special     | Applies dedicated template paragraph style |

### Layer4 (Word_TemplateStyles2)

![Layer4_Word_TemplateStyles2](/Otagle1/pictures/Layer4_Word_TemplateStyles2.png)

| row          | icon / key         | function                                   |
| :---         |     :---           | :---                                       |
| top          | NumLock            | toggles the NumLock key (ON / OFF)         |
| top          | Table modified     | Applies dedicated template paragraph style |
| top          | Table legend       | Applies dedicated template paragraph style |
| top          | Table modified without grid | Applies dedicated template paragraph style |
| 2nd          | Text in table      | Applies dedicated template paragraph style |
| 2nd / 3rd    | Back               | Moves back to previous layer               |

### Layer 6 (Word_MacroLayer)

![Layer6_Word_MacroLayer](/Otagle1/pictures/Layer6_Word_MacroLayer.png)

| row          | icon / key         | function                                        |
| :---         |     :---           | :---                                            |
| top          | NumLock            | toggles the NumLock key (ON / OFF)              |
| top          | RedTypeface        | Macro, alters selected text to red color   |
| top          | Text Border        | Macro, enables text border for page layout |
| top          | Table Autofit to text border | Macro, enables table autofit to page borders |
| 2nd / 3rd    | Back               | Moves back to previous layer               |

---

## File structure

For each layer number there is a separate folder. Layer folder contains the following 3 types of files:
- AHK (.ahk), script files,
- SVG (.svg), vector graphic files, source files for raster graphics files,
- PNG (.png), picture files aka raster graphics files, 130 px x 130 px or 130 px x 280 px,

Layer definition is stored within **Layer** n **.ahk** files.

---

## Pros and cons, final comments

Pros: 
- it works,
- practical prove of concept,
- easy to understand code flow,
- saved plenty of time, reducing everyday chore related to documents formatting.

Cons:
- no configuration file,
- all icons have to be manually created / converted with additional applications,
- configuration of layers and dedicated scripts hard coded within script files,
- if you wish to change anything you will need to edit specific .ahk  files.

Comments:
- This is initial version of Otagle, which was next improved (Otagle1 → Otagle2 → Otagle3).
- The fusion of small, cheap touch screen with AutoHotkey script proved to be useful.
- Labor extensive change of configuration definitely can be improved.

The vast majority of dedicated AutoHotkey scripts call features (styles, building blocks, macros) of dedicated Microsoft Word template. That one template file is no longer available and it was protected by copyrights, so some of the scripts cannot be demonstrated anymore.

---

## Additional links

AutoHotkey forum [topic dedicated to Otagle](https://www.autohotkey.com/boards/viewtopic.php?t=69690)