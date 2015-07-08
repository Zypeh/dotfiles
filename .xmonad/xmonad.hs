import XMonad
import Control.Monad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName


import XMonad.Util.Run (spawnPipe)
import XMonad.Util.EZConfig (additionalKeys, additionalMouseBindings)
import XMonad.Util.SpawnOnce
import XMonad.Util.Loggers


import qualified XMonad.StackSet as W
import qualified Data.Map as M
import GHC.IO.Handle.Types as H


import XMonad.Layout.Spacing
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile


import XMonad.Actions.CycleWS (prevWS, nextWS)


import System.IO

i = " ^i(/home/hans/.xmonad/xbm/"

myws :: [String]
myws = clickable $ [ i ++ "term.xbm) TERM"
       		   , i ++ "cat.xbm) WEB"
		   , i ++ "edit2.xbm) INFO"
		   , i ++ "pacman2.xbm) FILE"
		   , i ++ "diskette.xbm) WORK"
		   ]
	where clickable l = [ "^ca(1,xdotool key super+" ++ show (n) ++ ")" ++ ws ++ "^ca()" | (i,ws) <- zip [1..] l, let n = i ]

keybindings = [ ((mod4Mask, xK_Return), spawn "urxvt")
	      	, ((mod4Mask, xK_Left), prevWS)
		, ((mod4Mask, xK_Right), nextWS)
		, ((mod4Mask, xK_Up), sendMessage MirrorExpand)
		, ((mod4Mask, xK_Down), sendMessage MirrorShrink)
		, ((mod4Mask .|. shiftMask, xK_r), spawn "killall dzen2 && xmonad --restart")
		]

-- color --
black = "#333333"
grey1 = "#BFBFBF"
grey2 = "#7B7B7B"
grey3 = "#EEEEEE"
grey5 = "#DCDCDC"
grey7 = "#194350"
white = "#FFFFFF"
blue1 = "#60B0D2"
blue2 = "#5C86FF"
blue3 = "#30B1B8"
pink1 = "#E38179"
navy1 = "#02151B"
navy2 = "#46B0B3"
navy3 = "#317876"
redd1 = "#B84130"

logBar h = do
       	 dynamicLogWithPP $ tryPP h

tryPP :: Handle -> PP
tryPP h = defaultPP
      	{ ppOutput = hPutStrLn h
	, ppCurrent = dzenColor (white) (redd1) . pad
	, ppVisible = dzenColor (white) (navy1) . pad
	, ppHidden = dzenColor (white) (navy1) . pad
	, ppHiddenNoWindows = dzenColor (grey7) (navy1) . pad
	, ppUrgent = dzenColor (blue1) (navy1) . pad
	, ppWsSep = ""
	, ppOrder = \(ws:l:t:_) -> [ws,l]
	, ppSep = ""
	, ppLayout = dzenColor (white) (blue3) .
	  ( \t -> case t of
	       "Spacing 2 Tall" -> "  " ++ k ++ "tile.xbm) TILE  "
	       )
	}
	where k = "^i(/home/hans/.xmonad/ws/"

font = "SourceCodePro 1m-8:Bold"

res = ResizableTall 1 (2/100) (1/2) []
ful = noBorders (fullscreenFull Full)

-- Func --

main = do
     panel <- spawnPipe top
     panel2 <- spawnPipe "sh /home/hans/.xmonad/scripts/rock.sh"
     xmonad $ defaultConfig
     	    { manageHook = manageDocks <+> manageHook defaultConfig
	    , layoutHook = avoidStruts (spacing 2 $ layoutHook defaultConfig ||| res) ||| ful
	    , modMask = mod4Mask
	    , focusedBorderColor = "#b84130"
	    , normalBorderColor = "#02151B"
	    , borderWidth = 4
	    , workspaces = myws
	    , terminal = "urxvt"
	    , startupHook = setWMName "Symbolic"
	    , logHook = logBar panel
	    } `additionalKeys` keybindings
	    where top = "dzen2 -p -ta r -e 'button3=' -fn'"
	    	      	++ font ++ "' -fg '" ++ black ++ "' -bg '" ++ navy1 ++ "'-x 400 -w 966" ++ " -h 22"