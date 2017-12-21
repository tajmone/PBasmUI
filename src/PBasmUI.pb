; ------------------------------------------------------------------------------
; "PBasmUI.pb" v3.23a-rc01 (release candidate n° 1) | 2017/12/21
;{------------------------------------------------------------------------------
; PBasmUI -- Tristano Ajmone's fork:
;    https://github.com/tajmone/PBasmUI
;
; Based on the original code by Horst Schaeffer:
;    http://horstmuc.de/pb.htm
; ------------------------------------------------------------------------------
; Released under MIT License (see "LICENSE" file):
;
; Copyright (c) 2004-2017, Horst Schaeffer -- http://horstmuc.de/pb/
; Copyright (c) 2017 Tristano Ajmone -- https://github.com/tajmone/PBasmUI
;}------------------------------------------------------------------------------

#title = "PB Assembler UI  3.23a-rc01 (tajmone fork)"  
#tempfile = 1
#configfile = 2

IncludeFile "Macro.pbi" 

Global PBsource.s = ProgramParameter() 
Global Compiler.s
CompilerIf #PB_Compiler_Debugger  
  Compiler = #PB_Compiler_Home + "\Compilers\PBCompiler.exe"
CompilerElse 
  Compiler = GetEnvironmentVariable("PB_TOOL_Compiler") 
CompilerEndIf 

; LogFile = "<filename>.log" (replaces #Errorfile > "Error.out")
Global LogFile.s = GetFilePart(PBsource, #PB_FileSystem_NoExtension) + ".log"

; DummyExe redirects compiler exe output to TEMP folder when "Product > Executable" is unchecked
; (but not if "/REASM current ASM file" is selected!)
; NOTE: The returned path to %TEMP% will never contain spaces, so no need to wrap in DQuotes! 
Global DummyExe.s = GetEnvironmentVariable("TEMP") + "\PureBasic.exe"

; reAsmExeDefault -- default /REASM executable filename if exeFile is empty
Global reAsmExeDefault.s = GetPathPart(PBsource) +
                           GetFilePart(PBsource, #PB_FileSystem_NoExtension) + "_reAsm.exe"


If PBsource = "" Or Compiler = ""
  MessageBox_(0,"For IDE integration see PBasmUI.txt","Error",0) : End 
EndIf 

#CPUoffers =  "All CPU,Dynamic CPU,CPU with MMX,CPU with 3DNOW,CPU with SSE,CPU with SSE2" 
#CPUoptions = ",/DYNAMICCPU,/MMX,/3DNOW,/SSE,/SSE2"
#CPUs = 6
; ---------------------------------------------------------------
;- Window  
; ---------------------------------------------------------------
Enumeration 1 ; gadgets
  #compileSource : #PBSourceFile 
  #REASM
  #withIcon : #IconFile : #IconBrowse
  #withResource : #ResourceFile
  
  #produceEXE : #EXEfile : #ExeBrowse
  #WindowsMode : #ConsoleMode : #DLLMode 
  #XPMode : #OnErrMode ; #VersionInfo
  #UniMode : #ThreadMode
  #AdminMode : #UserMode
  #DebugMode : #CPUmode
  #Switches
  
  #RunFrame
  #openASMfile : #ViewDefault : #viewASM
  #running 
  #RunButton : #ExitButton
  #RunExe : #autoExit
  
  #ErrorFrame
  #Error : #Etext : #Eclose
EndEnumeration
  
#width = 600 : #height = 470
#flags = #PB_Window_SystemMenu | #PB_Window_MinimizeGadget | #PB_Window_Invisible | #PB_Window_ScreenCentered

GuiFont = LoadFont(0,"MS Shell DLG 2",9)
BoldFont = LoadFont(1,"MS Shell DLG 2",9,#PB_Font_Bold)
Global WaitCursor = LoadCursor_(0,#IDC_WAIT)

#wContainer = #width-20
Procedure Container(y,height,title.s)
  Shared BoldFont 
  ContainerGadget(#PB_Any,10,y,#wContainer,height,#PB_Container_Single)
  tg = TextGadget(#PB_Any,10,5,50,20,title) 
  SetGadgetFont(tg,BoldFont)
EndProcedure 

If OpenWindow(0,50,200,#width,#height,#title,#flags) 
Else: End: EndIf 
  SetGadgetFont(#PB_Default,GuiFont)
  #xInput = 110
  ;- Gadgets Create
  Container(10,140,"Source")
    OptionGadget(#compileSource,10,25,100,22,"PB file")
    OptionGadget(#REASM,10,50,200,22,"/REASM current ASM file")
      SetGadgetState(#compileSource,1)
    StringGadget(#PBSourceFile,#xInput,25,#wContainer-#xInput-10,22,PBsource,#PB_String_ReadOnly)
    CheckBoxGadget(#withIcon,10,75,80,22,"Icon")
    StringGadget(#IconFile,#xInput,75,#wContainer-#xInput-45,22,"")
    ButtonGadget(#IconBrowse,#wContainer-40,75,30,22,"..")
    CheckBoxGadget(#withResource,10,105,80,22,"Resource")
    StringGadget(#ResourceFile,#xInput,105,#wContainer-#xInput-45,22,"")
  CloseGadgetList() 
  
  Container(160,175,"Product")
  #x1 = 40             :  #x2 = 160           :  #x3 = 330 
  #w1 = #x2 - #x1 - 10 :  #w2 = #x3 - #x2 -10 :  #w3 = #wContainer-#x3-10
    CheckBoxGadget(#produceEXE,10,25,100,22, "Executable")
    StringGadget(#EXEfile,#xInput,25,#wContainer-#xInput-45,22,"")
    ButtonGadget(#ExeBrowse,#wContainer-40,25,30,22,"..")
    OptionGadget(#WindowsMode,#x1,55,#w1,22,"Windows")
    OptionGadget(#ConsoleMode,#x1,75,#w1,22,"Console")
    OptionGadget(#DLLMode,#x1,95,#w1,22,"Shared DLL")
    CheckBoxGadget(#XPMode,#x2,55,#w2,22,"XP+ theme support")
    CheckBoxGadget(#OnErrMode,#x2,75,#w2,22,"OnError lines support") 
    ; CheckBoxGadget(#VersionInfo,#x2,115,#w2,22,"Version info")
    
    CheckBoxGadget(#UniMode,#x3,55,#w3,22,"Unicode executable")
    CheckBoxGadget(#ThreadMode,#x3,75,#w3,22,"Threadsafe executable")
    CheckBoxGadget(#AdminMode,#x3,95,#w3,22,"Request Admin mode")
    CheckBoxGadget(#UserMode,#x3,115,#w3,22,"Request User mode")
    ; CheckBoxGadget(#OnErrMode,#x2,115,#w2,22,"OnError lines support")
    
    ComboBoxGadget(#CPUmode,#x1,140,#w1,24)
      For i = 1 To #CPUs : AddGadgetItem(#CPUmode,-1,StringField(#CPUoffers,i,",")) : Next
      SetGadgetState(#CPUmode,0)
    TextGadget(#PB_Any,#x2,145,#w2,20,"More Switches...",#PB_Text_Right)
    StringGadget(#Switches,#x3,140,#w3,24,"")
  CloseGadgetList() 

  ContainerGadget(#ErrorFrame,10,345,#width-20,115,#PB_Container_Single)
    EditorGadget(#Error,0,0,#width-20,88,#PB_Editor_ReadOnly)
    TextGadget(#Etext,10,94,200,20,"")
    ButtonGadget(#Eclose,#width-100,93,75,20,"Ok")
  CloseGadgetList() 
  HideGadget(#ErrorFrame,1)

  ContainerGadget(#RunFrame,10,345,#width-20,115,#PB_Container_Single)
    CheckBoxGadget(#openASMfile,50,10,150,20,"Open PureBasic.asm")
    OptionGadget(#ViewDefault,225,10,100,20,"with Notepad")
    OptionGadget(#viewASM,335,10,100,20,"as .ASM file")
    #bp = 150 
    TextGadget(#running,30,40,100,22,"")
    ButtonGadget(#RunButton,#bp,40,100,25,"Run")
    ButtonGadget(#ExitButton,#bp+120,40,100,25,"Exit")
    CheckBoxGadget(#RunExe,#bp,75,100,20,"Start Program")
    CheckBoxGadget(#autoExit,#bp+120,75,120,20,"Exit when done")
  CloseGadgetList() 
  
Macro ErrorFrameMode(status=#True)        ; switch frames in place
  HideGadget(#RunFrame,status)
  HideGadget(#ErrorFrame,status!1)
EndMacro     

;- Error report
Procedure ShowErrorReport(fname.s) 
  ErrorFrameMode(#True)
  ClearGadgetItems(#Error)
  SetGadgetText(#Etext,"Report File: " + GetFilePart(fname))
  If ReadFile(#tempfile,fname)
    bom = ReadStringFormat(#tempfile)
    While Eof(#tempfile) = #False
      AddGadgetItem(#Error,-1,ReadString(#tempfile,bom)) 
    Wend 
    SendMessage_(GadgetID(#Error),#EM_SCROLLCARET,0,0)
    CloseFile(#tempfile)
  EndIf 
  beep()
EndProcedure 

Procedure OptionDependencies()
  x = Bool(GetGadgetState(#compileSource) !1)
  DisableGadget(#PBSourceFile,x)
  DisableGadget(#openASMfile,x)
  If x = 0 : x = Bool(GetGadgetState(#openASMfile) !1) : EndIf 
  DisableGadget(#ViewDefault,x)
  DisableGadget(#viewASM,x)
  
  x = Bool(GetGadgetState(#produceEXE) !1)
  DisableGadget(#EXEfile,x)
  DisableGadget(#ExeBrowse,x)
  x = Bool(GetGadgetState(#withIcon) !1)
  DisableGadget(#IconFile,x)
  DisableGadget(#IconBrowse,x)
  x = Bool(GetGadgetState(#withResource) !1)
  DisableGadget(#ResourceFile,x)
EndProcedure 

; ---------------------------------------------------------------
;- Config Data 
; ---------------------------------------------------------------
#IDEoptions = "IDE Options = PureBasic "   ; identifies option section 
Global NewList CFGline.s()                 ; list of PB config statements

Procedure LoadPBconfig()       ; from PBsource or CFG file to list CFGline()
  ConfigSource.s = PBsource                          ; default 
  ConfigPrefix.s = "; "
  If FileSize(PBsource + ".cfg") > 0                 ; separate CFG file? 
    ConfigSource.s = PBsource + ".cfg"  
    ConfigPrefix = ""
  EndIf 
  Keyword$ = ConfigPrefix + #IDEoptions
  
  If ReadFile(#configfile,ConfigSource) 
    bom = ReadStringFormat(#configfile)
    While Eof(#configfile) = #False 
      line$ = ReadString(#configfile,bom)
      If Left(line$,Len(Keyword$)) = Keyword$ : CFGfound = #True : EndIf 
      If CFGfound                                    ; also for all subsequent lines..
        AddElement(CFGline()) 
        CFGline() = Mid(line$,Len(ConfigPrefix)+1)   ; cut "; " if present
      EndIf 
    Wend 
    CloseFile(#configfile) 
  EndIf 
ProcedureReturn CFGfound
EndProcedure 

Procedure.s GetAssignment(IDstring.s,instanceRequest=1)        ; from list CFGlines() - case sensitive!
  instanceFound = 0
  ForEach CFGline()
    If Trim(StringField(CFGline(),1,"=")) = IDstring            ; up to "=" or all (if no "=")
      instanceFound +1
      If instanceFound = instanceRequest
        pos = FindString(CFGline(),"=")
        If pos 
          assignedString.s = Trim(Mid(CFGline(),pos+1))             ; there may be more "="s
          assignedString = ReplaceString(assignedString," = ","=")  ; remove spaces !!!
          Break 
        Else
          assignedString = " "                                  ; indicates FOUND but empty
        EndIf 
      EndIf
    EndIf 
  Next 
ProcedureReturn assignedString 
EndProcedure 

Procedure GetPBconfigData()
  PBsource = FullPath(PBsource)
  SetCurrentDirectory(GetPathPart(PBsource)) 
  If LoadPBconfig()
    
    exeFile.s = GetAssignment("Executable") 
    If exeFile = "" 
      exeFile = GetFilePart(PBsource,#PB_FileSystem_NoExtension) + ".exe"
    EndIf 
    SetGadgetText(#EXEfile,FullPath(exeFile))
    SetGadgetState(#produceEXE,1) 

    format.s = GetAssignment("ExecutableFormat") 
    If format = "Console"        : SetGadgetState(#ConsoleMode,1)
    ElseIf format = "Shared DLL" : SetGadgetState(#DLLMode,1)
    Else                         : SetGadgetState(#WindowsMode,1)
    EndIf 

    CPUmode.s = GetAssignment("CPU")  ; combo box item
    If CPUmode : SetGadgetState(#CPUmode,Val(CPUmode)) : EndIf  
    
    IconFile.s = GetAssignment("UseIcon")
    If IconFile
      IconFile = FullPath(IconFile) 
      SetGadgetText(#IconFile,IconFile)
      SetGadgetState(#withIcon,1) 
    EndIf 
    
    ResourceFile.s = GetAssignment("AddResource")
    If ResourceFile
      ResourceFile = FullPath(ResourceFile) 
      SetGadgetText(#ResourceFile,ResourceFile)
      SetGadgetState(#withResource,1) 
    EndIf 
    
    If GetAssignment("EnableXP")  :      SetGadgetState(#XPMode,1) : EndIf 
    If GetAssignment("EnableUnicode") :  SetGadgetState(#UniMode,1) : EndIf 
    If GetAssignment("EnableThread") :   SetGadgetState(#ThreadMode,1) : EndIf 
    If GetAssignment("EnableOnError")  : SetGadgetState(#OnErrMode,1) : EndIf 
    If GetAssignment("EnableAdmin")    : SetGadgetState(#AdminMode,1) : EndIf 
    If GetAssignment("EnableUser")     : SetGadgetState(#UserMode,1) : EndIf 
    ; If GetAssignment("IncludeVersionInfo") : SetGadgetState(#VersionInfo,1) : EndIf 
  EndIf 
  OptionDependencies()
EndProcedure 

Procedure.s GetConstants()      ; get ALL CONSTANT assignments, and produce ONE option string
  ConstantsOption.s = ""
  i = 1
  Repeat 
    constant$ = GetAssignment("Constant",i) 
    If constant$
      If Left(constant$,1) = "#" 
        constant$ = Mid(constant$,2)                      ; remove "#" (as allowed in IDE)
      EndIf 
      ConstantsOption + " /Constant " + constant$ 
    Else 
      Break
    EndIf 
    i + 1
  Until #break
ProcedureReturn ConstantsOption
EndProcedure 

; ---------------------------------------------------------------
;- Run Compiler
; ---------------------------------------------------------------
#ASMfile    = "PureBasic.asm"   ; In sourcefile directory
#ASMoutFile = "Assembler.out"   ; when and where??? (see "WORK NOTES" comments)
#LinkerFile = "Linker.out"      ; when and where??? (see "WORK NOTES" comments)

Procedure RunCompiler()
  SetCurrentDirectory(GetPathPart(PBsource))
  exeFile.s = GetGadgetText(#EXEfile)
  IconFile.s = GetGadgetText(#IconFile)
  ResourceFile.s = GetGadgetText(#ResourceFile)
  If exeFile = "" : SetGadgetState(#produceEXE,0) : EndIf 
  If IconFile = "" : SetGadgetState(#withIcon,0)  : EndIf 
  If ResourceFile = "" : SetGadgetState(#withResource,0)  : EndIf 
  
  SetCursor_(WaitCursor)
  Parameters.s = "" 
  
  ; !!! CHANGED by tajmone !!!
  If GetGadgetState(#REASM)
    Parameters + " /REASM " + #q2$+ #ASMfile +#q2$  ; <= "/REASM PureBasic.asm"
    If exeFile = ""
      exeFile = reAsmExeDefault                     ; <= "<filename>_reAsm.exe"
      SetGadgetText(#EXEfile, exeFile) ; update exe-path string gadget
    EndIf    
    Parameters + " /EXE " + #q2$+exeFile+#q2$
  Else
    DeleteFile(#ASMfile)
    Parameters + " /COMMENTED "
    Parameters + #q2$+PBsource+#q2$
    If GetGadgetState(#produceEXE)
      Parameters + " /EXE " + #q2$+exeFile+#q2$
    Else
      ; Redirect exe output to %TEMP%\PureBasic.exe instad:
      Parameters + " /EXE " + DummyExe
    EndIf   
    
  EndIf 
  
  If GetGadgetState(#withIcon)      : Parameters + " /ICON " + #q2$+IconFile+#q2$ : EndIf 
  If GetGadgetState(#withResource)  : Parameters + " /RESOURCE " + #q2$+ResourceFile+#q2$ : EndIf 
    
  If GetGadgetState(#ConsoleMode)   : Parameters + " /CONSOLE"
  ElseIf GetGadgetState(#DLLMode)   : Parameters + " /DLL"
  EndIf 
  
  Parameters + " " + StringField(#CPUoptions,GetGadgetState(#CPUmode)+1,",") 
  If GetGadgetState(#XPMode)        : Parameters + " /XP" : EndIf 
  If GetGadgetState(#OnErrMode)     : Parameters + " /LINENUMBERING" : EndIf 
  ; If GetGadgetState(#VersionInfo) : Parameters + " /INCLUDEVERSIONINFO" : EndIf 
  If GetGadgetState(#UniMode)       : Parameters + " /UNICODE" : EndIf 
  If GetGadgetState(#ThreadMode)    : Parameters + " /THREAD" : EndIf 
  If GetGadgetState(#AdminMode)     : Parameters + " /ADMINISTRATOR" : EndIf 
  If GetGadgetState(#UserMode)      : Parameters + " /USER" : EndIf
  

  s.s = Trim(GetGadgetText(#Switches))
  If s : Parameters + " " + s : EndIf 
  
  Parameters + GetConstants() 
;   MessageRequester("DEBUG INFO", "Parameters: "+ Parameters) ; DBG Parameters
  
  DeleteFile(#LinkerFile)
  DeleteFile(#ASMoutFile)
  DeleteFile(LogFile)
  
  msg.s = "" : ReportFile.s = "" : #buffersize = 40*#KB
  *Buffer = AllocateMemory(#buffersize)
  If *Buffer 
    Process = RunProgram(Compiler,Parameters,"",#PB_Program_Open|#PB_Program_Read|#PB_Program_Hide) ; #PB_Program_Wait
    If Process 
      ReadSize = ReadProgramData(Process,*Buffer,#buffersize)
      CloseProgram(Process)
      If CreateFile(#tempfile,LogFile)
        WriteData(#tempfile,*Buffer,ReadSize)
        CloseFile(#tempfile) ;- ReportFile checks
        If     FileSize(#ASMoutFile) > 0 : ReportFile = #ASMoutFile ; Not sure how/why this "Assembler.out" file would be produced
        ElseIf FileSize(#LinkerFile) > 0 : ReportFile = #LinkerFile ; Not sure how/why this "Linker.out" file would be produced
        ElseIf FileSize(#ASMfile)   <= 0 : ReportFile = LogFile     ; If "PureBasic.asm" wasn't created show Error Report ("<filename>.log")!
        Else : ASMproduced = #True
        EndIf 
      Else : msg = "Cannot catch output"
      EndIf 
    Else : msg = "Cannot run Compiler" 
    EndIf 
    FreeMemory(*Buffer)
  EndIf 
  If msg
    MessageBox_(WindowID(0),msg,"Error",0)
    ProcedureReturn #NUL 
  EndIf 
  
  ; TODO: I could always show the Log report....
  If ReportFile : ShowErrorReport(ReportFile) : EndIf 
  If ASMproduced 
    prog.s = "Notepad.exe"
    If GetGadgetState(#openASMfile) & GetGadgetState(#compileSource)
      ViewFile.s = FullPath(#ASMfile) 
      If GetGadgetState(#viewASM)
        RunProgram(ViewFile,"","")
      Else 
        RunProgram(prog,#q2$+ViewFile+#q2$,"",0)
      EndIf 
    EndIf
    ; !!! CHANGED tajmone: With /REASM #produceEXE will be disabled, so check #REASM too (Or) !!!
    If GetGadgetState(#RunExe) And
       (GetGadgetState(#produceEXE) Or GetGadgetState(#REASM))
      RunProgram(exeFile,"",GetPathPart(exeFile),0)
    EndIf 
  EndIf 
ProcedureReturn ASMproduced
EndProcedure 

; ---------------------------------------------------------------
;- FileBrowse
; ---------------------------------------------------------------

Procedure GetIconFile()
  source.s = GetGadgetText(#IconFile)
  If source = "" : source = GetGadgetText(#EXEfile) : EndIf 
  path.s = GetPathPart(source)
  source = OpenFileRequester("Icon",path,"Icon files |*.ico",0)
  If source : SetGadgetText(#IconFile,source) : EndIf 
EndProcedure 

Procedure GetExePath()
  fname.s = GetGadgetText(#EXEfile)
  If fname = "" 
    ln = Len(GetExtensionPart(PBsource))
    fname.s = Left(PBsource,Len(PBsource)-ln-1) + "exe"
  EndIf
  file.s = SaveFileRequester("Executable",fname,"Exe files |*.exe",0)
  If file : SetGadgetText(#EXEfile,file) 
  EndIf 
EndProcedure 

; ---------------------------------------------------------------
;- Main
; ---------------------------------------------------------------
HideWindow(0,0)
DisableGadget(#REASM,Bool(FileSize(#ASMfile) <= 0)) 

; initial states
SetGadgetState(#openASMfile,1)
SetGadgetState(#ViewDefault,0) 
SetGadgetState(#viewASM,1) 
SetGadgetState(#RunExe,0) 
SetGadgetState(#autoExit,1) 
  
GetPBconfigData()

Repeat
  Event = WaitWindowEvent()
  ;- Gadgets Events
  If Event = #PB_Event_Gadget
    Select EventGadget()
      Case #produceEXE
        DisableGadget(#RunExe,Bool(GetGadgetState(#produceEXE))!1)
        ; !!! CHANGED tajmone: Also enable/disable Exe path string gadget !!!
        DisableGadget(#EXEfile,Bool(GetGadgetState(#produceEXE))!1)
      Case #compileSource ; !!! ADDED tajmone: "Source > PB File" OptionGadget !!!
        DisableGadget(#produceEXE, 0) ; Enable "Product > Executable" checkbox
        OptionDependencies()          ; Update other gadgets states...
      Case #REASM ; !!! ADDED tajmone: "Source > /REASM current ASM file" !!!
        SetGadgetState(#produceEXE, #PB_Checkbox_Checked)        
        DisableGadget(#produceEXE, 1) ; Disable "Product > Executable" checkbox (exe is now mandatory!)
        DisableGadget(#EXEfile,0)     ; Enable Exe path string gadget
        DisableGadget(#RunExe,0)      ; Enable "Start Program" checkbox
        OptionDependencies()          ; Update other gadgets states...
      Case #IconBrowse : GetIconFile()
      Case #ExeBrowse  : GetExePath()
      Case #RunButton  : done = RunCompiler() & GetGadgetState(#autoExit)
        DisableGadget(#REASM,Bool(FileSize(#ASMfile) <= 0))
      Case #ExitButton : done = #True
    Case #Eclose : ErrorFrameMode(#False)
    Default : OptionDependencies()
    EndSelect 
  ElseIf Event = #PB_Event_CloseWindow : done = #True
  EndIf 
Until done
End
