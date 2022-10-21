RunOrActivate_FrameMaker()
{ 
	Process, Exist, FrameMaker.exe
	if (ErrorLevel = 0)
		{
		Run, "C:\Program Files\Adobe\Adobe FrameMaker 2020\FrameMaker.exe"
		}
		else
		{
		GroupAdd, ms_framemaker, ahk_exe FrameMaker.EXE
		if (WinActive("ahk_exe TOTALCMD64.EXE"))
			{
			GroupActivate, ms_framemaker, r
			} 
		else
			{
			WinActivate ahk_exe FrameMaker.EXE
			
			}
		}
}

