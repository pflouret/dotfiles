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
import XMonad.Actions.FloatKeys
import XMonad.Actions.WindowNavigation
import XMonad.Hooks.DynamicLog hiding (shorten)
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Layout.Gaps
-- import XMonad.Layout.HintedTile
import XMonad.Layout.Circle
import XMonad.Layout.LayoutCombinators
import XMonad.Layout.LayoutHints
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
import XMonad.Layout.WorkspaceDir
-- import XMonad.Layout.WindowNavigation
import XMonad.ManageHook
import XMonad.Prompt
import XMonad.Prompt.XMonad
import XMonad.Prompt.Shell
import XMonad.Prompt.Window
import XMonad.Prompt.Workspace
import XMonad.Util.EZConfig
import XMonad.Util.Run

import Graphics.X11
import System.Exit
import System.IO
 
import qualified Data.Map        as M
import qualified XMonad.StackSet as W
 
myTerminal      = "urxvtc"
myBorderWidth   = 1
myModMask       = mod4Mask
myWorkspaces = ["1:term", "2:web", "3:im", "4:arr" ] ++ map show [5..9]
myNormalBorderColor  = "#444444"
myFocusedBorderColor = "#ffff00"

myTabConfig = defaultTheme {
    activeColor = "#333333",
    inactiveColor = "#111111",
    urgentColor = "#ff0000",
    activeBorderColor = "#111111",
    inactiveBorderColor = "#111111",
    urgentBorderColor = "#00ffff",
    activeTextColor = "#ffff00",
    inactiveTextColor = "#aaaaaa",
    urgentTextColor = "#000000",
    fontName = "-*-nu-*-*-*-*-*-*-*-*-*-*-*-*",
    decoHeight = 14
}

-- myLayout = avoidStruts (gaps [(U,0),(D,16),(L,0),(R,0)] $ tiled ||| Mirror tiled ||| Full)
myLayout = avoidStruts $ 
           gaps [(U,0),(D,16),(L,0),(R,0)] $ 
           workspaceDir "~" $
           smartBorders $
           onWorkspace "2:web" (myTabbed ||| Mirror tiled ||| tiled) $
           tiled ||| Mirror tiled ||| noBorders myTabbed
  where
     tiled    = ResizableTall nmaster delta ratio [] -- default tiling algorithm partitions the screen into two panes
     myTabbed = tabbed shrinkText myTabConfig
     nmaster  = 1 -- The default number of windows in the master pane
     ratio    = 1/2 -- Default proportion of screen occupied by master pane
     delta    = 1/100 -- Percent of screen to increment by when resizing panes
 
--[ ("M-S-<Return>", spawn $ terminal c)
--, ("M-x w", spawn "xmessage 'woohoo!'")  -- type mod+x then w to pop up 'woohoo!'
--, ("M-x y", spawn "xmessage 'yay!'")     -- type mod+x then y to pop up 'yay!'
--, ("M-S-c", kill)
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
    ]

myKeys = \conf -> mkKeymap conf $
    [ ("M-r",             spawn $ XMonad.terminal conf) -- launch a terminal
    , ("M-t",             spawn $ XMonad.terminal conf ++ " -e screen -RR") -- attach to some screen
    , ("M-S-t",           spawn $ XMonad.terminal conf ++ " -e screen") -- fresh screen
    , ("M-e",             spawn $ XMonad.terminal conf ++ " -e lfm") -- attach to some screen
    , ("C-M1-l",          spawn "xscreensaver-command -lock") -- lock the screen
    , ("M-<Sys_Req>",     spawn "gscreenshot")
    , ("<Sys_Req>",       spawn "scrot")
    --
    , ("M-<Space>",       sendMessage NextLayout) -- Rotate through the available layout algorithms
    , ("M-S-<Space>",     setLayout $ XMonad.layoutHook conf) --  Reset the layouts on the current workspace to default
    , ("M-f",             sendMessage $ JumpToLayout "Tabbed Simplest")
    , ("M-S-n",           refresh) -- Resize viewed windows to the correct size
    --
    -- , ((modMask,                 xK_w     ), workspacePrompt myXPConfig W.moveTo)
    , ("M1-<F2>",         shellPrompt myXPConfig) -- cool run prompt
    , ("M-g",             windowPromptGoto myXPConfig)
    , ("M-b",             windowPromptBring myXPConfig)
    , ("M-x",             xmonadPrompt myXPConfig)
    , ("M1-<F4>",         kill) -- close focused window 
    --
    , ("M-<Tab>",         toggleWS)
    , ("M-o",             moveTo Next NonEmptyWS)
    , ("M-i",             moveTo Prev NonEmptyWS)
    --
    , ("M1-<Tab>",        windows W.focusDown) -- Move focus to the next window
    , ("M1-S-<Tab>",      windows W.focusUp) -- Swap the focused window with the next window
    , ("M-m",             windows W.focusMaster) -- Move focus to the master window
    , ("M-<Return>",      windows W.swapMaster) -- Swap the focused window and the master window
    , ("M-S-j",           windows W.swapDown) -- Swap the focused window with the next window
    , ("M-S-k",           windows W.swapUp) -- Swap the focused window with the previous window
    , ("M-<Backspace>",   focusUrgent) -- Move focus to the master window
    -- move/resize floats
    , ("M-C-h",           withFocused $ keysMoveWindow (-10,0))
    , ("M-C-j",           withFocused $ keysMoveWindow (0,10))
    , ("M-C-k",           withFocused $ keysMoveWindow (0,-10))
    , ("M-C-l",           withFocused $ keysMoveWindow (10,0))
    , ("M-M1-C-k",        withFocused $ keysResizeWindow (10,10) (1,1))
    , ("M-M1-C-j",        withFocused $ keysResizeWindow (-10,-10) (1,1))
    --
    , ("M-s",             withFocused $ windows . W.sink)
    , ("M-M1-h",          sendMessage Shrink) -- Shrink the master area
    , ("M-M1-l",          sendMessage Expand) -- Expand the master area
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
 
 
------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $
 
    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modMask, button1), (\w -> focus w >> mouseMoveWindow w))
 
    -- mod-button2, Raise the window to the top of the stack
    , ((modMask, button2), (\w -> focus w >> windows W.swapMaster))
 
    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modMask, button3), (\w -> focus w >> mouseResizeWindow w))
 
    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]
 
------------------------------------------------------------------------
-- Window rules:
 
-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "MPlayer1"       --> doFloat
    , className =? "Gimp"           --> doFloat
    -- , title     =? "VLC media player" --> doFloat
    , resource  =? "volwheel"       --> doFloat
    , resource  =? "xfontsel"       --> doFloat
    , className =? "Conky"          --> doIgnore
    , className =? "trayer"         --> doIgnore
    , resource  =? "stalonetray"    --> doIgnore
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
    , className =? "Opera"          --> doF (W.shift "2:web") 
    ] -- <+> manageDocks

-- Urgency hint options:
myUrgencyHook = withUrgencyHook NoUrgencyHook
-- myUrgencyHook = withUrgencyHook dzenUrgencyHook
--     { args = ["-x", "0", "-y", "1184", "-h", "16", "-w", "1600", "-ta", "r", "-expand", "l", "-fg", "#0099ff", "-bg", "#0f0f0f", "-fn", "-xos4-terminus-medium-r-normal-*-14-*-*-*-c-*-iso10646-1"] }
 
-- XPConfig options:
myXPConfig = defaultXPConfig
    { font = "-*-terminus-*-*-*-*-*-*-*-*-*-*-*-*"
    , bgColor = "#111111"
    , fgColor = "#00ff00"
    , fgHLight = "#111111"
    , bgHLight = "#00ff00"
    , borderColor = "#111111"
    , promptBorderWidth = 1
    , position = Top 
    , height = 12
    , historySize = 200
    }

shorten :: Int -> String -> String
shorten n xs | length xs < n = xs
             | otherwise     = (take (n - length end) xs) ++ end
 where
    end = "..."

myStatusBar = "dzen2 -bg '#111111' -fg '#eeeeee' -sa l -fn '-*-nu-*-*-*-*-*-*-*-*-*-*-*' -e '' -xs 1 -ta l"

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
                            "Tall"                   -> "tile" -- "^i(/home/robert/dzen_bitmaps/tall.xbm)"
                            "Mirror Tall"            -> "mtile" -- "^i(/home/robert/dzen_bitmaps/mtall.xbm)"
                            "ResizableTall"          -> "tile"
                            "Mirror ResizableTall"   -> "mtile"
                            "Full"                   -> "full" -- "^i(/home/robert/dzen_bitmaps/full.xbm)"
                            "Tabbed Bottom Simplest" -> "tab"
                            "Tabbed Simplest"        -> "tab"
                            _ -> x
                  )
    , ppTitle   = dzenColor "#bbbbbb" "" . wrap "< " " >" 
    , ppOutput   = hPutStrLn h
    }
{-
myLogHook h = do
  dynamicLogWithPP $ xmobPP h 
  
xmobPP :: Handle -> PP
xmobPP h = defaultPP  { ppCurrent = wrap "<fc=black,yellow3> " " </fc>" 
                     , ppSep     = ""
                     , ppWsSep = ":"
                     , ppVisible = wrap "<fc=black,DarkSlateGray4> " " </fc>" 
                     , ppTitle = \x -> case length x of
                                         0 -> ""
                                         _ -> "<fc=green2,black>" ++ shorten 83 x ++ "</fc>"
                     , ppLayout = \x -> "<fc=yellow2,black> | "
                                  ++ case x of
                                       "Tall"                   -> "tiled"
                                       "Mirror ResizableTall"   -> "mtiled"
                                       "ResizableTall"          -> "tiled"
                                       "Full"                   -> "full"
                                       "Tabbed Bottom Simplest" -> "tabbed"
                                       "Tabbed Simplest"        -> "tabbed"
                                       _                        -> x
                                  ++ " ::</fc> "
                     , ppHidden = wrap " " " "
                     , ppUrgent = wrap "<fc=black,red>" "</fc>"
                     -- , ppOrder  = reverse
                     , ppOutput = hPutStrLn h
                     }
-}
 
------------------------------------------------------------------------
-- Startup hook
 
-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
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
    config <- withWindowNavigation (xK_k, xK_h, xK_j, xK_l)
            $ myUrgencyHook
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
            , manageHook         = myManageHook
            , logHook            = dynamicLogWithPP $ myDzenPP din
            , startupHook        = myStartupHook
            }
    xmonad config
