#Include VLCHTTP2.ahk
#Include httpQuery-0-3-6.ahk

Gui, Add, Button, x10 y10 w50 gVolDn, VolDn
Gui, Add, Button, x+5 w50 gStop, Stop
Gui, Add, Button, x+5 gPlay, Play
Gui, Add, Button, x+5 gVolUp, VolUp
Gui, Show
Return

VolDn:
VLCHTTP2_VolumeDown(10)
; Turn volume down by 10 out of 1024.
Return

Stop:
VLCHTTP2_Stop()
Return

Play:
; VLCHTTP2_Play()
cmd = "http://127.0.0.1:8080/requests/status.xml?command=pl_play"
httpQuery(cmd)
Return

VolUp:
VLCHTTP2_VolumeUp(10)
; Turn volume Up by 10 out of 1024.
Return