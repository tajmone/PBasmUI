; Macros,  API functions, Constants for PBasmUI

#Q2 = '"'
#Q2$ = Chr(#Q2)
#notTrue = #False 
#break = 0 
#EOF = 26
#Kb = 1024

Macro Beep(code=0)
  MessageBeep_(code)
EndMacro 

Procedure.s FullPath(fname.s) ; empty fname remains empty
  Protected fp.i 
  If fname 
    Max_Path.s = Space(#MAX_PATH)
    If GetFullPathName_(@fname,#MAX_PATH,@Max_Path,@fp)
      fname = Max_Path 
    EndIf 
  EndIf 
  ProcedureReturn fname
EndProcedure 

