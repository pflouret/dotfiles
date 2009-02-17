--
-- xmonad example config file.
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--
 
import XMonad hiding ( (|||) )
import XMonad.Actions.CycleWS
import XMonad.Actions.FindEmptyWorkspace
import XMonad.Actions.FloatKeys
import XMonad.Actions.WindowNavigation
import XMonad.Hooks.DynamicLog hiding (shorten)
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.UrgencyHook
import XMonad.Layout.Gaps
import XMonad.Layout.Circle
import XMonad.Layout.LayoutCombinators
import XMonad.Layout.LayoutHints
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.ResizableTile
import XMonad.Layout.Reflect
import XMonad.Layout.Tabbed
import XMonad.Layout.TwoPane   
import XMonad.Layout.WorkspaceDir
import XMonad.ManageHook
import XMonad.Prompt
import XMonad.Prompt.AppLauncher as AL
import XMonad.Prompt.XMonad
import XMonad.Prompt.Shell
import XMonad.Prompt.Window
import XMonad.Prompt.Workspace
import XMonad.Util.EZConfig
import XMonad.Util.Run
-- import XMonad.Layout.Grid    
-- import XMonad.Layout.ShowWName   

import Graphics.X11
import System.Exit
import System.IO
 
import qualified Data.Map        as M
import qualified XMonad.StackSet as W

 
myTerminal      = "urxvtc"
myBorderWidth   = 1
myModMask       = mod4Mask
myWorkspaces = [ "1:web"
               , "2:im"
               , "3:term"
               , "4:code"
               , "5:five"
               , "6:six"
               , "7:seven"
               , "8:music"
               , "9:arr"] -- ++ map show [5..9]
myNormalBorderColor  = "#444444"
myFocusedBorderColor = "#ff0000"

myXPConfig = defaultXPConfig
    { font = "-*-terminus-*-*-*-*-*-*-*-*-*-*-*-*"
    , bgColor = "#111111"
    , fgColor = "DodgerBlue1"
    , fgHLight = "#111111"
    , bgHLight = "DodgerBlue2"
    -- , borderColor = "#151515"
    , promptBorderWidth = 0
    , position = Top 
    , height = 12
    , historySize = 200
    }

myTabConfig = defaultTheme
    { activeColor = "#333333"
    , inactiveColor = "#111111"
    , urgentColor = "#ff0000"
    , activeBorderColor = "#111111"
    , inactiveBorderColor = "#111111"
    , urgentBorderColor = "#00ffff"
    , activeTextColor = "#ffff00"
    , inactiveTextColor = "#aaaaaa"
    , urgentTextColor = "#000000"
    , fontName = "-*-nu-*-*-*-*-*-*-*-*-*-*-*-*"
    , decoHeight = 14
    }

myLayout = avoidStruts $ 
           gaps [(U,0),(D,16),(L,0),(R,0)] $ 
           workspaceDir "~" $
           smartBorders $
           onWorkspaces ["1:web", "8:music"] (myTabbed ||| Mirror tiled ||| tiled) $
           tiled ||| Mirror tiled ||| noBorders myTabbed -- ||| TwoPane (3/100) (1/2) 
           -- dragPane Vertical 0.1 0.5
           -- TwoPane (3/100) (1/2)
           -- Grid
           -- magnifier <blah>
  where
     -- tiled    = reflectHoriz $ ResizableTall nmaster delta ratio [] -- default tiling algorithm partitions the screen into two panes
     tiled    = ResizableTall nmaster delta ratio [] -- default tiling algorithm partitions the screen into two panes
     myTabbed = tabbed shrinkText myTabConfig
     nmaster  = 1 -- The default number of windows in the master pane
     ratio    = 1/2 -- Default proportion of screen occupied by master pane
     delta    = 1/100 -- Percent of screen to increment by when resizing panes
 
myMediaKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    [ ((0, 0x1008ff11), spawn "amixer -q sset PCM 12-") -- "aumix -v -2") -- XF86AudioLowerVolume
    , ((0, 0x1008ff12), spawn "amixer -q sset Master toggle ") -- "amixer -q set PCM toggle") -- XF86AudioMute
    , ((0, 0x1008ff13), spawn "amixer -q sset PCM 12+") -- "aumix -v +2") -- XF86AudioRaiseVolume
    , ((controlMask, 0x1008ff11), spawn "amixer -q sset PCM 24-") -- "aumix -v -2") -- XF86AudioLowerVolume
    , ((controlMask, 0x1008ff13), spawn "amixer -q sset PCM 24+") -- "aumix -v +2") -- XF86AudioRaiseVolume
    , ((0, 0x1008ff14), spawn "") -- XF86AudioPlay
    , ((0, 0x1008ff15), spawn "") -- XF86AudioStop
    , ((0, 0x1008ff16), spawn "") -- XF86AudioPrev
    , ((0, 0x1008ff17), spawn "") -- XF86AudioNext
    , ((0, 0x1008ff18), spawn "") -- XF86HomePage
    , ((0, 0x1008ff31), spawn "") -- XF86AudioPause
    , ((0, xK_Print),   spawn $ XMonad.terminal conf ++ " -e scrot -c -d 5 -e 'mv $f ~/crap/img/screenshots'")
    , ((modMask, xK_Print),spawn $ XMonad.terminal conf ++ " -e scrot -e 'mv $f ~/crap/img/screenshots'")
    , ((controlMask, xK_Print), spawn "gscreenshot")
    ]

myKeys = \conf -> mkKeymap conf $
    [ ("M-r",             spawn $ XMonad.terminal conf) -- launch a terminal
    , ("M-d",             spawn $ XMonad.terminal conf ++ " -e screen -RR") -- attach to some screen
    , ("M-S-d",           spawn $ XMonad.terminal conf ++ " -e screen") -- fresh screen
    , ("M-e",             spawn $ XMonad.terminal conf ++ " -e vifm")
    , ("M-S-e",           spawn "thunar")
    , ("M-t",             spawn $ XMonad.terminal conf ++ " -e htop")
    , ("M-a",             spawn "xscreensaver-command -lock") -- lock the screen
    , ("M-<Home>",        spawn "xmms2 toggleplay")
    , ("M-<End>",         spawn "xmms2 stop")
    , ("M-<Page_Up>",     spawn "xmms2 prev")
    , ("M-<Page_Down>",   spawn "xmms2 next")
    , ("M-<Left>",        spawn "xmms2 seek -5")
    , ("M-<Right>",       spawn "xmms2 seek +5")
    , ("M-<Up>",          spawn "xmms2 volume +3")
    , ("M-<Down>",        spawn "xmms2 volume -3")
    , ("M-x",             spawn "xmms2-notif.py -c")
    --
    , ("M-<Space>",       sendMessage NextLayout) -- Rotate through the available layout algorithms
    , ("M-S-<Space>",     setLayout $ XMonad.layoutHook conf) --  Reset the layouts on the current workspace to default
    , ("M-f",             sendMessage $ JumpToLayout "Tabbed Simplest")
    , ("M-S-n",           refresh) -- Resize viewed windows to the correct size
    --
    -- , ((modMask,                 xK_w     ), workspacePrompt myXPConfig W.moveTo)
    , ("M1-<F1>",         AL.launchApp myXPConfig $ XMonad.terminal conf ++ " -e")
    -- , ("M1-<F2>",         shellPrompt myXPConfig) -- cool^Wshitty run prompt
    , ("M1-<F2>",         spawn "gmrun")
    , ("M-g",             windowPromptGoto myXPConfig)
    , ("M-b",             windowPromptBring myXPConfig)
    -- , ("M-x",             xmonadPrompt myXPConfig)
    , ("M1-<F4>",         kill) -- close focused window 
    --
    , ("M-<Tab>",         toggleWS)
    , ("M-o",             moveTo Next NonEmptyWS)
    , ("M-i",             moveTo Prev NonEmptyWS)
    , ("M-S-o",           nextWS)
    , ("M-S-i",           prevWS)
    , ("M-y",             viewEmptyWorkspace)
    , ("M-S-y",           tagToEmptyWorkspace)
    --
    , ("M1-<Tab>",        windows W.focusDown)
    , ("M1-S-<Tab>",      windows W.focusUp)
    , ("M-k",             windows W.focusUp)
    , ("M-l",             windows W.focusDown)
    , ("M-j",             windows W.focusDown)

    , ("M-m",             windows W.focusMaster)
    , ("M-<Return>",      windows W.swapMaster)
    , ("M-S-k",           windows W.swapUp)
    , ("M-S-j",           windows W.swapDown)
    , ("M-<Backspace>",   focusUrgent)
    -- move/resize floats
    , ("M-C-h",           withFocused $ keysMoveWindow (-10,0))
    , ("M-C-j",           withFocused $ keysMoveWindow (0,10))
    , ("M-C-k",           withFocused $ keysMoveWindow (0,-10))
    , ("M-C-l",           withFocused $ keysMoveWindow (10,0))
    , ("M-M1-C-h",        withFocused $ keysResizeWindow (-10,0) (0,0))
    , ("M-M1-C-j",        withFocused $ keysResizeWindow (0,10) (1,0))
    , ("M-M1-C-k",        withFocused $ keysResizeWindow (0,-10) (0,0))
    , ("M-M1-C-l",        withFocused $ keysResizeWindow (10,10) (0,0))
    --
    , ("M-s",             withFocused $ windows . W.sink)
    , ("M-M1-h",          sendMessage Shrink)
    , ("M-M1-l",          sendMessage Expand)
    , ("M-M1-j",          sendMessage MirrorShrink)
    , ("M-M1-k",          sendMessage MirrorExpand)

    , ("M-S-,",           sendMessage (IncMasterN 1)) -- Increment the number of windows in the master area
    , ("M-S-.",           sendMessage (IncMasterN (-1))) -- Deincrement the number of windows in the master area
    --
    , ("M-S-q",           io (exitWith ExitSuccess)) -- Quit xmonad
    , ("M-q",             restart "xmonad" True) -- Restart xmonad
    ]
    ++
    [ (m ++ i, windows $ f j)
        | (i, j) <- zip (map show [1..9]) (XMonad.workspaces conf)
        , (m, f) <- [("M-", W.view), ("M-S-", W.shift)]
    ]

    -- ++
    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    -- [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
    --    | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
    --    , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
 
 
-- Mouse bindings: default actions bound to mouse events
myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $
 
    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modMask, button1), (\w -> focus w >> mouseMoveWindow w))
 
    -- mod-button2, Raise the window to the top of the stack
    , ((modMask, button2), (\w -> focus w >> windows W.swapMaster))
 
    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modMask, button3), (\w -> focus w >> mouseResizeWindow w))
 
    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]
 
-- Window rules:
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , className =? "Gscreenshot.py" --> doFloat
    , className =? "Zenity"         --> doFloat
    , className =? "Tilda"          --> doFloat
    , resource  =? "volwheel"       --> doFloat
    , resource  =? "xfontsel"       --> doFloat
    , className =? "Conky"          --> doIgnore
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
    , className =? "Opera"          --> doF (W.shift "1:web") 
    , className =? "Firefox"        --> doF (W.shift "1:web") 
    , className =? "Gran Paradiso"  --> doF (W.shift "1:web")
    , className =? "Gajim.py"       --> doF (W.shift "2:im") 
    , className =? "Skype"          --> doF (W.shift "2:im") 
    , resource  =? "foobar2000.exe" --> doF (W.shift "8:music") 
    , resource  =? "uTorrent.exe"   --> doF (W.shift "9:arr") 
    , className =? "Nicotine"       --> doF (W.shift "9:arr") 
    , title     =? "VLC (XVideo output)" --> doFloat
    ] -- <+> transience' <+> (doF avoidMaster)

avoidMaster :: W.StackSet i l a s sd -> W.StackSet i l a s sd
avoidMaster = W.modify' $ \c -> case c of
    W.Stack t [] (r:rs) -> W.Stack t [r] rs
    otherwise           -> c

-- myUrgencyHook = withUrgencyHook NoUrgencyHook
myUrgencyHook = withUrgencyHook dzenUrgencyHook
    { args = ["-x", "0", "-y", "1184", "-h", "16", "-w", "1600", "-ta", "r", "-expand", "l", "-fg", "#0099ff", "-bg", "#0f0f0f", "-fn", "-*-terminus-*-*-*-*-*-*-*-*-*-*-*-*"] }
 
shorten :: Int -> String -> String
shorten n xs | length xs < n = xs
             | otherwise     = (take (n - length end) xs) ++ end
 where
    end = "..."

myStatusBar = "dzen2 -bg '#111111' -fg '#eeeeee' -sa l -h 14 -fn '-*-nu-*-*-*-*-*-*-*-*-*-*-*' -e '' -xs 1 -ta l"

myDzenPP :: Handle -> PP
myDzenPP h = defaultPP 
    --{ ppCurrent = wrap "^fg(#000000)^bg(#a6c292)^p(2)" "^p(2)^fg()^bg()"
    { ppCurrent = wrap "^fg(yellow)" "^fg()"
    , ppVisible = wrap "^bg(grey30)^fg(grey75)" "^fg()^bg()"
    , ppUrgent  = wrap "^fg(black)^bg(red)" "^fg()^bg()"
    , ppSep     = " :: "
    , ppWsSep   = " "
    , ppLayout  = dzenColor "#eeeeee" "" .
                  (\x -> case x of
                            "Tall"                          -> "tile" -- "^i(/home/robert/dzen_bitmaps/tall.xbm)"
                            "Mirror Tall"                   -> "mtile" -- "^i(/home/robert/dzen_bitmaps/mtall.xbm)"
                            "ReflectX ResizableTall"        -> "tile"
                            "Mirror ReflectX ResizableTall" -> "mtile"
                            "ResizableTall"        -> "tile"
                            "Mirror ResizableTall" -> "mtile"
                            "Full"                          -> "full" -- "^i(/home/robert/dzen_bitmaps/full.xbm)"
                            "Tabbed Bottom Simplest"        -> "tab"
                            "Tabbed Simplest"               -> "tab"
                            _ -> x
                  )
    , ppTitle   = dzenColor "#bbbbbb" "" . wrap "[ " " ]" 
    , ppOutput   = hPutStrLn h
    }
 
-- Startup hook
-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
myStartupHook = return ()
 
-- The mask for the numlock key. Numlock status is "masked" from the
-- current modifier status, so the keybindings will work with numlock on or
-- off. You may need to change this on some systems.
--
-- You can find the numlock modifier by running "xmodmap" and looking for a
-- modifier with Num_Lock bound to it:
--
-- > $ xmodmap | grep Num
-- > mod2        Num_Lock (0x4d)
--
-- Set numlockMask = 0 if you don't have a numlock key, or want to treat
-- numlock status separately.
--
myNumlockMask   = mod2Mask
 
main = do
    din <- spawnPipe myStatusBar
    xmonad $ myUrgencyHook
           $ defaultConfig
           { terminal           = myTerminal
           , focusFollowsMouse  = False
           , borderWidth        = myBorderWidth
           , modMask            = myModMask
           , numlockMask        = myNumlockMask
           , workspaces         = myWorkspaces
           , normalBorderColor  = myNormalBorderColor
           , focusedBorderColor = myFocusedBorderColor
           , keys               = \c -> M.union (myKeys c) (myMediaKeys c)
           , mouseBindings      = myMouseBindings
           , layoutHook         = myLayout
           -- , layoutHook         = showWName myLayout
           , manageHook         = myManageHook
           , logHook            = dynamicLogWithPP $ myDzenPP din
           , startupHook        = myStartupHook
           }
    -- <- withWindowNavigation (xK_k, xK_h, xK_j, xK_l)
    -- xmonad config

