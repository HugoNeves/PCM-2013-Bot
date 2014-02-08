;;;;;;;;;;;;;;;; VARIABLES ;;;;;;;;;;;;;;;;

;; BUTTONS, COLORS AND POSITIONS
; MULTIPLAYER BUTTON
colorBtnMultiplayer := 0x40CDF6
posBtnMultiplayerX := 815
posBtnMultiplayerY := 122

; CONNECTION WITH THE SERVER HAS FAILED
colorBtnConnectionHasFailed := 0x22E6FE
posBtnConnectionHasFailedX := 1014
posBtnConnectionHasFailedY := 582

; YOU WERE DISCONNECTED / PROFILE ALREADY CONNECTED
colorBtnYouWereDisconnected := 0x22E6FE
posBtnYouWereDisconnectedX := 1008
posBtnYouWereDisconnectedY := 567

; GAME PORTS/YOU LEFT EARLY BUTTON
colorBtnGamePorts := 0x22E6FE
posBtnGamePortsX := 930
posBtnGamePortsY := 686

; STAGE BUTTON
colorBtnStage := 0x3CB9DD
posBtnStageX := 531
posBtnStageY := 127

; PLAY BUTTON
colorBtnPlay := 0x22E6FE
posBtnPlayX := 318
posBtnPlayY := 83

; LOOK FOR A GAME BUTTON
colorBtnLookGame := 0x22E6FE
posBtnLookGameX := 814
posBtnLookGameY := 185

; LOOKING FOR A GAME IN PROGRESS
colorLookInProgress := 0x3D3D3D
posLookInProgressX := 948
posLookInProgressY := 46

; MAIN MENU BUTTON
colorBtnMainMenu := 0x10CDFC
posBtnMainMenuX := 1765
posBtnMainMenuY := 43

; QUIT GAME BUTTON
colorBtnQuitGame := 0x5DDFFE
posBtnQuitGameX := 1891
posBtnQuitGameY := 43

; CONFIRM QUIT GAME BUTTON
colorBtnConfirmQuitGame := 0x22E6FE
posBtnConfirmQuitGameX := 893
posBtnConfirmQuitGameY := 569

; CHECK IF INGAME
colorChkInGame := 0x22E6FE

posChkInGame1X := 165
posChkInGame1Y := 82

posChkInGame2X := 586
posChkInGame2Y := 82

posChkInGame3X := 586
posChkInGame3Y := 1046

; PREVIOUS POINTS IN GAME
posPreviousPoint1X := 475
posPreviousPoint1Y := 240

posPreviousPoint2X := 1014
posPreviousPoint2Y := 213

posPreviousPoint3X := 1690
posPreviousPoint3Y := 153

posPreviousPoint4X := 984
posPreviousPoint4Y := 1006

; QUIT REPLAY BUTTON (AT REPLAY)
colorBtnQuitReplay := 0x22E6FE
posBtnQuitReplayX := 786
posBtnQuitReplayY := 605

; NEXT BUTTON
colorBtnNext := 0x07D4FA
posBtnNextX := 1746
posBtnNextY := 1048

; QUIT BUTTON
colorBtnQuit := 0x01CCFA
posBtnQuitX := 1757
posBtnQuitY := 1052

; OK BUTTON (AFTER FINISHING)
colorBtnOkAfterFinishing := 0x22E6FE
posBtnOkAfterFinishingX := 848
posBtnOkAfterFinishingY := 688

; GAME ERRORS
; TODO

;; GAME STATE VARIABLES
run := "true"
state := "stopped"
stageFound := "false"
previousTime := A_Now
currentTime :=
previousPointColor1 :=
previousPointColor2 :=
previousPointColor3 :=
previousPointColor4 :=

;;;;;;;;;;;;;;;; END OF VARIABLES ;;;;;;;;;;;;;;;;

;; AUXILIARY FUNCTIONS
MoveAndGetColorAt(posX, posY)
{
	MouseMove, posX, posY
	Sleep, 1000
	PixelGetColor, colorAtPos, posX, posY
	
	return %colorAtPos%
}

ClickAndSleep(posX, posY, sleepTime, msg, doLog)
{
	Click, posX,posY
	LogMessage(msg, doLog)
	Sleep, sleepTime
}

LogMessage(msg, doLog)
{
	if (doLog = "true")
	{
		FormatTime, Time,, dd/MM/yyyy HH:mm:ss
		FileAppend, %Time% - %msg%`n, PCM 2013 BotLog.txt
	}
}
;; END OF AUXILIARY FUNCTIONS

;;;;;;;;;;;;;;;; RUNNING BOT CODE ;;;;;;;;;;;;;;;;
#z::
MsgBox, Bot started!
LogMessage("Bot started", "true")

Loop
{
	if (run = "false")
		break
		
	Process, Exist, PCM.exe
	{
		If ! ErrorLevel ; Game is off
		{
			
			LogMessage("Game is off, turning game on", "true")
			Run, "F:\Jogos\Steam\SteamApps\common\Pro Cycling Manager 2013\Pro Cycling Manager 2013"
			state := "stopped"
			LogMessage("State -> stopped", "true")
			Sleep, 90000
		}
		else ; Game is on
		{
			WinActivate, Pro Cycling Manager 2013
			
			;; MULTIPLE DETECTIONS
			; Game errors
			; TODO
			
			;;;;;;;;;;;;;;;; STATE STOPPED ;;;;;;;;;;;;;;;;
			if (state = "stopped")
			{
				stageFound := "false"
				
				; Message you were disconnected OR profile already connected, clicking ok
				colorAtBtnYouWereDisconnected := MoveAndGetColorAt(posBtnYouWereDisconnectedX, posBtnYouWereDisconnectedY)
				if (colorAtBtnYouWereDisconnected = colorBtnYouWereDisconnected)
				{
					ClickAndSleep(posBtnYouWereDisconnectedX, posBtnYouWereDisconnectedY, 5000, "Clicking ok at being disconnected OR at profile being already connected", "false")
					Continue
				}
			
				; Main menu, clicking multiplayer
				colorAtPosBtnMultiplayer := MoveAndGetColorAt(posBtnMultiplayerX, posBtnMultiplayerY)
				if (colorAtPosBtnMultiplayer = colorBtnMultiplayer)
				{
					ClickAndSleep(posBtnMultiplayerX, posBtnMultiplayerY, 15000, "Clicking 'Multiplayer'", "false")
					Continue
				}
				
				; Main menu, message connection with server has failed, clicking ok
				colorAtPosBtnConnectionHasFailed := MoveAndGetColorAt(posBtnConnectionHasFailedX, posBtnConnectionHasFailedY)
				if (colorAtPosBtnConnectionHasFailed = colorBtnConnectionHasFailed)
				{
					ClickAndSleep(posBtnConnectionHasFailedX, posBtnConnectionHasFailedY, 5000, "Clicking 'Ok' at connection failed", "false")
					Continue
				}
				
				; Message test of game ports open, or message you left early, clicking ok
				colorAtPosBtnGamePorts := MoveAndGetColorAt(posBtnGamePortsX, posBtnGamePortsY)
				if (colorAtPosBtnGamePorts = colorBtnGamePorts)
				{
					ClickAndSleep(posBtnGamePortsX, posBtnGamePortsY, 5000, "Clicking 'Ok' at game ports or at you left early message", "false")
					Continue
				}

				; Multiplayer menu, clicking stage
				colorAtPosBtnStage := MoveAndGetColorAt(posBtnStageX, posBtnStageY)
				if (colorAtPosBtnStage = colorBtnStage)
				{
					ClickAndSleep(posBtnStageX, posBtnStageY, 30000, "Clicking 'Stage'", "false")
					Continue
				}
				
				; Play tab, clicking look for a game
				colorAtLookInProgress := MoveAndGetColorAt(posLookInProgressX, posLookInProgressY)
				colorAtBtnLookGame := MoveAndGetColorAt(posBtnLookGameX, posBtnLookGameY)
				if ((colorAtBtnLookGame = colorBtnLookGame) and (colorAtLookInProgress = colorLookInProgress))
				{
					previousTime := A_Now
					state := "searching"
					LogMessage("State -> searching", "true")
					ClickAndSleep(posBtnLookGameX, posBtnLookGameY, 300000, "Clicking 'Look for a game'", "true")
					Continue
				}

				; Safe check to verify if user started bot already searching for a game, but a stage was not found/loaded yet
				if ((colorAtBtnLookGame = colorBtnLookGame) and (colorAtLookInProgress != colorLookInProgress))
				{
					previousTime := A_Now
					state := "searching"
					LogMessage("State -> searching", "true")
					Continue
				}
				
				; Stages menu (outside or inside of play tab), clicking play
				colorAtPosBtnPlay := MoveAndGetColorAt(posBtnPlayX, posBtnPlayY)	
				if (colorAtPosBtnPlay = colorBtnPlay)
				{
					ClickAndSleep(posBtnPlayX, posBtnPlayY, 5000, "Clicking 'Play'", "false")
					Continue
				}
				
				; If everything above fails, will assume bot was started already in state searching or ingame. By defining state as searching, bot will automatically change to state ingame afterwards, if needed
				state := "searching"
				LogMessage("State -> searching", "true")
			}
			;;;;;;;;;;;;;;;; END OF STATE STOPPED ;;;;;;;;;;;;;;;;
			
			;;;;;;;;;;;;;;;; STATE SEARCHING ;;;;;;;;;;;;;;;;
			if (state = "searching")
			{
				; Check if found stage
				colorAtLookInProgress := MoveAndGetColorAt(posLookInProgressX, posLookInProgressY)
				colorAtChkInGame1 := MoveAndGetColorAt(posChkInGame1X, posChkInGame1Y)
				colorAtBtnLookGame := MoveAndGetColorAt(posBtnLookGameX, posBtnLookGameY)
				if ((colorAtLookInProgress != colorLookInProgress) and (colorAtChkInGame1 = colorChkInGame) and (colorAtBtnLookGame != colorBtnLookGame) and (stageFound = "false"))
				{
					previousTime := A_Now
					stageFound := "true"
					Continue
				}
				
				; Check if not in menu looking for a game
				colorAtChkInGame1 := MoveAndGetColorAt(posChkInGame1X, posChkInGame1Y)
				colorAtChkInGame2 := MoveAndGetColorAt(posChkInGame2X, posChkInGame2Y)
				colorAtChkInGame3 := MoveAndGetColorAt(posChkInGame3X, posChkInGame3Y)
				if ((colorAtChkInGame1 != colorChkInGame) or (colorAtChkInGame2 != colorChkInGame) or (colorAtChkInGame3 != colorChkInGame))
				{
					previousTime := A_Now
					state := "ingame"
					LogMessage("State -> ingame", "true")
					Continue
				}
			
				currentTime := A_Now
				EnvSub, currentTime, %previousTime%, minutes
				if (currentTime > 5) ; Too much time searching
				{
					; Clicking cancel
					colorAtBtnLookGame := MoveAndGetColorAt(posBtnLookGameX, posBtnLookGameY)
					if (colorAtBtnLookGame = colorBtnLookGame)
					{
						ClickAndSleep(posBtnLookGameX, posBtnLookGameY, 5000, "Clicking 'Cancel'", "false")
					}
					else ; This is just fucked up, closing game
					{
						LogMessage("Closing game", "true")
						WinClose, Pro Cycling Manager 2013
					}
					state := "stopped"
					LogMessage("State -> stopped", "true")
				}
			}
			;;;;;;;;;;;;;;;; END OF STATE SEARCHING ;;;;;;;;;;;;;;;;
			
			;;;;;;;;;;;;;;;; STATE INGAME ;;;;;;;;;;;;;;;;
			if (state = "ingame")
			{
				; Replay menu, clicking race results
				colorAtBtnQuitReplay := MoveAndGetColorAt(posBtnQuitReplayX, posBtnQuitReplayY)
				if (colorAtBtnQuitReplay = colorBtnQuitReplay)
				{
					ClickAndSleep(posBtnQuitReplayX, posBtnQuitReplayY, 5000, "Clicking 'Race results'", "false")
					Continue
				}
			
				; Journal news, clicking next
				colorAtBtnNext := MoveAndGetColorAt(posBtnNextX, posBtnNextY)
				if (colorAtBtnNext = colorBtnNext)
				{
					ClickAndSleep(posBtnNextX, posBtnNextY, 5000, "Clicking 'Next'", "false")
					Continue
				}
				
				; Race results, clicking quit
				colorAtBtnQuit := MoveAndGetColorAt(posBtnQuitX, posBtnQuitY)
				if (colorAtBtnQuit = colorBtnQuit)
				{
					ClickAndSleep(posBtnQuitX, posBtnQuitY, 30000, "Clicking 'Quit'", "false")
					Continue
				}
				
				; Coins results, clicking ok
				colorAtBtnOkAfterFinishing := MoveAndGetColorAt(posBtnOkAfterFinishingX, posBtnOkAfterFinishingY)
				if (colorAtBtnOkAfterFinishing = colorBtnOkAfterFinishing)
				{
					state := "stopped"
					LogMessage("State -> stopped", "true")
					ClickAndSleep(posBtnOkAfterFinishingX, posBtnOkAfterFinishingY, 5000, "Clicking 'Ok' at coins results", "false")
					Continue
				}
				
				; Safe check to verify if user clicked 'ok' in coins message
				colorAtChkInGame1 := MoveAndGetColorAt(posChkInGame1X, posChkInGame1Y)
				colorAtChkInGame2 := MoveAndGetColorAt(posChkInGame2X, posChkInGame2Y)
				colorAtChkInGame3 := MoveAndGetColorAt(posChkInGame3X, posChkInGame3Y)
				if ((colorAtChkInGame1 = colorChkInGame) and (colorAtChkInGame2 = colorChkInGame) and (colorAtChkInGame3 = colorChkInGame))
				{
					state := "stopped"
					LogMessage("State -> stopped", "true")
					Continue
				}
				
				; Check if it's time to check for changes 
				currentTime := A_Now
				EnvSub, currentTime, %previousTime%, minutes
				if (currentTime > 10) ; Time to check if points changed
				{
					previousTime := A_Now
					Send {Left 160}
					
					colorAtPosPreviousPoint1 := MoveAndGetColorAt(posPreviousPoint1X, posPreviousPoint1Y)
					colorAtPosPreviousPoint2 := MoveAndGetColorAt(posPreviousPoint2X, posPreviousPoint2Y)
					colorAtPosPreviousPoint3 := MoveAndGetColorAt(posPreviousPoint3X, posPreviousPoint3Y)
					colorAtPosPreviousPoint4 := MoveAndGetColorAt(posPreviousPoint4X, posPreviousPoint4Y)
					if ((colorAtPosPreviousPoint1 = previousPointColor1) and (colorAtPosPreviousPoint2 = previousPointColor2) and (colorAtPosPreviousPoint3 = previousPointColor3) and (colorAtPosPreviousPoint4 = previousPointColor4))
					{
						; This is just fucked up, closing game
						LogMessage("Closing game", "true")
						WinClose, Pro Cycling Manager 2013
						state := "stopped"
						LogMessage("State -> stopped", "true")
						Continue
					}
					else 
					{
						previousPointColor1 := colorAtPosPreviousPoint1
						previousPointColor2 := colorAtPosPreviousPoint2
						previousPointColor3 := colorAtPosPreviousPoint3
						previousPointColor4 := colorAtPosPreviousPoint4
					}
				}
				Sleep, 60000
			}
			;;;;;;;;;;;;;;;; END OF STATE INGAME ;;;;;;;;;;;;;;;;
		}
	}
	
	Sleep, 5000
}
return
;;;;;;;;;;;;;;;; RUNNING BOT CODE ;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;; STOPPING BOT CODE ;;;;;;;;;;;;;;;;
#x::
MsgBox, Bot stopped!
LogMessage("Bot stopped", "true")
run := "false"
return
;;;;;;;;;;;;;;;; STOPPING BOT CODE ;;;;;;;;;;;;;;;;