#InstallKeybdHook ;needed for Worms? ; https://www.autohotkey.com/docs/commands/_InstallKeybdHook.htm
SendMode Input ;??

; Control key ^
; Alt key     !
; Shift key   +
; Windows key #

; https://www.autohotkey.com/docs/Variables.htm#os
; Run this script as administrator
/*
if not A_IsAdmin
{
  MsgBox, You are not the administrator!
  DllCall("shell32\ShellExecuteA", uint, 0, str, "RunAs", str, A_AhkPath, str, """" . A_ScriptFullPath . """", str, A_WorkingDir, int, 1)  ; Last parameter: SW_SHOWNORMAL = 1
  ExitApp
}
*/

; Toggle AlwaysOnTop property
; http://www.autohotkey.com/board/topic/53249-transparent-andor-always-on-top/?p=573906
; https://www.autohotkey.com/docs/commands/WinSet.htm
; Win+a
; #a::
!#Down:: ;Windows+Alt+Down
  ; WinGetTitle, Title, A
  ; MsgBox, The active window is "%Title%".
  WinSet, AlwaysOnTop, Toggle, A ; "If this is the letter A and the next 3 parameters are omitted, the active window will be used."

  ; http://superuser.com/questions/28907/make-window-always-on-top/371052#371052
  ; WinGet, windows, List
  ; Loop, %windows%
  ; {
      ; window := windows%A_Index%
      ; WinSet, AlwaysOnTop, Off, ahk_id %window%
  ; }
  ; WinSet, AlwaysOnTop, On, ahk_class Shell_TrayWnd
Return

; Alt+Control+Shift+p
!^+p::

  WinGetClass, wormsArmageddonWindowClass, Worms Armageddon
  
  ; MsgBox, The Worms Armageddon window's wormsArmageddonWindowClass is "%wormsArmageddonWindowClass%".
  
  ; IfWinExist, ahk_class %wormsArmageddonWindowClass%
  ; {
    ; MsgBox, Yes, the Worms Armageddon window exists (its class is "%wormsArmageddonWindowClass%").
  ; }

  if WinExist("ahk_class Worms2D")
  {
    MsgBox, The Worms Armageddon with ahk_class Worms2D is active
  }  

  ; Worms Armageddon (Worms2D)
  ; if WinExist("ahk_class Worms2D")
  ; if WinExist("ahk_class " . wormsArmageddonWindowClass)
  WinGetClass, wormsArmageddonWindowClass, Worms Armageddon
  IfWinExist, ahk_class %wormsArmageddonWindowClass%
  {
    ShowAltTabMenu()
  }
  Else
  {
    ; ; http://www.autohotkey.com/board/topic/54584-how-to-complie-a-list-of-all-window-names/
    ; WinGet, Window, List
    ; Loop %Window%
    ; {
      ; Id:=Window%A_Index%
      ; WinGetTitle, TVar , % "ahk_id " Id
      ; Window%A_Index%:=TVar ;use this if you want an array
      ; tList.=TVar "`n" ;use this if you just want the list
    ; }
    ; MsgBox %tList%  

    ; http://stackoverflow.com/questions/10740208/autohotkey-get-list-of-windows-with-a-certain-title/10740754#10740754
    ; Example #2: This will visit all windows on the entire system and display info about each of them:
    WinGet, id, list,,, Program Manager
    Loop, %id%
    {
        this_id := id%A_Index%
        WinActivate, ahk_id %this_id%
        WinGetClass, this_class, ahk_id %this_id%
        WinGetTitle, this_title, ahk_id %this_id%
        MsgBox, 4, , Visiting All Windows`n%a_index% of %id%`nahk_id %this_id%`nahk_class %this_class%`n%this_title%`n`nContinue?
        IfMsgBox, NO, break
    }
    
    MsgBox % GetOsVersion()
  }
Return

; Worms Armageddon (Worms2D)
#IfWinActive Worms2D
  ; RCtrl::space
  RWin::space
  ; LShift::F8

;  a::
;    ; ezt meg kiprobalni
;    ; SendInput, {Enter}
;    ; Sleep, 150
;    ; SendInput, {Enter}

;    ; ez nem jo:
;    ;SetKeyDelay, 500
;    ;Send {Enter}
;    ;Send {Enter}

;    ; ez sem jo:
;    ;Send {Enter}
;    ;Sleep 300
;    ;Send {Enter}

;    ; ez nagyjabol mukodik:
;    ; "WA waits for a keyup event before accepting another keydown event"
;    ; "To make both keys work without releasing the other (i.e. "cheating"), the down hotkeys should send {Space up} before {Space down}, and the up hotkeys {Space up}, but only if both keys are released, which can be checked with e.g. a counter variable."
;    ; http://forum.team17.co.uk/showthread.php?t=42995
;    Send {Enter Down}
;    Sleep 30
;    KeyWait Enter
;    Send {Enter Up}
;    Sleep 50
;    Send {Enter Down}
;    Sleep 30
;    KeyWait Enter
;    Send {Enter Up}

;  Return

#IfWinActive

; Worms Armageddon (Worms2D)
#IfWinExist Worms2D
  ; működjön az Alt+Tab akkor is, ha fut a Worms
  ; http://stackoverflow.com/questions/24322534/how-to-close-window-switcher/24325577#24325577

  ; The trick is to create two hotkeys: One that triggers if Window Switcher isn't already opened, and one that triggers if it is. The former "outer" hotkey will wait until CTRL is released and then close Window Switcher. The other "inner" hotkey registers every switch and delegates it.
  ; Ctrl+Win+r
  ; ^#r::
  ; $^#r::
  ; Ctrl+Alt+r
  ; *^!r::
  ^!r::
      ; No need to rely on any shortcut here!
      ShowAltTabMenu()
      ; KeyWait, Control
      ; if(WinActive("ahk_class TaskSwitcherWnd")) {
          ; Send, {Enter}
      ; }
  Return

  ; IfWinActive, ahk_class TaskSwitcherWnd
  ; {
    ; ^#r::
        ; Run, explorer.exe shell:::{3080F90E-D7AD-11D9-BD98-0000947B0257}
    ; Return
  ; }

  ; more shell stuffs:
  ; http://winaero.com/blog/the-most-comprehensive-list-of-shell-locations-in-windows-8/
  ; http://docs.rainmeter.net/tips/launching-windows-special-folders

  WinGetClass, wormsArmageddonWindowClass, Worms Armageddon
  
  IfWinExist, ahk_class %wormsArmageddonWindowClass%
  {
    IfWinNotActive, ahk_class Worms2D
    {
      ; Alt+Tab
      ; !Tab::
      ; *!Tab:: ; https://www.autohotkey.com/docs/Hotkeys.htm
      $!Tab:: ; https://www.autohotkey.com/docs/Hotkeys.htm
          ; Worms Armageddon (Worms2D):
          ; ShowAltTabMenu()
          KeyWait, Alt
          KeyWait, Tab
          ; ; https://www.autohotkey.com/docs/commands/KeyWait.htm
          ; ; D: Wait for the key to be pushed down.
          ; KeyWait, Tab, D
          
          ShowAltTabMenu()
          
      Return    
    }
  }

#IfWinExist ; Worms2D

; Caps Lock opens Alt+Tab menu - just a test
; CapsLock::AltTabMenu

; Worms Armageddon (Worms2D):
#IfWinNotActive, ahk_class Worms2D
; Ctrl+Shift+F7 for activating Notepad++
+^F7::
    StartOrActivateNotepadPlusPlus()
Return

; Ctrl+Shift+F8 for activating Total Commander
+^F8::
    StartOrActivateTotalCommander()
Return

; Ctrl+Shift+Alt+F12 starts Notepad++
; +^!Left::Send  {Volume_Down}
+^!F12::
  ;MsgBox, 0, , Hello F12!
  StartOrActivateNotepadPlusPlus()
Return

;*************************************************************************
; Google Docs stuffs
;*************************************************************************

; https://www.autohotkey.com/docs/Hotkeys.htm
; tilde (~) means "When the hotkey fires, its key's native function will not be blocked (hidden from the system)"
; Ctrl+Shift+F9
~+^F9::
  ; https://www.autohotkey.com/docs/commands/SetTitleMatchMode.htm
  ; 2: A window's title can contain WinTitle anywhere inside it to be a match.
  SetTitleMatchMode 2
  ; IfWinActive, Google Dokumentumok
  ; IfWinActive ahk_group GoogleDocsWindowsGroup
  if(  WinActive("Google Dokumentumok")
    or WinActive("Google Documents")
    or WinActive("Google Docs") )
  {
    ; Send, Yay!

    ; WinGetPos, X, Y, Width, Height
    ; MsgBox, Window is at %X%,%Y%, width: %Width%, height: %Height%, a fele: (%Width%/2)
    ; Click (Width/2), (Height/2) ; Click left mouse button at specified coordinates.

    ; hit an Escape just in case the focus is NOT in the editing area (e.g. we clicked above the menu elements)
    ; - by hitting the Escape, it seems like the focus gets back in the editor area
    SendInput, {Esc}
    ; open fonts
    SendInput, {Alt Down}{Shift Down}{f}{Shift Up}{Alt Up}
    Sleep, 100
    SendInput, {Tab 2}{Right 6}{Enter}{Down 3}
    ; jump to the beginning of the list
    Sleep, 200
    SendInput, {Home}
    ; sorköz egyes legyen (Formázás > Sorköz > Egyes)
    ; SendInput, {Alt Down}{o}{Alt Up}{l}{Enter}
  }
Return

~+^F10::
  ; https://www.autohotkey.com/docs/commands/SetTitleMatchMode.htm
  ; 2: A window's title can contain WinTitle anywhere inside it to be a match.
  SetTitleMatchMode 2
  ; IfWinActive, Google Dokumentumok
  ; IfWinActive ahk_group GoogleDocsWindowsGroup
  if(  WinActive("Google Dokumentumok")
    or WinActive("Google Documents")
    or WinActive("Google Docs") )
  {
    ; hit an Escape just in case the focus is NOT in the editing area (e.g. we clicked above the menu elements)
    ; - by hitting the Escape, it seems like the focus gets back in the editor area
    SendInput, {Esc}
    ; Insert equation
    ; open Insert menu
    SendInput, {Alt Down}{Shift Down}{i}{Shift Up}{Alt Up}
    Sleep, 100
    SendInput, {e}
  }
Return

; Ctrl+Alt+m
^!m::
Send µ
Return

;*************************************************************************

; Ctrl+Shift+Win+t just for testing
~+^#t::
  inputbox myVar, What is your variable?
  myNewVar := TestFunction(myVar)
  MsgBox, %myNewVar%
Return

#IfWinNotActive;, ahk_class Worms2D


; command prompt hotkeys
#IfWinActive ahk_class ConsoleWindowClass

; Ctrl+Shift+c to copy text
+^c::
  ; SendInput, {RButton} ; this only works if QuickEdit is switched on
  ; SendInput, {Alt Down}{Space}{Alt Up}ey ; open system menu > Edit > Copy
  ; to make it work on OSs with other languages:
  SendInput, {Alt Down}{Space}{Alt Up}{Down 6}{Right}{Down}{Enter} ; open system menu > Edit > Copy
Return

; Ctrl+Shift+v to insert text
+^v::
  ; SendInput, {RButton} ; this only works if QuickEdit is switched on
  SendInput, {Alt Down}{Space}{Alt Up}{Down 6}{Right}{Down 2}{Enter} ; open system menu > Edit > Paste
Return

; Ctrl+Shift+a to select all
+^a::
  SendInput, {Alt Down}{Space}{Alt Up}{Down 6}{Right}{Down 3}{Enter} ; open system menu > Edit > Select All
Return

; Alt+F4 to make the exit command work
!F4::
  ; https://www.autohotkey.com/docs/commands/WinClose.htm
  WinClose, A ; close active window
Return

#IfWinActive; ahk_class ConsoleWindowClass

; BS Player is active
#IfWinActive ahk_exe bsplayer.exe

; Alt+s
!s::
  ; download subtitles for the current movie
  
  ; activate the video playing window (not the one with the toolbar)
  WinActivate, ahk_class BSPVideoWindow
  moveCursorToActiveWindowCenter()
  
  ; Wait for both s and Alt to be released.
  KeyWait, Alt    
  KeyWait, s

  ; Subtitles -> Check for subtitles online --> All
  SendInput, {RButton}
  Sleep, 400 ; Wait for menu to drop down
  SendInput, {Down 16}
  SendInput, {Right}
  SendInput, {Down 2}
  SendInput, {Right}
  SendInput, {Up}
  SendInput, {Enter}
  ; Sleep, 500
  ; SendInput, {Click 355, 55}

Return

#IfWinActive; ahk_exe bsplayer.exe

; VLC Player is active
#IfWinActive ahk_exe vlc.exe
; Ctrl+Shift+Alt+s starts VLSub in VLC
; +^!s::
; Alt+s
!s::      
    isFullScreen := isWindowFullScreen("A") ; check if active window is full screen
    
    ; VLSub is not available in full screen mode!
    if(isFullScreen)
    {
      Return
    }
    
    ; Wait for both s and Alt to be released.
    KeyWait, Alt    
    KeyWait, s
    
    ; Press Alt+i (View menu)
    SendInput, {Alt down}{i down}
    SendInput, {i up}{Alt up}
    Sleep, 400 ; Wait for menu to drop down
    SendInput, {Up}
    SendInput, {Enter}
    Sleep, 500
    SendInput, {Click 355, 55}
    
    ; ; ; View->VLSub
    ; ; SendInput, {RButton}
    ; ; Sleep, 400 ; Wait for menu to drop down
    ; ; SendInput, {Down 10}
    ; ; SendInput, {Right}
    ; ; SendInput, {Up}
    ; ; SendInput, {Enter}
    ; ; Sleep, 500
    ; ; SendInput, {Click 355, 55}
    
    ; ; View->VLSub
    ; SendInput, {RButton}
    ; Sleep, 400 ; Wait for menu to drop down
    ; SendInput, i
    ; Sleep, 200 ; Wait for menu to drop down
    ; SendInput, {Up}
    ; SendInput, {Enter}
    ; Sleep, 500
    ; SendInput, {Click 355, 55}

    ;    SendInput, !i ; Alt+i to open View menu. WinMenuSelectItem doesn't work here
;    Sleep, 500 ; Wait for menu to drop down
;    SendInput, {DOWN 9}{ENTER} ; View->VLSub
Return
#IfWinActive; ahk_exe vlc.exe

; Total Commander is active
; http://www.ghisler.ch/wiki/index.php/AutoHotkey
#IfWinActive, ahk_class TTOTAL_CMD
  ;
#IfWinActive; ahk_class TTOTAL_CMD

; Google Chrome OR Opera or any other browser with Blink engine is active
#IfWinActive, ahk_class Chrome_WidgetWin_1
  ;
#IfWinActive; ahk_class Chrome_WidgetWin_1

; Google Chrome is active
#IfWinActive, ahk_exe chrome.exe
  ; Ctrl+Shift+e opens extensions page
  ^+e::
    KeyWait, Ctrl
    KeyWait, Shift
    KeyWait, e
    SendInput, {Alt Down}{f}{Alt Up}
    Sleep, 50 ; Wait for menu to drop down
    SendInput, l
    Sleep, 50 ; Wait for menu to drop down
    SendInput, e{Enter}
  Return
#IfWinActive; ahk_class chrome.exe

; CS:GO is active
#IfWinActive, ahk_exe csgo.exe
; if WinExist("ahk_class Valve001") ;TF2
; {
; }
    
    ; http://www.pcgamer.com/how-to-disable-the-windows-key/
    ; Disable Windows key not to accidentally iconize the program while in-game
    ~LWin Up:: return
    ~RWin Up:: return

#IfWinActive; ahk_exe csgo.exe

; *************************************************************************
; *************************************************************************
; http://stackoverflow.com/questions/98597/best-autohotkey-macros/100648#100648
; *************************************************************************
; *************************************************************************

SetTitleMatchMode RegEx ;
; Stuff to do when Windows Explorer is open
;
; #IfWinActive ahk_class ExploreWClass|CabinetWClass
#IfWinActive ahk_class CabinetWClass
    ; create new folder
    ; Alt+n
    ; ^!n::
    !n::
      ; SendInput !fw{Right}f
      SendInput, {Alt Down}{f}{Alt Up}{w}{Right}{f}
    Return

    ; create new text file
    ; Alt+t
    ; ^!t::
    !t::
      SendInput !fw{Right}t
    Return

    ; open 'cmd' in the current directory
    ; Alt+c
    ; ^!c::
    !c::
        OpenCmdInCurrent()
    Return
    
    ; http://www.howtogeek.com/howto/8955/make-backspace-in-windows-7-or-vista-explorer-go-up-like-xp-did/
    ; "If you want to go Up a folder in either Windows 7 or Vista, you can use the Alt+Up shortcut key, which will always go to the parent folder."
    ; Make Backspace go Up one folder
    Backspace::
      ; checking the status of the controls, and then depending on whether they are focused or you are in the process of renaming a file, it either sends the alternate Alt+Up or just sends the regular Backspace key
      ControlGet renamestatus,Visible,,Edit1,A
      ControlGetFocus focussed, A
      ; you have to check to see which control is active before sending the alternate Alt+Up key combination
      if( renamestatus!=1 && (focussed=”DirectUIHWND3″||focussed=SysTreeView321) )
      {
        SendInput {Alt Down}{Up}{Alt Up}
      }
      else
      {
        Send {Backspace}
      }
    Return
    
    ; http://www.howtogeek.com/howto/keyboard-ninja/keyboard-ninja-toggle-hidden-files-with-a-shortcut-key-in-windows/
    ; WINDOWS KEY + H TOGGLES HIDDEN FILES 
    #h:: 
      RegRead, HiddenFiles_Status, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden 
      
      If HiddenFiles_Status = 2
      {
        RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden, 1 
      }
      Else
      {
        RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden, 2 
      }
      WinGetClass, eh_Class,A 
      ; If (eh_Class = "#32770" OR A_OSVersion = "WIN_VISTA" OR A_OSVersion = "WIN_7")
      If (IsVistaPlus())
      {
        send, {F5} 
      }
      Else
      {
        PostMessage, 0x111, 28931,,, A 
      }
    Return    
#IfWinActive; ahk_class CabinetWClass

; Opens the command shell 'cmd' in the directory browsed in Explorer.
; Note: expecting to be run when the active window is Explorer.
;
OpenCmdInCurrent()
{
    WinGetText, full_path, A  ; This is required to get the full path of the file from the address bar

    ; Split on newline (`n)
    StringSplit, word_array, full_path, `n
    full_path = %word_array1%   ; Take the first element from the array

    ; Just in case - remove all carriage returns (`r)
    StringReplace, full_path, full_path, `r, , all
    full_path := RegExReplace(full_path, "^Address: ", "") ;

    IfInString full_path, \
    {
        Run, cmd /K cd /D "%full_path%"
    }
    else
    {
        Run, cmd /K cd /D "C:\ "
    }
}

; http://www.autohotkey.com/board/topic/35532-how-to-detect-new-os-windows-7/
; https://www.autohotkey.com/docs/Variables.htm#os
; *****************************************************************************
; Get version of Windows operating system
; Output:
;    XP-32|XP-64|Vista-32|Vista-64|Win7-32|Win7-64|UNKNOWN
; *****************************************************************************
GetOsVersion()
{
; Values of A_OSType and A_OSVersion
;              XP32       XP64      Vista32     Vista64    Win7 32    Win7 64
;--------------------------------------------------------------------------------
; A_OSType     WIN32_NT   WIN32_NT  WIN32_NT    WIN32_NT   WIN32_NT   WIN32_NT
; A_OSVersion  WIN_XP     WIN_2003  WIN_VISTA   WIN_VISTA  WIN_VISTA  WIN_VISTA

  If (A_OSType != "WIN32_NT")
    Return "UNKNOWN (A_OSType was not equal to WIN32_NT)" ; We don't support other OS types.

  osVersion := ""
    
  If (A_OSVersion == "WIN_XP")
    ; Return "XP-32"
    osVersion = "XP-32"
  Else If (A_OSVersion == "WIN_2003")
    osVersion = "XP-64"
  Else If (A_OSVersion == "WIN_VISTA")
  {
    ; This could be either Vista or Windows 7
    ; (???)
    ; winType := "Vista"
    
    osVersion := "Vista"
    
    RegRead, winName, HKEY_LOCAL_MACHINE, SOFTWARE\Microsoft\Windows NT\CurrentVersion, ProductName
    If ErrorLevel = 0
    {
      ; Example: 'Windows 7 Home Premium'
      posFound := RegExMatch(winName, "^Windows 7")
      If posFound
        ; winType := "Win7"
        osVersion := winName . " (Win7)"
    }
    
    ; For Vista and Win7 we have to check if there is the directory SysWOW64
    ; exists in the Windows installation folder.
    IfExist, %A_WinDir%\SysWOW64
      ; Return winType "-64"
      osVersion := osVersion . " x64"
    Else
      ; Return winType "-32"
      osVersion := osVersion . " x86"
  }
  ; mod by Pete
  Else If (A_OSVersion == "WIN_7")
  {
    RegRead, winName, HKEY_LOCAL_MACHINE, SOFTWARE\Microsoft\Windows NT\CurrentVersion, ProductName

    osVersion := winName
    
    IfExist, %A_WinDir%\SysWOW64
      ; Return A_OSVersion "-64"
      osVersion := osVersion . " (x64)"
    Else
      ; Return A_OSVersion "-32"
      osVersion := osVersion . " x86"
  }
  
  If (osVersion == "")
  {
    osVersion = "UNKNOWN"
  }
  
  ; MsgBox, A_OSType: %A_OSType%`nA_OSVersion: %A_OSVersion%`nosVersion: %osVersion%
  
  Return, "A_OSType: " . A_OSType . "`nA_OSVersion: " . A_OSVersion . "`nosVersion: " . osVersion . "`nVersion number: " . GetOSVersionZZZ() . "`nIsVistaPlus(): " . IsVistaPlus()
}

; http://www.autohotkey.com/board/topic/45336-windows-7-a-osversion-win-vista/?p=299595
GetOSVersionZZZ()
{
    VarSetCapacity(v,148), NumPut(148,v)
    DllCall("GetVersionEx", "uint", &v)
    ; Return formatted version string similar to A_AhkVersion.
    ; Assume build number will never be more than 4 characters.
    return    NumGet(v,4) ; major
        . "." NumGet(v,8) ; minor
        . "." SubStr("0000" NumGet(v,12), -3) ; build
}

IsVistaPlus() {
   Return ((DllCall("GetVersion") & 0xFF) > 5)
}

; http://superuser.com/questions/242730/autohotkey-how-to-pass-evaluate-parameters-to-functions/351589#351589
TestFunction(arg)
{
    if (arg = "calc")
    {
      run, calc.exe
    }
    else if (arg = "word")
    {
      run, winword.exe
    }
    MsgBox, %arg%
    return arg . "bob"
}

; Starting/activating Total Commander
StartOrActivateTotalCommander()
{
  IfWinExist ahk_class TTOTAL_CMD
    WinActivate ; use the window found above
  Else
    Run "D:\Programs\Total_Commander\TOTALCMD64.EXE"
}

; Starting/activating Notepad++
StartOrActivateNotepadPlusPlus()
{
  IfWinExist ahk_class Notepad++
    WinActivate ; use the window found above
  Else
    ;Run "d:\Programs\Notepad++\notepad++.exe"
    Run, notepad++.exe
}

ShowAltTabMenu()
{
  Run, explorer.exe shell:::{3080F90E-D7AD-11D9-BD98-0000947B0257}
}

;************************************************************************************
; Check if window is in full screen mode
; http://www.autohotkey.com/board/topic/38882-detect-fullscreen-application/?p=275899
;************************************************************************************
isWindowFullScreen( winTitle ) {
	;checks if the specified window is full screen
	
	winID := WinExist( winTitle )

	If ( !winID )
		Return false

	WinGet style, Style, ahk_id %WinID%
	WinGetPos ,,,winW,winH, %winTitle%
	; 0x800000 is WS_BORDER.
	; 0x20000000 is WS_MINIMIZE.
	; no border and not minimized
	Return ((style & 0x20800000) or winH < A_ScreenHeight or winW < A_ScreenWidth) ? false : true
}

moveCursorToActiveWindowCenter() {

  WinGetPos, X, Y, Width, Height, A
  WinGetActiveStats, WTitle, WWidth, WHeight, WX, WY

  XHalf := X/2
  YHalf := Y/2
  WindowHalfWidth := Width/2
  WindowHalfHeight := Height/2
  MouseNewX := X+WindowHalfWidth
  MouseNewY := Y+WindowHalfHeight

  ; SetDefaultMouseSpeed, 100
  ; SendEvent {Click 100, 200, 0} ; To move the mouse without clicking, specify 0 after the coordinates
  ; MsgBox, A is at x: %X%`, y: %Y%, XHalf: %XHalf%, YHalf: %YHalf%, width: %Width%, height: %Height%, half width: %WindowHalfWidth%, half height: %WindowHalfHeight%, MouseNewX: %MouseNewX%, MouseNewY: %MouseNewY%, WTitle: %WTitle%, WWidth: %WWidth%, WHeight: %WHeight%, WX: %WX%, WY: %WY%
  ; MouseMove, MouseNewX, MouseNewY, 5
  
  ; Move mouse cursor to the center of the screen
  ; Coordinates are RELATIVE to the active window unless CoordMode was used to change that
  MouseMove, WindowHalfWidth, WindowHalfHeight, 0  
}