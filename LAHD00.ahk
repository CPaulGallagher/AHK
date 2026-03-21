#SingleInstance force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
SetTitleMatchMode, Slow
DetectHiddenText, Off
SetKeyDelay, 10

#w::
WinGet, id, List,,, Program Manager
Loop, %id%
{ ; START LOOP ********
    this_id := id%A_Index%
    WinActivate, ahk_id %this_id%
    WinGetClass, this_class, ahk_id %this_id%
    WinGetTitle, this_title, ahk_id %this_id%
    MsgBox, 4, , Visiting All Windows`n%A_Index% of %id%`nahk_id %this_id%`nahk_class %this_class%`n%this_title%`n`nContinue?
    IfMsgBox, NO, break
} ; END Loop *******
Return

#q:: ; This will return the name of the object under the Cursor 
{
	
}
Return
#b:: ; This will place a button on the screen to pull up the HemoDetailLine menu screen.
{
	
}
Return


#1::
; Win+1 to enter the patients name
; Alt+M y This Medical>HemodialYsis>Thorne
InputBox, mName, Name, "Enter patient Name: ", 	
	Send,!m
	Send, y
	Send, {Enter}
	Sleep 2500	
	Send, %mName%
	Sleep 1500
	Send, {Enter}
	Sleep 1600
	Send, {Enter}

   Return

#2::
; Windows + 2 To enter Date on 1st Screen
	Send, .{Enter}{Tab}{Tab}{Tab}
	Return
#3::
; Windows + 3 after Arrive time entry
	Send, {Tab}assist ; sets to Staff assisted
	Sleep 400
;	Send, {Tab}{space} ;sets isolation
	Send, {Tab 7} ; advance to Ambulation
	Send, walker{Enter} ; Walker
   Return