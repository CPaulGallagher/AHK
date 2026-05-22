;*** Shortcuts for LAHD MIQS 

#SingleInstance force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
SetTitleMatchMode, Slow
DetectHiddenText, Off
SetKeyDelay, 10

; GoSub LoadWindow

*/
; *** Set initial Vars at start of script
mUserToggle := False
mLeft :=  "{Left}"
mTAB := "{Tab}"
mEnter := "{Enter}"
mSpace := " "
mPrime := 400
mRinse := mPrime/2
mPrime := mPrime/1000
mCOVID := "Negative Screening for COVID-19 completed on arrival."
mCNRounds :=  "Charge Nurse Rounds completed. Bath, Dialyzer, prescription, goal and IV checked and verified. Machine and lines check complete. Patient has no complaints access site visible, lines connected and secure."
mCNR0UF :="Charge Nurse Rounds completed. Bath, Dialyzer, prescription, goal and IV checked and verified. Machine and lines check complete. Patient has no complaints access site visible, lines connected and secure. Minimum UFR with no replacement unless needed per MD order."
mTxvar := "Arrived Kg over EDW. Left Kg over EDW."
mQ30 := "Patient has no complaints. "
mLap := "Patient using laptop. "
mPC := "Patient is using computer. "
mCell := "Patient using cell phone. "
mTV := "Patient watching TV. "
mEyes := "Patient resting with eyes closed. "
mRest :="Patient resting. "
mRead :="Patient is currently reading. "
PtResponseArray := [] ; initalizes Array
PtResponseArray := [ "Patient using laptop. ", "Patient is using computer. ","Patient using cell phone. ","Patient watching TV. ", "Patient resting with eyes closed. ",  "Patient resting. ", "Patient is currently reading. "]
mRecliner := "Sitting in recliner. "
mBedSitting := "Sitting up in bed. "
mPosition := 
mLUF := "L UF. "
mFeetUp := "Feet elevated. "
mFeetDown := "Feet down. "
mFeetNo := ""
mModeToggle := !true
mFeet := mFeetNo
mMachineChecks1 := "Tolerating treatment well. Respirations regular. " 
mMachineChecks2 := "Face and access visualized and lines secure. Machine and lines checked. Transducers clean and dry blue scissor clamps in place. " 
mMachineChecks := mMachineChecks1 . mPosition . mMachineChecks2
mOver := "mL Maximum UF leaves patient over EDW by Kg. Education on limiting fluids reinforced."
mHDLineComment := "" ; should make this global var
mformula := "=ROUNDUP(F8-(O8/60 *G8*13/1000),1)"
mNStart1 := " Donned Full PPE. Access care complete no signs/symptoms infection. Positive Bruit and "
mNStart2 := "Thrill. Access cleaned with Alcohol preps, using aseptic technique, cannulated two sites without difficulty. Treatment initiated without problems. Saline line double clamped. " 
mNStart := " Donned Full PPE. Access care complete no signs/symptoms infection. Positive Bruit and Thrill. Access cleaned with Alcohol preps, using aseptic technique, cannulated two sites without difficulty. Treatment initiated without problems. Saline line double clamped. " 
mNend := "PPE Donned. Dialysis treatment ended, blood returned. Patient used hand Sanitizer. Removed needles x 2 and pressure held by patient until bleeding stopped.  Applied new dry sterile dressing to each site. Thrill and Bruit present. "
mCStart := " Patient and Nurse masked. Nurse full PPE. Using aseptic technique, ports aspirated and flushed.  Cath Care done per protocol, Saline line clamped with blue scissor clamp. Lines secured. Catheter access and Treatment initiated by nurse without problems. " 
mCEnd := "Patient and Nurse masked. Nurse full PPE. Dialysis treatment ended, blood returned. Flushed both ports with 10cc Normal Saline and Heparin packed per protocol Ports clamped and capped. Cath Care done per protocol. Cath access completed by nurse. " 
mPreAssessment := " Negative Screening for COVID-19 completed on arrival. Denies new signs or symptoms of a respiratory infection, such as a fever, cough, or sore throat. No falls or other issues since last treatment. " 
mPostAssessment := " Access dressing clean, dry, and intact. Patient shows no signs or symptoms of discomfort at this time. Patient discharged in care of self with spouse and other family present to assist. "

FormatTime, mTime,, HH:mm ; A_Hour A_Min If blank or omitted, it defaults to the current local date and time
mSBP := "105"
mDBP := "50"
mHR  := "68"
mQb := "400"
mQd := "800"
mArt := "-200"	 
mVen := "200"
mUFR := 0
mTMP := "20"
mTemp := "37"
mCond := "14.1"
mUF := 0
FormatTime, mDate,, MM/dd/yyyy ; "10/08/2025"
; mTime := "1540"
mHepPumpRate := 0
mHepPumpVol := 0

mHDline1 := mTime . mTAB . mSBP . "/" . mDBP . mTAB . mTAB .mTAB . mHR . mTAB . mTAB 
mHDline2 := mQb . mTAB . mQd . mTAB . mArt . mTAB . mVen . mTAB . mUFR . mTAB . mTMP . mTAB . mCond . mTAB . mTAB . mTAB . mTAB . mUF
mHDline := mHDline1 . mHDline2

; Subroutines are placed at bottom of Code to prevent execution before called
GoSub, CVEventLine ; (mDate , mTimeHr , mTimeMin , mSBP , mDBP , mHR , mUFR , mUF , mQb , mQd , mArt , mVen , mTMP , mCond)	

SetControlDelay, 900
 
   mUser1 :="Paul.G"
   mPsw1 := "PG"
   mUPSW1 := "Renal3.141592"
   mWUsr1 := "cgallagher"
   mWPsw1 := "Renal3.141592"

   mUser2 :="Paul.2" 
   mPsw2 := "PG"
   mUPSW2 := "Renal3.141592"
   mWUsr2 := "cgallagher"
   mWPsw2 := "Renal3.141592"

   mUser:= mUser1
   mPsw := mPsw1
   mUPSW := mUPSW1
   mWPsw := mWPsw1


; Gosub, Password

GoSub LoadWindow


/* **************** Block comment on ********************
*/ ; *********** Block comment off **********************
#x:: 
    {
    GoTo Exit
    }
   Return
*/ ; *********** Block comment off **********************
GuiClose1:
gHDLineButtonOK:
    {
    Gui, Submit  ; Save the input from the user to each control's associated variable.
	; mUFR = mUFR + 0.0
	; mUF = mUF + 0.0 
	; mUFR = ((mUFR + 0.0)/1000)
	; mUF = ((mUF + 0.0)/1000)
   GoSub, MIQSEventLine ; Created SubRoutine to handle transmit to MIQS
   GoSub, CVEventLine ; (mDate , mTimeHr , mTimeMin , mSBP , mDBP , mHR , mUFR , mUF , mQb , mQd , mArt , mVen , mTMP , mCond)
   GoSub SendHDEvent
Return
    }
Exit:
	{
	ExitApp
	Return
	}
Return

#h::
ShowgHDL:

	; Show the GUI to enter data from HDLine
	Gui gHDLine:Show, xCenter y5 w900 h300,  Hemodialysis Data Entry              %mUser% 
;  CenterWindow("HD Line Data")
	Return

CenterWindow(WinTitle)
{
    WinGetPos,,, Width, Height, %WinTitle%
    WinMove, %WinTitle%,, (A_ScreenWidth/2)-(Width/2), 5
}

^h::
   SendHDEvent:
	; send data from HDLine to CV note
	mMachineChecks := mMachineChecks1 . mPosition . mMachineChecks2
   	Send, %mHDCVline% ; send to CV
      Send, %mHDLineComment%
      mHDLineComment := ""
Return

Target:
     Send, In target.
   Return

:*:covd::
	Send, %mCOVID%
   Return


!q::
   Send, %mUPSW%{enter}
   Return
^q::
   Send,%mPsw%{enter}
   Return 
F9::
  Send,%mWUsr2%{Tab}
  Send,%mWPsw2%
  Send,{enter}    
   Return

^5::
   MouseGetPos, mOutputVarX, mOutputVarY, mOutputVarWin, mOutputVarControl
   mx := "x".mOutputVarX
   my := "y".mOutputVarY
   MsgBox,x,%mOutputVarX%,y,%mOutputVarY%, %mOutputVarControl%
   Return

:*:psw::
Password:
   Splashtextoff
   InputBox, mUser, User, Enter Username,,100,120
   InputBox, mPsw, PIN, %mUser% enter PIN, HIDE, 140, 140
   InputBox, mUPSW, Password, %mUser% enter Password, HIDE, 140, 140
   If mUserToggle
     {
     mUser2:= mUser
     mPsw2 := mPsw
     mUPSW2 := mUPSW
     }
    Else
     {
     mUser1 := mUser ; User to Splash
     mPsw1 := mPsw ; User PIN currently my inits
     mUPSW1 := mUPSW ; User Password
     }
   IF mUser = 
      mUser := "  "
   SplashTextOn, , , %mUser% 
   WinMove, %mUser%,, A_ScreenWidth-110, A_ScreenHeight-65  ; Move the splash window to the Bottom Right corner.
   Return

; Splash off
^k::
   Splashtextoff
   Return

;Switch the current psw.
^j::
   Splashtextoff
   mUserToggle := !mUserToggle
   If mUserToggle
     {
     mUser:= mUser2
     mPsw := mPsw2
     mUPSW := mUPSW2
     }
    Else
     {
     mUser:= mUser1
     mPsw := mPsw1
     mUPSW := mUPSW1
     }
   IF mUser = 
      mUser := "  "
   SplashTextOn, , , %mUser% 
   WinMove, %mUser%,, A_ScreenWidth-100, A_ScreenHeight-80  ; Move the splash window to the Bottom Right corner.
Return

F3:: ; Cntl+t or F3 does pre  assessment entries.  
^t::
PreAssessment:	
	Send, %mPreAssessment%
	Return

; post assessment
F4::
#p::
PostAssessment:
	Send, %mPostAssessment%
   Return

^g::
   Send,%mOver%{Left 44}
   Return
; Cntl+R does standard rounds cnr0 does rounds for no Weight
^r::
;   WinGetActiveTitle, mTitle
;   WinMove,%mTitle%,,0,0 
   Send, {space}%mCNRounds%{space}
   Return
#t::Send, In target.
:*:mnnt::
   Send, In target.
   Return
:*:fbrd::
   Send, Mineral Metabolism and Nutrition followed by RD.
   Return
:*:pmdo::
   Send, per MD order.
   Return
:*:ptas::
   Send, patient asymptomatic.{space}
   Return
:*:cnr0::
   WinGetActiveTitle, mTitle
   WinMove,%mTitle%,,0,0 
   Send, {space}%mCNR0UF%{space}
   Return
^.::
   Send,Kg over{space}Target Weight.
   Return

:*:hhtn::
   Send,HTN Pre HD will monitor. 
   Return
:*:phtn:: 
   Send,Rebound HTN post HD rinse back. Refused further treatment at this time. Patient takes antihypertensive medications at home. 
   Return
:*:rhtn:: 
   Send,History of hypotension if takes Clonidine on treatment. Refuses antihypertensive medications with HD. 
   Send,HTN post HD rinse back. Refused further treatment at this time. Patient takes antihypertensive medications at home. 
   Return
:*:uhtn:: 
   Send,History of no improvement of HTN after taking Clonidine on treatment. Refuses antihypertensive medications with HD. 
   Send,HTN post HD rinse back. Refused further treatment at this time. Patient takes antihypertensive medications at home.
   Return
:*:adca::
   Send,Admit ambulatory with cane.
   Return
:*:adwa:: 
   Send,Admit ambulatory with walker.
   Return
:*:dcwa::
   Send,Discharged ambulatory with walker.
   Return
:*:dcca::
   Send,Discharged ambulatory with cane.
   Return
:*:dcs::
   Send,Discharged via stretcher.
   Return
:*:dcwx:: 
   Send,Discharged via wheelchair.
   Return
:*:adwc::
   Send,Admitted via wheelchair.
   Return
:*:q30::
   Send,%mQ30%
   Send,%mMachineChecks%
   Return

; Response Choices *************************
; Generic Response uses array PtResponseArray[Key]

/* **************** Block comment on ********************
; 1 "Patient using laptop. "
; 2 "Patient is using computer. "
; 3 "Patient using cell phone. 
; 4 "Patient watching TV. "
; 5 "Patient resting with eyes closed. "
; 6 "Patient resting. "
; 7 "Patient is currently reading. "

  6 Menu, PatientResponseMenu, Add, Resting, Resting
  4 Menu, PatientResponseMenu, Add, Watching TV, TV
  5 Menu, PatientResponseMenu, Add, Eyes Closed, Eyes
  1 Menu, PatientResponseMenu, Add, Using Laptop, Laptop
  2 Menu, PatientResponseMenu, Add, Using PC, PC
  7 Menu, PatientResponseMenu, Add, Reading, Reading
  3 Menu, PatientResponseMenu, Add, Using cell phone, Cell
   Menu, PatientResponseMenu, Add  ; Separater line
  8 Menu, PatientResponseMenu, Add, Start with CVC, CStart
  9 Menu, PatientResponseMenu, Add, Start with Needles, NStart
   Menu, PatientResponseMenu, Add  ; Separater line
  10 Menu, PatientResponseMenu, Add, End with CVC, CEnd
  11 Menu, PatientResponseMenu, Add, End with Needles, NEnd

PtResponse:
If  %A_ThisMenuItem% = "Using Laptop"
   Key := 1
Else If
   Case 'Using Laptop": Key := 1
   GuiControlGet, mTime,, Edit1 ; Get the current value of the input
   GuiControlGet, mUF,, Edit11 ; Get the current value of the input
   ControlFocus, Edit14
   mHDComment :=  mTime mSpace PtResponseArray[Key] mMachineChecks mUF mLUF mPsw
   ControlSetText, Edit14, %mHDComment%

Return
*/ ; *********** Block comment off **********************

:*:ql:: ; Using Laptop
Laptop:
   GuiControlGet, mTime,, Edit1 ; Get the current value of the input
   GuiControlGet, mUF,, Edit11 ; Get the current value of the input
   ControlFocus, Edit14
   mHDComment :=  mTime mSpace PtResponseArray[1] mMachineChecks mUF mLUF mPsw
   ControlSetText, Edit14, %mHDComment%

Return

:*:qtv:: ; Watching TV
TV:
   GuiControlGet, mTime,, Edit1 ; Get the current value of the input
   GuiControlGet, mUF,, Edit11 ; Get the current value of the input
   ControlFocus, Edit14
   mHDComment :=  mTime mSpace PtResponseArray[4] mMachineChecks mUF mLUF mPsw
   ControlSetText, Edit14, %mHDComment%

Return

:*:qey:: ; Eyes closed
Eyes:
   GuiControlGet, mTime,, Edit1 ; Get the current value of the input
   GuiControlGet, mUF,, Edit11 ; Get the current value of the input
   ControlFocus, Edit14
   mHDComment :=  mTime mSpace PtResponseArray[5] mMachineChecks mUF mLUF mPsw
   ControlSetText, Edit14, %mHDComment%

Return

:*:qrest:: ; Resting
Resting:
   GuiControlGet, mTime,, Edit1 ; Get the current value of the input
   GuiControlGet, mUF,, Edit11 ; Get the current value of the input
   ControlFocus, Edit14
   mHDComment :=  mTime mSpace PtResponseArray[6] mMachineChecks mUF mLUF mPsw
   ControlSetText, Edit14, %mHDComment%

Return

:*:qpc:: ; using PC
PC:
   GuiControlGet, mTime,, Edit1 ; Get the current value of the input
   GuiControlGet, mUF,, Edit11 ; Get the current value of the input
   ControlFocus, Edit14
   mHDComment :=  mTime mSpace PtResponseArray[2] mMachineChecks mUF mLUF mPsw
   ControlSetText, Edit14, %mHDComment%

Return

:*:qread:: ; Reading
Reading:
   GuiControlGet, mTime,, Edit1 ; Get the current value of the input
   GuiControlGet, mUF,, Edit11 ; Get the current value of the input
   ControlFocus, Edit14
   mHDComment :=  mTime mSpace PtResponseArray[7] mMachineChecks mUF mLUF mPsw
   ControlSetText, Edit14, %mHDComment%

Return

:*:qce:: ; Using cell phone
Cell:
   GuiControlGet, mTime,, Edit1 ; Get the current value of the input
   GuiControlGet, mUF,, Edit11 ; Get the current value of the input
   ControlFocus, Edit14
   mHDComment :=  mTime mSpace PtResponseArray[3] mMachineChecks mUF mLUF mPsw
   ControlSetText, Edit14, %mHDComment%
/* **************** Block comment on ********************
*/ ; *********** Block comment off **********************
   
Return

^w::
   Send,Kg over Target Weight after treatment.{space}
   Send, Cautioned to limit fluid intake. Advised to go to ER if chest pain or shortness of breath develops. Offered extra treatment patient agreed declined.
Return

:*:cstart::
CStart:
;    Sleep 900
   GuiControlGet, mTime,, Edit1 ; Get the current value of the input
   GuiControlGet, mUF,, Edit11 ; Get the current value of the input
   ControlFocus, Edit14
   mHDComment :=  mTime mSpace mCStart mPsw
   ControlSetText, Edit14, %mHDComment%

Return

:*:cend::
CEnd:
;   Sleep 900
   GuiControlGet, mTime,, Edit1 ; Get the current value of the input
   GuiControlGet, mUF,, Edit11 ; Get the current value of the input
   ControlFocus, Edit14
   mHDComment :=  mTime mSpace mCEnd mPsw
   ControlSetText, Edit14, %mHDComment%  
 
   Return

:*:nstart::
#n::
NStart:
;   Sleep 800
   GuiControlGet, mTime,, Edit1 ; Get the current value of the input
   GuiControlGet, mUF,, Edit11 ; Get the current value of the input
   ControlFocus, Edit14
   mHDComment :=  mTime mSpace mNStart mPsw
   ControlSetText, Edit14, %mHDComment%  

   Return

:*:nend::
NEnd:
   ; Sleep 900
   GuiControlGet, mTime,, Edit1 ; Get the current value of the input
   GuiControlGet, mUF,, Edit11 ; Get the current value of the input
   ControlFocus, Edit14
   mHDComment :=  mTime mSpace mNend mPsw
   ControlSetText, Edit14, %mHDComment%  
  
   Return

:*:obr::
   Send,Patient requested off to bathroom. Pt and Nurse masked, blood returned. Flushed ports with 10cc Normal Saline clamped. Cath access completed by nurse.
   Return
:*:rbr::
    Sleep 900
    Send, %mTime%{Space}
    Send, Returned from restroom. Saline line clamped with blue scissor clamp. Lines secured with HemoSafe Clip. Catheter access and Treatment resumed by nurse without problems.
    Send, % mPsw . mEnter
    Return
:*:mpn::
   Send, Patient tolerating treatments at current dialysis prescription. No issues at this time.
   Return

RD:
    Send, Mineral Metabolism and Nutrition followed by RD
   Return
Vol:
     Send, Attains estimated dry weight and completes dialysis treatment. No missed treatment this month.
   Return

Position:
	mPosition := A_ThisMenuItem . ". "
	mMachineChecks := mMachineChecks1 . mPosition . mMachineChecks2
   ControlSetText, Static18, %mPosition%
   mModeToggle := true
; SplashTextOn, , , %mPosition% . "     " . %mUser%
;	WinMove, %mPosition%,, A_ScreenWidth-220, A_ScreenHeight-60  ; Move the splash window to the Bottom Right corner.
  	
   Return
VascCVC:
     Send,CVC has no issues at this time. Working on AV access with Vascular Surgeon.
   Return
Adequacy:
	Send,Has met adequacy goals at current prescription this month.
   Return
Anemia:
	Send,Managed through anemia protocol and per MD's order. ESA on hold. Maintenance Iron.
   Return
Hospitalization:
	Send,Educated patient on the importance of adhering to her scheduled treatment days. Encouraged patient to reschedule if unable to come on treatment days. No missed treatments this month.
   Return
AV_Access:
	Send,No problems noted with current HD access.
   Return
AnemiaManagement:
	Send,{Alt}{Right}{Down}{Down}{Down}{Down}{Down}{Down}{Down}{Down}{Down}{Down}{Down}{Down}{Down}{Down}{Down}{Down}{Down}{Enter}
   Return

PatientResponseMenuShow:
#z:: ; Show the Menu PatientResponseMenu
 
	Menu, PatientResponseMenu, Show
;	SplashTextOn, , , %mPosition% 
;	WinMove, %mPosition%,, A_ScreenWidth-420, A_ScreenHeight-80  ; Move the splash window to the Bottom Right corner.

	Return

#f::
   Send,%mformula%
   Return

GoTo, ShowgHDL ; For Design purpose auto load this screen **********************************   
; ************ Subroutines follow ***************
; function to create the CV Line
CVEventLine: ; Converted Fcn to GoTo (mDate , mTimeHr , mTimeMin , mSBP , mDBP , mHR , mUFR , mUF , mQb , mQd , mArt , mVen , mTMP , mTemp , mCond)
{
   ; Block of code to execute when CVEventLine is called
   StringLeft, mTimeHr , mTime, 2
   StringRight, mTimeMin, mTime, 2
   mHDCVline1 := mDate . mTAB . mTimeHr . mTAB . mTimeMin  . mTAB . "i" . mEnter . mTAB . mTAB . mTAB . mTAB . mSBP . "/" . mDBP . mTAB . mHR . mTAB . mTAB . mTAB . mTAB . mTAB
   mHDCVline2 := mUFR . mTAB . mUF . mTAB . mTAB . mQb . mTAB . mQd . mTAB . mArt . mTAB . mVen . mTAB . mHepPumpRate . mTAB . mHepPumpVol . mTAB . mTMP . mTAB . mTAB . mTAB . mTAB . mTAB . mTAB . mTAB . mTemp . mTAB . mCond . mTAB . mTAB . mTAB 
   mHDCVline := mHDCVline1 . mHDCVline2
}
Return ; mHDCVLine
MIQSEventLine: ; SubRoutine that combines the HDLineData into a string
{
    mHDline1 := mTime . mTAB . mTAB . mTAB . mSBP . "/" . mDBP . mTAB . mTAB . mTAB . mTAB . mHR . mTAB . mTAB
    mHDline2 := mQb . mTAB . mQd . mTAB . mArt . mTAB . mVen . mTAB . mUFR . mTAB . mTMP . mTAB . mCond . mTAB . mTAB . mTAB . mUF
    mHDline := mHDline1 . mHDline2
}
Return ; MIQSEventLine
Loadwindow:
{
{
/* Comment out this section and use Insert Text
*/ ; End of Comment out ******************************************************************

; Gui Window Text Lables Load up
   Gui gHDLine:Font, s10 w600, Georgia
   Gui gHDLine:Add, Text,   x2  y1 w55 h23 +0x200 +Center  +E0x200, Time 
   Gui gHDLine:Add, Text,  x63  y1 w55 h23 +0x200 +Center  +E0x200, SBP  ; 02
   Gui gHDLine:Add, Text, x124  y1 w55 h23 +0x200 +Center  +E0x200, DBP  ; 03
   Gui gHDLine:Add, Text, x184  y1 w55 h23 +0x200 +Center  +E0x200, HR   ; 04
   Gui gHDLine:Add, Text, x243  y1 w55 h23 +0x200 +Center  +E0x200, BFR  ; 05
   Gui gHDLine:Add, Text, x299  y1 w55 h23 +0x200 +Center  +E0x200, DFR  ; 06
   Gui gHDLine:Add, Text, x356  y1 w55 h23 +0x200 +Center  +E0x200, Art  ; 07
   Gui gHDLine:Add, Text, x413  y1 w55 h23 +0x200 +Center  +E0x200, Ven  ; 08
   Gui gHDLine:Add, Text, x470  y1 w55 h23 +0x200 +Center  +E0x200, TMP  ; 09 
   Gui gHDLine:Add, Text, x527  y1 w55 h23 +0x200 +Center  +E0x200, UFR  ; 10 
   Gui gHDLine:Add, Text, x583  y1 w55 h23 +0x200 +Center  +E0x200, UF   ; 11 change to UF
   Gui gHDLine:Add, Text, x639  y1 w55 h23 +0x200 +Center  +E0x200, Temp ; 12 Temp
   Gui gHDLine:Add, Text, x696  y1 w55 h23 +0x200 +Center  +E0x200, Cond  ; 13 Cond
   Gui gHDLine:Add, Text,   x27 y60 w100 h23 +0x200 +Center  +E0x200, Tx Date
   Gui gHDLine:Add, Text, x310  y60 w55 h23 +0x200 +Center  +E0x200, Rate
   Gui gHDLine:Add, Text, x380  y60 w65 h23 +0x200 +Center  +E0x200, Volume
   Gui gHDLine:Add, Text, x299  y100 w155 h23 +0x200 +Center  +E0x200, Heparin Pump
   Gui gHDLine:Add, Text, vStatus x499  y100 w355 h23 +0x200   +E0x200, %mPosition%

; Gui Data entry 
   Gui gHDLine:Add, Edit, vmTime    x7 y25 w50 h21         +Center,  %mTime%  ; 01
   Gui gHDLine:Add, Edit, vmSBP    x67 y25 w50 h21 +Number +Center,  %mSBP%   ; 02 
   Gui gHDLine:Add, Edit, vmDBP   x127 y25 w50 h21 +Number +Center,  %mDBP%   ; 03 
   Gui gHDLine:Add, Edit, vmHR    x188 y25 w50 h21 +Number +Center,  %mHR%    ; 04 
   Gui gHDLine:Add, Edit, vmQb    x248 y25 w50 h21 +Number +Center,  %mQb%    ; 05 
   Gui gHDLine:Add, Edit, vmQd    x303 y25 w50 h21 +Number +Center,  %mQd%    ; 06 
   Gui gHDLine:Add, Edit, vmArt   x358 y25 w50 h21         +Center,  %mArt%   ; 07 
   Gui gHDLine:Add, Edit, vmVen   x415 y25 w50 h21 +Number +Center,  %mVen%   ; 08 
   Gui gHDLine:Add, Edit, vmTMP   x472 y25 w50 h21         +Center, %mTMP%    ; 09 
   Gui gHDLine:Add, Edit, vmUFR   x531 y25 w50 h21         +Center, %mUFR%    ; 10 
   Gui gHDLine:Add, Edit, vmUF    x587 y25 w50 h21         +Center, %mUF%     ; 11 UF
   Gui gHDLine:Add, Edit, vmTemp  x646 y25 w50 h21         +Center, %mTemp%   ; 12 Temp
   Gui gHDLine:Add, Edit, vmCond  x699 y25 w50 h21         +Center, %mCond%   ; 13 Cond
  

   Gui gHDLine:Add, Edit, vmHDLineComment    x15 y150 w800 h120 ; This can be entered by Win+Z or menuBar
   Gui gHDLine:Add, Button, x780 y05 w50 h32, &OK ; The label ButtonOK (if it exists) will be run when the button is pressed.
   Gui gHDLine:Add, Button, x780 y35 w50 h32, &Exit ; The label ButtonExit (if it exists) will be run when the button is pressed.
   Gui gHDLine:Add, Edit, vmHepPumpRate x320 y80 w50 h21  +Center,  %mHepPumpRate%
   Gui gHDLine:Add, Edit, vmHepPumpVol   x380 y80 w50 h21  +Center,  %mHepPumpVol%
   Gui gHDLine:Add, Edit, vmDate    x27 y80 w100 h21  +Center , %mDate%
   
;   Return
}

   Menu, PatientPositionMenu, Add, Seated in recliner back up feet up, Position
   Menu, PatientPositionMenu, Add, Seated in recliner back down feet up, Position
   Menu, PatientPositionMenu, Add, Seated in recliner back up feet down, Position
   Menu, PatientPositionMenu, Add, Recliner back down feet down, Position
   Menu, PatientPositionMenu, Add, In bed recumbent supine position, Position
   Menu, PatientPositionMenu, Add, Sitting in bed, Position
   Menu, PatientPositionMenu, Add, Feet down, Position
   Menu, PatientPositionMenu, Add, {Space} , Position
  

; This is the Main menu I open with Win-Z need to set it to the MenuBar
;   Menu, PatientResponseMenu, Add, Position, :PatientPositionMenu
   Menu, PatientResponseMenu, Add, Resting, Resting
   Menu, PatientResponseMenu, Add, Watching TV, TV
   Menu, PatientResponseMenu, Add, Eyes Closed, Eyes
   Menu, PatientResponseMenu, Add, Using Laptop, Laptop
   Menu, PatientResponseMenu, Add, Using PC, PC
   Menu, PatientResponseMenu, Add, Reading, Reading
   Menu, PatientResponseMenu, Add, Using cell phone, Cell
   Menu, PatientResponseMenu, Add  ; Separater line
   Menu, PatientResponseMenu, Add, Start with CVC, CStart
   Menu, PatientResponseMenu, Add, Start with Needles, NStart
   Menu, PatientResponseMenu, Add  ; Separater line
   Menu, PatientResponseMenu, Add, End with CVC, CEnd
   Menu, PatientResponseMenu, Add, End with Needles, NEnd

 ;  Menu, PatientResponseMenu, Add ; Add a separator line
 ;  Menu, PatientResponseMenu, Add, Change autoentry Password, Password

;/*
; Create the submenus for the menu bar:
Menu, FileMenu, Add, &New, FileNew
Menu, FileMenu, Add, &Open, FileOpen
Menu, FileMenu, Add, &Save, FileSave
Menu, FileMenu, Add, Save &As, FileSaveAs
Menu, FileMenu, Add  ; Separator line.
Menu, FileMenu, Add, E&xit, FileExit
Menu, HelpMenu, Add, &About, HelpAbout ; ok so this adds a choice on Help Menu called  About which then goes to Lable HelpAbout
Menu, AssessMenu, Add, Position, :PatientPositionMenu ;PreAssessment, HelpTest
Menu, AssessMenu, Add, PostAssessment, HelpTest

; Create the menu bar by attaching the submenus to it:
; Menu, MainMenuBar, Add, &File, :FileMenu ; the Menu here is called MainMenuBar it has choices File that goes to subMenu FileMenu above
;  Menu, MainMenuBar, Add, &Assessment, :AssessMenu
Menu, MainMenuBar, Add, &PatientPosition, :PatientPositionMenu
Menu, MainMenuBar, Add, &Comment, :PatientResponseMenu
; Menu, MainMenuBar, Add, A&ssist, :PostAssessment
Menu, MainMenuBar, Add, &Help, :HelpMenu

; Attach the menu bar to the window:
Gui gHDLine:Menu, MainMenuBar
; Create the main Edit control and display the window: 

Gui gHDLine:+Resize  ; Make the window resizable.
; Gui, Add, Edit, vMainEdit WantTab W600 R20
; ShowgHDL: copied from above
	; Show the GUI to enter data from HDLine
Gui gHDLine:Show, xCenter y5 w900 h300,  Hemodialysis Data Entry              %mUser% 

CurrentFileName := ""  ; Indicate that there is no current file.
return

FileNew:
GuiControl,, MainEdit  ; Clear the Edit control.
return

FileOpen:
Gui +OwnDialogs  ; Force the user to dismiss the FileSelectFile dialog before returning to the main window.
FileSelectFile, SelectedFileName, 3,, Open File, Text Documents (*.txt)
if not SelectedFileName  ; No file selected.
    return
Gosub FileRead
return

FileRead:  ; Caller has set the variable SelectedFileName for us.
FileRead, MainEdit, %SelectedFileName%  ; Read the file's contents into the variable.
if ErrorLevel
{
    MsgBox Could not open "%SelectedFileName%".
    return
}
GuiControl,, MainEdit, %MainEdit%  ; Put the text into the control.
CurrentFileName := SelectedFileName
Gui, Show,, %CurrentFileName%   ; Show file name in title bar.
return

FileSave:
if not CurrentFileName   ; No filename selected yet, so do Save-As instead.
    Goto FileSaveAs
Gosub SaveCurrentFile
return

FileSaveAs:
Gui +OwnDialogs  ; Force the user to dismiss the FileSelectFile dialog before returning to the main window.
FileSelectFile, SelectedFileName, S16,, Save File, Text Documents (*.txt)
if not SelectedFileName  ; No file selected.
    return
CurrentFileName := SelectedFileName
Gosub SaveCurrentFile
return

SaveCurrentFile:  ; Caller has ensured that CurrentFileName is not blank.
if FileExist(CurrentFileName)
{
    FileDelete %CurrentFileName%
    if ErrorLevel
    {
        MsgBox The attempt to overwrite "%CurrentFileName%" failed.
        return
    }
}
GuiControlGet, MainEdit  ; Retrieve the contents of the Edit control.
FileAppend, %MainEdit%, %CurrentFileName%  ; Save the contents to the file.
; Upon success, Show file name in title bar (in case we were called by FileSaveAs):
Gui, Show,, %CurrentFileName%
return

HelpAbout:
Gui, About:+ownergHDLine  ; Make the main window (Gui #1) the owner of the "about box".
Gui +Disabled  ; Disable main window.
Gui, About:Add, Text,, Now I say this.
Gui, About:Add, Button, Default, OK
Gui, About:Show
return

HelpTest:  ; this is the submenu I created
Gui, About:+ownergHDLine  ; Make the main window (Gui #1) the owner of the "about box".
Gui +Disabled  ; Disable main window.
Gui, About:Add, Text,, You are hopeless.
Gui, About:Add, Button, Default, OK
Gui, About:Show
return

AboutButtonOK:  ; This section is used by the "about box" above.
AboutGuiClose:
AboutGuiEscape:
Gui, 1:-Disabled  ; Re-enable the main window (must be done prior to the next step).
Gui Destroy  ; Destroy the about box.
return

GuiDropFiles:  ; Support drag & drop.
Loop, Parse, A_GuiEvent, `n
{
    SelectedFileName := A_LoopField  ; Get the first file only (in case there's more than one).
    break
}
Gosub FileRead
return

GuiSize:
if (ErrorLevel = 1)  ; The window has been minimized. No action needed.
    return
; Otherwise, the window has been resized or maximized. Resize the Edit control to match.
NewWidth := A_GuiWidth - 20
NewHeight := A_GuiHeight - 20
GuiControl, Move, MainEdit, W%NewWidth% H%NewHeight%
return

FileExit:     ; User chose "Exit" from the File menu.
GuiClose:  ; User closed the window.
; ExitApp
Return
}
Return