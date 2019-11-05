#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <WinApi.au3>
Global $RBOX_EVENT_CLOSE = 1
Global $ROUNDES = 20, $LastHwnd = 0
Global $GUIBKCOLOR = 0xEEC591
Global $ARRAY_COLOR_TOP_MIN[3] = [36 ,65 ,142] , $ARRAY_COLOR_TOP_MAX[3] = [11 ,42 ,122]

Local $hGui = RBoxCreate("Gui Design PHD",800,600)

While 1
CheckX($hGui,$RBOX_EVENT_CLOSE,"GuiCtrlSetColor("&$RBOX_EVENT_CLOSE&",0xA3A3A3)","GuiCtrlSetColor("&$RBOX_EVENT_CLOSE&",0x555555)")
$gMsg = GUIGetMsg()
Switch $gMsg
Case $RBOX_EVENT_CLOSE, $GUI_EVENT_CLOSE
Exit
EndSwitch
WEnd

Func RBoxCreate($Title,$width, $height ,$left=-1 ,$top=-1 ,$show=1)
Local $GUI = GUICreate($Title,$width,$height,$left,$top,$WS_POPUP)
GUISetBkColor($GUIBKCOLOR,$GUI)
_GuiRoundCorners($GUI,0,0,$ROUNDES,$ROUNDES)
$RBOX_EVENT_CLOSE = GUICtrlCreateLabel('X',$width-20,3,25,25)
GUICtrlSetCursor($RBOX_EVENT_CLOSE,0)
GUICtrlSetBkColor($RBOX_EVENT_CLOSE,-2)
GUICtrlSetFont($RBOX_EVENT_CLOSE,15,800)
GUICtrlSetColor($RBOX_EVENT_CLOSE,0x555555)
$Title &= " "
Local $hTitle = GUICtrlCreateLabel($Title,0,0,$width-20,26,$SS_CENTER,$GUI_WS_EX_PARENTDRAG)
GUICtrlSetFont($hTitle,17,400,0,"Consolas")
GUICtrlSetBkColor($hTitle,-2)
Local $Graphic = GUICtrlCreateGraphic (0,0, $width, 25)
GUICtrlSetState($Graphic,$Gui_DISABLE)
GradientFill($Graphic, 0, 0, $width, 25, $ARRAY_COLOR_TOP_MIN, $ARRAY_COLOR_TOP_MAX)
If $show = 1 Then GUISetState(@SW_SHOW,$GUI)
Return $GUI
EndFunc

Func CheckX($hGui, $CtrlID, $sCMD, $eCMD)
Local $cGui = GUIGetCursorInfo($hGui)
If Not IsArray($cGui) Then Return 0
if $LastHwnd <> $cGui[4] And $cGui[4] = $CtrlID Then Return Execute($sCMD) + Assign("LastHwnd",$cGui[4])
if $LastHwnd <> $cGui[4] Then Return Execute($eCMD) + Assign("LastHwnd",$cGui[4])
EndFunc


Func _GuiRoundCorners($h_win, $i_x1, $i_y1, $i_x3, $i_y3)
Dim $pos, $ret, $ret2
$pos = WinGetPos($h_win)
$ret = DllCall("gdi32.dll", "long", "CreateRoundRectRgn", "long", $i_x1, "long", $i_y1, "long", $pos[2], "long", $pos[3], "long", $i_x3, "long", $i_y3)
If $ret[0] Then
$ret2 = DllCall("user32.dll", "long", "SetWindowRgn", "hwnd", $h_win, "long", $ret[0], "int", 1)
If $ret2[0] Then
Return 1
Else
Return 0
EndIf
Else
Return 0
EndIf
EndFunc

Func GradientFill($im, $x1, $y1, $width, $height, $left_color, $right_color)

Local $color0=($left_color[0]-$right_color[0])/$height
Local $color1=($left_color[1]-$right_color[1])/$height
$color2=($left_color[2]-$right_color[2])/$height
For $Y=0 to $height-1

$red=$left_color[0]-floor($Y*$color0)
$green=$left_color[1]-floor($Y*$color1)
$blue=$left_color[2]-floor($Y*$color2)

$col = Dec(Hex($blue,2) & Hex($green,2) & Hex($red,2))

GUICtrlSetGraphic($im,$GUI_GR_COLOR, $col)
GUICtrlSetGraphic($im,$GUI_GR_MOVE,0,$Y)
GUICtrlSetGraphic($im,$GUI_GR_LINE,$width,$Y)
Next
GUICtrlSetGraphic($im,$GUI_GR_COLOR, 0x000000)
GUICtrlSetGraphic($im,$GUI_GR_MOVE,0,$height)
GUICtrlSetGraphic($im,$GUI_GR_LINE,$width,$height)
GUICtrlSetGraphic($im,$GUI_GR_REFRESH)
EndFunc