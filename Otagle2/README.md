# O T A G L E 2

By default just run *Otagle.ahk*. If you run it for the very first time, the *Configuration Wizard* will guide you through the process of *Otagle* configuration. Below it is shown on example screen shots. The configuration is stored within *Config.ini*, which is human readable and editable. 

The required set of information:

1. Choose a screen (monitor / display) where by default the main window of Otagle will be displayed.
2. Define size of your button matrix. E.g. how many buttons in a row, how many buttons in a column. All the buttons will be always rectangle (or square). Save this configuration.
3. Connect each button of your matrix 
    3.1. to two icons
        3.1.1. the first: showing inactive state, 
        3.1.2. the second: showing active state
    3.2. to AutoHotkey script or EXE file.
4. Reload the Otagle.    

![Otagle2 Start](/Otagle2/pictures/Otagle2_Start.png)
##### Picture. Otagle 2, start, no *Config.ini* is detected.

![Configuration Wizard, Layer1](/Otagle2/pictures/Otagle2_ConfigWizard_Layer1.png)
##### Picture. Initial screen of *Configuration Wizard*.

![Configuration Wizard, Step 1 of 3](/Otagle2/pictures/Otagle2_ConfigWizard_Step1of3.png)
##### Picture. Choose a monitor where GUI will be located.

Tip: To make your choice ease you can check monitor numbering by pressing the corresponding button. Then small digit is displayed on each of your monitors. 

![Configuration Wizard, Step 2 of 3](/Otagle2/pictures/Otagle2_ConfigWizard_Step2of3.png)
##### Picture. Specify amount and size of buttons. 

By default *Configuration Wizard* proposes some values. To continue you must press the *Calculate* button.

![Configuration Wizard, Step 2 of 3, Test button](/Otagle2/pictures/Otagle2_ConfigWizard_Step2of3_Test.png)
##### Picture. Press the *Test* button.

Tip: Experiment a bit with the settings. Mind that pointing to small buttons with your fingers could be cumbersome if button is too small or distance between buttons is too small. You can also define a name of your layer.

![Configuration Wizard, Step 2 of 3, Test button 2](/Otagle2/pictures/Otagle2_ConfigWizard_Step2of3_Test2.png)
##### Picture. Watch and test the button matrix, displayed on the specified screen. 

![Configuration Wizard, Step 2 of 3, Save config](/Otagle2/pictures/Otagle2_ConfigWizard_Step2of3_SaveConfig.png)
##### Picture. If you're content with result, press *Save config* button.

![Configuration Wizard, Step 2 of 3, Save config 2](/Otagle2/pictures/Otagle2_ConfigWizard_Step2of3_SaveConfig2.png)
##### Picture. Progress bar is displayed as process of generating the *Congig.ini* is continued.

![Configuration Wizard, Step 2 of 3, Configuration saved](/Otagle2/pictures/Otagle2_ConfigWizard_Step2of3_ConfigurationSaved.png)
##### Picture. Confirmation that *Config.ini* was created.

![Configuration Wizard, Step 2 of 3, Continue button](/Otagle2/pictures/Otagle2_ConfigWizard_Step2of3_Continue.png)
##### Picture. Now the *Save config* button is disabled, and *Continue* button is enabled.

![Configuration Wizard, Step 3 of 3](/Otagle2/pictures/Otagle2_ConfigWizard_Step3of3.png)
##### Picture. Associate pictures and functions with buttons.

Watch and read carefully. Do not press the buttons *Finish wizard* or *Add next layer* yet. Instead click any of the buttons in the bottom window. Associate up to 2 pictures and 1 script to the clicked button:
- 1st picture which will be shown by default,
- 2nd picture which will be shown if button is selected,
- AutoHotkey script or EXE file which will be run when the button is selected.

Now, I clicked the button *1_1*.

![Button 1_1, select picture](/Otagle2/pictures/Otagle2_Button1_1_SelectPicture.png)
##### Picture. Select the 1st picture file.

Navigation window is opened automatically. Navigate to the folder where picture files are available. 

![Button 1_1, selected picture](/Otagle2/pictures/Otagle2_Button1_1_SelectedPicture.png)
##### Picture. Selected the 1st picture file.

After your choice is completed, automatically the next selection window is opened.

![Button 1_1, selected picture 2](/Otagle2/pictures/Otagle2_Button1_1_SelectedPicture2.png)
##### Picture. Select the 2nd picture file. This picture will be shown when button is selected.

After your choice is completed, automatically the next selection window is opened.

![Button 1_1, select script](/Otagle2/pictures/Otagle2_Button1_1_SelectScript.png)
##### Picture. Select the .ahk  or .exe  file.

![Button 1_1, selected script](/Otagle2/pictures/Otagle2_Button1_1_SelectedScript.png)
##### Picture. The selected AutoHotkey script.

After your choice is completed, automatically the whole matrix button is displayed again, but this time you can see that one of the buttons shows previously selected icon.

Tip: I made a mistake and now matrix shows activated icon by default. Now you can continue process of assigning icons and script to the rest of your buttons.

![Configuration Wizard, Step 3 of 3 again](/Otagle2/pictures/Otagle2_Step3_Again.png)
##### Picture. Now you can repeat the above process of selection 1st and 2nd picture as well as AutoHotkey or EXE script for any other button.

![Configuration Wizard, Step 3 of 3 finished](/Otagle2/pictures/Otagle2_Step3_FinishWizard.png)
##### Picture. If you already finished the process of selection, press *Finish wizard* button.

![Otagle2 reload](/Otagle2/pictures/Otagle2_WillReload.png)
##### Picture. Message mentioning about required reload.

![Otagle2 after reload](/Otagle2/pictures/Otagle2_AfterReload.png)
##### Picture. After reload application starts.

*Comment*: As you can see on the last picture, something went wrong and instead of matrix 6 x 11 only 1 x 11 is displayed. Consider it as a bug.

Added or changed files when configuration wizard is finished:
- Config.ini
- ButtonFunctions.ahk